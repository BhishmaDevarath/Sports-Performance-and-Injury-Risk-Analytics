-- DataBase Creation
CREATE DATABASE SportDataDB
GO

USE SportDataDB
GO

-- Table Creation
-- Players Table
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    PlayerName NVARCHAR(100),
    Position NVARCHAR(50),
    Age INT,
    HeightCM DECIMAL(5,2),
    WeightKG DECIMAL(5,2),
    DominantFoot NVARCHAR(10),
    Nationality NVARCHAR(50),
    TeamID INT,
    InjuryProneScore DECIMAL(4,2)
);

-- Teams Table
CREATE TABLE Teams (
    TeamID INT PRIMARY KEY,
    TeamName NVARCHAR(100),
    League NVARCHAR(100),
    Coach NVARCHAR(100),
    AvgTrainingLoad DECIMAL(5,2),
    AvgInjuryRate DECIMAL(5,2)
);

-- Matches Table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    Date DATE,
    Opponent NVARCHAR(100),
    Venue NVARCHAR(50),
    Weather NVARCHAR(50),
    PitchCondition NVARCHAR(50),
    Result NVARCHAR(10),
    TeamID INT FOREIGN KEY REFERENCES Teams(TeamID)
);

-- PlayerMatchStats Table
CREATE TABLE PlayerMatchStats (
    StatID INT PRIMARY KEY,
    MatchID INT FOREIGN KEY REFERENCES Matches(MatchID),
    PlayerID INT FOREIGN KEY REFERENCES Players(PlayerID),
    MinutesPlayed INT,
    DistanceCoveredKM DECIMAL(5,2),
    Sprints INT,
    AvgHeartRate INT,
    MaxSpeedKMH DECIMAL(5,2),
    PassAccuracyPct DECIMAL(5,2),
    ShotsOnTarget INT,
    Tackles INT,
    Fouls INT,
    YellowCards INT,
    RedCards INT,
    MatchRating DECIMAL(4,2)
);

-- TrainingSessions Table
CREATE TABLE TrainingSessions (
    SessionID INT PRIMARY KEY,
    PlayerID INT FOREIGN KEY REFERENCES Players(PlayerID),
    Date DATE,
    DurationMinutes INT,
    DistanceKM DECIMAL(5,2),
    AvgHeartRate INT,
    IntensityLevel NVARCHAR(20),
    RPE DECIMAL(4,2),  -- Rate of Perceived Exertion (1–10)
    FatigueLevel DECIMAL(4,2)
);

-- Injuries Table
CREATE TABLE Injuries (
    InjuryID INT PRIMARY KEY,
    PlayerID INT FOREIGN KEY REFERENCES Players(PlayerID),
    InjuryDate DATE,
    RecoveryDate DATE,
    InjuryType NVARCHAR(100),
    Severity NVARCHAR(20),
    DaysOut INT,
    RecurrenceFlag BIT
);

-- WellnessSnapshots Table
CREATE TABLE WellnessSnapshots (
    SnapshotID INT PRIMARY KEY,
    PlayerID INT FOREIGN KEY REFERENCES Players(PlayerID),
    SnapshotDate DATE,
    SleepHours DECIMAL(4,2),
    StressLevel DECIMAL(4,2),
    MuscleSoreness DECIMAL(4,2),
    HydrationLevel DECIMAL(4,2),
    RecoveryScore DECIMAL(5,2)
);

-- InjuryRiskScores Table
CREATE TABLE InjuryRiskScores (
    PlayerID INT,
    SnapshotDate DATE,
    PredictedRisk DECIMAL(5,4),
    RiskCategory NVARCHAR(20),
    ModelVersion NVARCHAR(20),
    PRIMARY KEY (PlayerID, SnapshotDate)
);