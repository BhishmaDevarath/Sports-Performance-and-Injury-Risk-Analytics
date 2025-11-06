-- Bulk Insurt into Tables
-- Insert into Players
BULK INSERT dbo.Players
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\Players.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into Teams
BULK INSERT dbo.Teams
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\Teams.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into Matches
BULK INSERT dbo.Matches
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\Matches.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into PlayerMatchStats
BULK INSERT dbo.PlayerMatchStats
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\PlayerMatchStats.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into TrainingSessions
BULK INSERT dbo.TrainingSessions
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\TrainingSessions.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into Injuries
BULK INSERT dbo.Injuries
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\Injuries.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

-- Insert into WellnessSnapshots
BULK INSERT dbo.WellnessSnapshots
FROM 'D:\Sports Performance & Injury Risk Analytics\DataSet\WellnessSnapshots.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);