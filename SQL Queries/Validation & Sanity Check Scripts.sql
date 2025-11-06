-- Validation (Sanity Checks)
-- Counts
SELECT 
 (SELECT COUNT(*) FROM Teams) AS Teams,
 (SELECT COUNT(*) FROM Players) AS Players,
 (SELECT COUNT(*) FROM Matches) AS Matches,
 (SELECT COUNT(*) FROM PlayerMatchStats) AS PlayerMatchStats,
 (SELECT COUNT(*) FROM TrainingSessions) AS TrainingSessions,
 (SELECT COUNT(*) FROM WellnessSnapshots) AS WellnessSnapshots,
 (SELECT COUNT(*) FROM Injuries) AS Injuries;

-- Orphans
SELECT COUNT(*) AS OrphanPlayersTeams
FROM Players p LEFT JOIN Teams t ON p.TeamID=t.TeamID WHERE t.TeamID IS NULL;

SELECT COUNT(*) AS OrphanPMS_Match
FROM PlayerMatchStats s LEFT JOIN Matches m ON s.MatchID=m.MatchID WHERE m.MatchID IS NULL;

SELECT COUNT(*) AS OrphanPMS_Player
FROM PlayerMatchStats s LEFT JOIN Players p ON s.PlayerID=p.PlayerID WHERE p.PlayerID IS NULL;

-- Logical checks
SELECT TOP 50 * FROM Injuries WHERE RecoveryDate < InjuryDate;
SELECT TOP 50 * FROM PlayerMatchStats WHERE MinutesPlayed NOT BETWEEN 0 AND 120;

-- Distributions
SELECT Position, COUNT(*) AS Cnt, AVG(Age) AvgAge FROM Players GROUP BY Position;
SELECT Severity, COUNT(*) Cnt, AVG(DaysOut) AvgDays FROM Injuries GROUP BY Severity;

-- Analytical Views (for EDA & BI)
-- v1: Player season workload & performance
GO
CREATE OR ALTER VIEW vw_PlayerSeasonPerformance AS
SELECT 
  p.PlayerID, p.PlayerName, p.Position, p.TeamID,
  YEAR(m.Date) AS SeasonYear,
  COUNT(DISTINCT m.MatchID) AS MatchesPlayed,
  SUM(s.MinutesPlayed) AS TotalMinutes,
  AVG(s.MatchRating) AS AvgRating,
  SUM(s.DistanceCoveredKM) AS TotalMatchDistanceKM,
  SUM(s.Sprints) AS TotalSprints,
  SUM(CASE WHEN i.InjuryID IS NULL THEN 0 ELSE 1 END) AS InjuryEvents
FROM Players p
LEFT JOIN PlayerMatchStats s ON s.PlayerID=p.PlayerID
LEFT JOIN Matches m ON m.MatchID=s.MatchID
LEFT JOIN Injuries i ON i.PlayerID=p.PlayerID AND YEAR(i.InjuryDate)=YEAR(m.Date)
GROUP BY p.PlayerID, p.PlayerName, p.Position, p.TeamID, YEAR(m.Date);
GO

-- v2: Acute:Chronic workload ratio proxy (per player-week)
GO
CREATE OR ALTER VIEW vw_PlayerWeeklyACWR AS
WITH T AS (
  SELECT PlayerID, Date, DistanceKM + (DurationMinutes/60.0)*0.5 AS Load
  FROM TrainingSessions
),
D AS (
  SELECT PlayerID, Date, Load,
         SUM(Load) OVER (PARTITION BY PlayerID ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Acute7,
         SUM(Load) OVER (PARTITION BY PlayerID ORDER BY Date ROWS BETWEEN 27 PRECEDING AND CURRENT ROW) AS Chronic28
  FROM T
)
SELECT 
  PlayerID, Date,
  Acute7, Chronic28,
  CASE WHEN Chronic28>0 THEN Acute7/Chronic28 ELSE NULL END AS ACWR
FROM D;
GO

-- v3: Wellness weekly summary
GO
CREATE OR ALTER VIEW vw_PlayerWellnessWeekly AS
SELECT 
  PlayerID,
  DATEADD(day, -DATEPART(weekday, SnapshotDate)+1, SnapshotDate) AS WeekStart,
  AVG(SleepHours) AvgSleep,
  AVG(StressLevel) AvgStress,
  AVG(MuscleSoreness) AvgSoreness,
  AVG(HydrationLevel) AvgHydration,
  AVG(RecoveryScore) AvgRecovery
FROM WellnessSnapshots
GROUP BY PlayerID, DATEADD(day, -DATEPART(weekday, SnapshotDate)+1, SnapshotDate);
GO