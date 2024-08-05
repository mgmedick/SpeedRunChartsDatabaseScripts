USE SpeedRunAppJRE;

/*********************************************/
-- create/alter tables
/*********************************************/
-- tbl_User
DROP TABLE IF EXISTS tbl_User;

CREATE TABLE tbl_User(
	ID int NOT NULL AUTO_INCREMENT,
	Username varchar(255) NOT NULL,
	Email varchar(100) NOT NULL,
	`Password` varchar(255) NOT NULL,
	PromptToChange bit NOT NULL,
	Locked bit NOT NULL,
	Active bit NOT NULL,
	Deleted bit NOT NULL,
	CreatedBy int NOT NULL,
	CreatedDate datetime NOT NULL,
	ModifiedBy int NULL,
	ModifiedDate datetime NULL,
	PRIMARY KEY (ID)	
);

-- tbl_Game
DROP TABLE IF EXISTS tbl_Game;

CREATE TABLE tbl_Game 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NOT NULL,
	Abbr varchar(100) NULL,
    ShowMilliseconds bit NOT NULL,
    ReleaseDate datetime NULL,
    Deleted bit NOT NULL,
    SrcCreatedDate datetime NULL,
    CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),  
    ModifiedDate datetime NULL,
	PRIMARY KEY (ID)
);

-- tbl_Game_Link
DROP TABLE IF EXISTS tbl_Game_Link;

CREATE TABLE tbl_Game_Link 
(
    ID int NOT NULL AUTO_INCREMENT, 
    GameID int NOT NULL,
	CoverImageUrl varchar (80) NULL,
    SrcUrl varchar (125) NOT NULL,
   	PRIMARY KEY (ID)     
);

-- tbl_CategoryType
DROP TABLE IF EXISTS tbl_CategoryType;

CREATE TABLE tbl_CategoryType 
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (ID) 
);

-- tbl_Game_CategoryType
DROP TABLE IF EXISTS tbl_Game_CategoryType;

CREATE TABLE tbl_Game_CategoryType 
(
    ID int NOT NULL AUTO_INCREMENT, 
    GameID int NOT NULL,
    CategoryTypeID int NOT NULL,
    Deleted bit NOT NULL,    
    PRIMARY KEY (ID) 
);

-- tbl_Category
DROP TABLE IF EXISTS tbl_Category;

CREATE TABLE tbl_Category
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NOT NULL,
    GameID int NOT NULL,
    CategoryTypeID int NOT NULL,
    IsMiscellaneous bit NOT NULL, 
    IsTimerAscending bit NOT NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (ID)     
);

-- tbl_Level
DROP TABLE IF EXISTS tbl_Level;

CREATE TABLE tbl_Level 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NOT NULL,
	GameID int NOT NULL,
	Deleted bit NOT NULL,
	PRIMARY KEY (ID)
);

-- tbl_VariableScopeType
DROP TABLE IF EXISTS tbl_VariableScopeType;

CREATE TABLE tbl_VariableScopeType 
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (ID)      
);

-- tbl_Variable
DROP TABLE IF EXISTS tbl_Variable;

CREATE TABLE tbl_Variable
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NOT NULL,
    GameID int NOT NULL,
    VariableScopeTypeID int NOT NULL,
    CategoryID int NULL,
    LevelID int NULL,
    IsSubCategory bit NOT NULL,
    SortOrder int NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (ID)        
);

-- tbl_VariableValue
DROP TABLE IF EXISTS tbl_VariableValue;

CREATE TABLE tbl_VariableValue
( 
    ID int NOT NULL AUTO_INCREMENT,
    Name varchar (100) NOT NULL,
    Code varchar(10) NOT NULL,
    GameID int NOT NULL,   
    VariableID int NOT NULL,  
    IsMiscellaneous bit NOT NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (ID)      
);

-- tbl_Platform
DROP TABLE IF EXISTS tbl_Platform;

CREATE TABLE tbl_Platform 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (50) NOT NULL,
    Code varchar(10) NOT NULL,    
    Deleted bit NOT NULL,
    CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),  
    ModifiedDate datetime NULL,
    PRIMARY KEY (ID)   
);

-- tbl_Game_Platform
DROP TABLE IF EXISTS tbl_Game_Platform;

CREATE TABLE tbl_Game_Platform
(     
    ID int NOT NULL AUTO_INCREMENT, 
    GameID int NOT NULL,
    PlatformID int NOT NULL,
    Deleted bit NOT NULL,    
    PRIMARY KEY (ID)     
);

-- tbl_PlayerType
DROP TABLE IF EXISTS tbl_PlayerType;

CREATE TABLE tbl_PlayerType 
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (ID)      
);

-- tbl_Player
DROP TABLE IF EXISTS tbl_Player;

CREATE TABLE tbl_Player
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (100) NOT NULL,    
    Code varchar(100) NOT NULL, 
	PlayerTypeID int NOT NULL,
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
    PRIMARY KEY (ID)
);

-- tbl_Player_NameStyle
DROP TABLE IF EXISTS tbl_Player_NameStyle;

CREATE TABLE tbl_Player_NameStyle
( 
    ID int NOT NULL AUTO_INCREMENT,
    PlayerID int NOT NULL,
    IsGradient bit NOT NULL,
    ColorLight VARCHAR(10) NULL,
    ColorDark VARCHAR(10) NULL,    
    ColorToLight VARCHAR(10) NULL,
    ColorToDark VARCHAR(10) NULL,    
    PRIMARY KEY (ID)
);

-- tbl_Player_Link
DROP TABLE IF EXISTS tbl_Player_Link;

CREATE TABLE tbl_Player_Link
( 
    ID int NOT NULL AUTO_INCREMENT,
    PlayerID int NOT NULL,
    ProfileImageUrl varchar (1000) NULL,    
	SrcUrl varchar (1000) NULL, 
    TwitchUrl varchar (1000) NULL,
    HitboxUrl varchar (1000) NULL,
    YoutubeUrl varchar (1000) NULL,
    TwitterUrl varchar (1000) NULL,
    SpeedRunsLiveUrl varchar (1000) NULL,
    PRIMARY KEY (ID)   
);

-- tbl_SpeedRun
DROP TABLE IF EXISTS tbl_SpeedRun;

CREATE TABLE tbl_SpeedRun 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Code varchar(10) NOT NULL,
	GameID int NOT NULL,
	CategoryTypeID int NOT NULL,
	CategoryID int NOT NULL,
	LevelID int NULL,
	PlatformID int NULL,
	`Rank` int NULL,
	PrimaryTime bigint NOT NULL,
	DateSubmitted datetime NULL,
	VerifyDate datetime NULL,
	CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
  	PRIMARY KEY (ID) 	
);
CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID ON tbl_SpeedRun (GameID, CategoryID, LevelID);
CREATE INDEX IDX_tbl_SpeedRun_VerifyDate ON tbl_SpeedRun (VerifyDate);

-- tbl_SpeedRun_Link
DROP TABLE IF EXISTS tbl_SpeedRun_Link;

CREATE TABLE tbl_SpeedRun_Link 
( 
	ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
	SrcUrl varchar(1000) NOT NULL,
 	PRIMARY KEY (ID) 	
);

-- tbl_SpeedRun_Player
DROP TABLE IF EXISTS tbl_SpeedRun_Player;

CREATE TABLE tbl_SpeedRun_Player 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    PlayerID int NOT NULL,
	Deleted bit NOT NULL,
	PRIMARY KEY (ID)	 
);

-- tbl_SpeedRun_VariableValue
DROP TABLE IF EXISTS tbl_SpeedRun_VariableValue;

CREATE TABLE tbl_SpeedRun_VariableValue 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    VariableID int NOT NULL,
    VariableValueID int NOT NULL,
    Deleted bit NOT NULL,
	PRIMARY KEY (ID)    
); 

-- tbl_SpeedRun_Video
DROP TABLE IF EXISTS tbl_SpeedRun_Video;

CREATE TABLE tbl_SpeedRun_Video 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    VideoLinkUrl varchar (500) NOT NULL,
    EmbeddedVideoLinkUrl varchar (500) NULL,
	ThumbnailLinkUrl varchar(500) NULL,
	ChannelCode varchar(50) NULL,
	ViewCount bigint NULL,
	Deleted bit NOT NULL,
	PRIMARY KEY (ID) 	
);

-- tbl_SpeedRun_Ordered
DROP TABLE IF EXISTS tbl_SpeedRun_Ordered;

CREATE TABLE tbl_SpeedRun_Ordered 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
	Deleted bit NOT NULL,    
	PRIMARY KEY (ID) 	
);

-- tbl_Setting
DROP TABLE IF EXISTS tbl_Setting;

CREATE TABLE tbl_Setting 
( 
    ID int NOT NULL AUTO_INCREMENT,
    Name varchar (50) NOT NULL,
    Str varchar (500) NULL,
    Num int NULL,
    Dte datetime NULL,
  	PRIMARY KEY (ID)     
);

/*********************************************/
-- create/alter views
/*********************************************/
-- vw_Game
DROP VIEW IF EXISTS vw_Game;

CREATE DEFINER=`root`@`localhost` VIEW vw_Game AS

    SELECT g.ID, g.Name, g.Code, g.Abbr, g.ShowMilliseconds, g.ReleaseDate, g.CreatedDate, g.ModifiedDate, gl.ID AS GameLinkID, gl.CoverImageUrl, gl.SrcUrl,
        GameCategoryTypes.Value AS GameCategoryTypesJson, Categories.Value AS CategoriesJson, Levels.Value AS LevelsJson,
        Variables.Value AS VariablesJson, VariableValues.Value AS VariableValuesJson, GamePlatforms.Value AS GamePlatformsJson
    FROM tbl_Game g
    JOIN tbl_Game_Link gl ON gl.GameID = g.ID
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', ct1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(gc.ID,CHAR), ',"CategoryTypeID":', CONVERT(gc.CategoryTypeID,CHAR)), '}' ORDER BY gc.ID SEPARATOR ',') Value
		    FROM tbl_Game_CategoryType gc		    
	        WHERE gc.GameID = g.ID
	        AND gc.Deleted = 0
        ) ct1
    ) GameCategoryTypes ON TRUE
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', c1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(c.ID,CHAR), ',"Name":"', REPLACE(REPLACE(c.Name,"\\","\\\\"),"\"","\\\""), '","Code":"', c.Code, '","CategoryTypeID":', CONVERT(c.CategoryTypeID,CHAR), ',"IsMiscellaneous":', CASE c.IsMiscellaneous WHEN 1 THEN 'true' ELSE 'false' END, ',"IsTimerAscending":', CASE c.IsTimerAscending WHEN 1 THEN 'true' ELSE 'false' END), '}' ORDER BY c.IsMiscellaneous, c.ID SEPARATOR ',') Value
	        FROM tbl_Category c
	        WHERE c.GameID = g.ID
	        AND c.Deleted = 0	        
        ) c1
    ) Categories ON TRUE    
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', l1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(l.ID,CHAR), ',"Name":"', REPLACE(REPLACE(l.Name,"\\","\\\\"),"\"","\\\""), '","Code":"', l.Code), '"}' ORDER BY l.ID SEPARATOR ',') Value
	        FROM tbl_Level l
	        WHERE l.GameID = g.ID
	        AND l.Deleted = 0
        ) l1
    ) Levels ON TRUE
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(v.ID,CHAR), ',"Name":"', REPLACE(REPLACE(v.Name,"\\","\\\\"),"\"","\\\""), '","Code":"', v.Code, '","VariableScopeTypeID":', CONVERT(v.VariableScopeTypeID, CHAR), ',"CategoryID":', COALESCE(CONVERT(v.CategoryID, CHAR),'null'), ',"LevelID":', COALESCE(CONVERT(v.LevelID, CHAR),'null'), ',"IsSubCategory":', CASE v.IsSubCategory WHEN 1 THEN 'true' ELSE 'false' END), '}' ORDER BY v.SortOrder, v.ID SEPARATOR ',') Value
	        FROM tbl_Variable v
	        WHERE v.GameID = g.ID
	        AND v.Deleted = 0	        
        ) v1
    ) Variables ON TRUE   
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v2.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(v.ID,CHAR), ',"Name":"', REPLACE(REPLACE(v.Name,"\\","\\\\"),"\"","\\\""), '","Code":"', v.Code, '","VariableID":', CONVERT(v.VariableID,CHAR)), '}' ORDER BY v.ID SEPARATOR ',') Value
	        FROM tbl_VariableValue v
	        WHERE v.GameID = g.ID
	        AND v.Deleted = 0	        
        ) v2
    ) VariableValues ON TRUE 
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', p1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(gp.ID,CHAR), ',"PlatformID":', CONVERT(gp.PlatformID,CHAR)), '}' ORDER BY gp.PlatformID SEPARATOR ',') Value
		    FROM tbl_Game_Platform gp
	        WHERE gp.GameID = g.ID
	        AND gp.Deleted = 0	        
        ) p1
    ) GamePlatforms ON TRUE
   WHERE g.Deleted = 0;
  
-- vw_Player
DROP VIEW IF EXISTS vw_Player;

CREATE DEFINER=`root`@`localhost` VIEW vw_Player AS

    SELECT p.ID,
           p.Name,    
    	   p.Code,
           p.PlayerTypeID,
		   pl.ID AS PlayerLinkID,               
		   pl.ProfileImageUrl,    
		   pl.SrcUrl,
		   pl.TwitchUrl,
		   pl.HitboxUrl,
		   pl.YoutubeUrl,
		   pl.TwitterUrl,
		   pl.SpeedRunsLiveUrl,
		   ps.ID AS PlayerNameStyleID,
		   ps.IsGradient,
		   ps.ColorLight,
		   ps.ColorDark,
		   ps.ColorToLight,
		   ps.ColorToDark
    FROM tbl_Player p
    JOIN tbl_Player_Link pl ON pl.PlayerID = p.ID
    LEFT JOIN tbl_Player_NameStyle ps ON ps.PlayerID = p.ID;
  
-- vw_SpeedRun
DROP VIEW IF EXISTS vw_SpeedRun;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRun AS

    SELECT rn.ID,
    	   rn.Code,
           rn.GameID,
           rn.CategoryTypeID,
           rn.CategoryID,
           rn.LevelID,    
           rn.PlatformID,
           rn.Rank,
           rn.PrimaryTime,
           rn.DateSubmitted,
           rn.VerifyDate,
           rl.ID AS SpeedRunLinkID,
           rl.SrcUrl,
           Players.Value AS PlayersJson,
           VariableValues.Value AS VariableValuesJson,
           Videos.Value AS VideosJson
    FROM tbl_SpeedRun rn
    JOIN tbl_SpeedRun_Link rl ON rl.SpeedRunID = rn.ID  
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', p1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(rp.ID,CHAR), ',"PlayerID":', CONVERT(rp.PlayerID,CHAR)), '}' ORDER BY rp.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_Player rp
	        WHERE rp.SpeedRunID = rn.ID
	        AND rp.Deleted = 0	        
        ) p1
    ) Players ON TRUE    
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(rv.ID,CHAR), ',"VariableID":', '","VariableValueID":', CONVERT(rv.VariableValueID,CHAR)), '}' ORDER BY rv.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_VariableValue rv
	        WHERE rv.SpeedRunID = rn.ID
	        AND rv.Deleted = 0	        
        ) v1
    ) VariableValues ON TRUE
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(rv.ID,CHAR), ',"VideoLinkUrl":"', rv.VideoLinkUrl), '"}' ORDER BY rv.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_Video rv
	        WHERE rv.SpeedRunID = rn.ID
	        AND rv.Deleted = 0	        
        ) v1
    ) Videos ON TRUE;    
   
-- vw_SpeedRunGridTab
DROP VIEW IF EXISTS vw_SpeedRunGridTab;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridTab AS

    SELECT rn.ID,
    	   rn.Code,
           rn.GameID,
           rn.CategoryTypeID,
           rn.CategoryID,
           rn.LevelID,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           rn.`Rank`
    FROM tbl_SpeedRun rn
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE;   
   
-- vw_SpeedRunGrid
DROP VIEW IF EXISTS vw_SpeedRunGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGrid AS

    SELECT rn.ID,
    	   rn.Code,
           rn.GameID,
           rn.CategoryTypeID,
           rn.CategoryID,
           rn.LevelID,    
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           p.ID AS PlatformID,
           p.Name AS PlatformName,
           rn.Rank,
           rn.PrimaryTime,
           rn.DateSubmitted,
           rn.VerifyDate,
           rl.SrcUrl,
           Players.Value AS PlayersJson,
           VariableValues.Value AS VariableValuesJson,
           Videos.Value AS VideosJson
    FROM tbl_SpeedRun rn
    JOIN tbl_SpeedRun_Link rl ON rl.SpeedRunID = rn.ID
    LEFT JOIN tbl_Platform p ON p.ID = rn.PlatformID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE    
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', p1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"ID":', CONVERT(p.ID,CHAR), ',"Name":"', REPLACE(REPLACE(p.Name,"\\","\\\\"),"\"","\\\""), '","ColorLight":"', COALESCE(ps.ColorLight,''), '","ColorToLight":"', COALESCE(ps.ColorToLight,''), '","ColorDark":"', COALESCE(ps.ColorDark,''), '","ColorToDark":"', COALESCE(ps.ColorToDark,'')), '"}' ORDER BY rp.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_Player rp
	        JOIN tbl_Player p ON p.ID = rp.PlayerID
	        LEFT JOIN tbl_Player_NameStyle ps ON ps.PlayerID = p.ID 
	        WHERE rp.SpeedRunID = rn.ID
	        AND rp.Deleted = 0	        
        ) p1
    ) Players ON TRUE    
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT(CONVERT(rv.VariableID,CHAR), ',', CONVERT(rv.VariableValueID,CHAR)), '}' ORDER BY rv.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_VariableValue rv
	        WHERE rv.SpeedRunID = rn.ID
	        AND rv.Deleted = 0	        
        ) v1
    ) VariableValues ON TRUE
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', rv.VideoLinkUrl, '"}' ORDER BY rv.ID SEPARATOR ',') Value
	        FROM tbl_SpeedRun_Video rv
	        WHERE rv.SpeedRunID = rn.ID
	        AND rv.Deleted = 0	        
        ) v1
    ) Videos ON TRUE;
   
/*********************************************/
-- create/alter procs
/*********************************************/   
-- ImportUpdateSpeedRunRanks
DROP PROCEDURE IF EXISTS ImportUpdateSpeedRunRanks;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportUpdateSpeedRunRanks(
	IN LastImportDate DATETIME
)
BEGIN	
    DECLARE CurrDate DATETIME DEFAULT UTC_TIMESTAMP;
    DECLARE BatchCount INT DEFAULT 1000;
	DECLARE RowCount INT DEFAULT 0;
	DECLARE MaxRowCount INT;     
    DECLARE Debug BIT DEFAULT 0;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;      
   
   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeysFromRuns;
	CREATE TEMPORARY TABLE LeaderboardKeysFromRuns
	(
		GameID INT,
		CategoryID INT,
		LevelID INT,
		IsTimerAscending BIT		
	);

   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeys;
	CREATE TEMPORARY TABLE LeaderboardKeys
	(
		GameID INT,
		CategoryID INT,
		LevelID INT,
		IsTimerAscending BIT		
	);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdate;
	CREATE TEMPORARY TABLE SpeedRunsToUpdate
	(
	      RowNum INT AUTO_INCREMENT,	
          ID INT,
          GameID INT,
          CategoryID INT,
          LevelID INT,
          SubCategoryVariableValues VARCHAR(150),
          PlayerIDs VARCHAR(150),
          PrimaryTime BIGINT,
          IsTimerAscending BIT,          
          RankPriority INT,
		  PRIMARY KEY (RowNum)          
	);
	CREATE INDEX IDX_SpeedRunsToUpdate_GameID_CategoryID_LevelID_PlusInclude ON SpeedRunsToUpdate (GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, PrimaryTime);
	CREATE INDEX IDX_SpeedRunsToUpdate_RankPriority_PlayerIDs ON SpeedRunsToUpdate (RankPriority, PlayerIDs);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRanked;
	CREATE TEMPORARY TABLE SpeedRunsRanked
	(
		RowNum INT AUTO_INCREMENT,
		ID INT,
		`Rank` INT,
		PRIMARY KEY (RowNum)		
	);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdateRankPriority;
	CREATE TEMPORARY TABLE SpeedRunsToUpdateRankPriority
	(
		RowNum INT,
		RankPriority INT,
		PRIMARY KEY (RowNum)		
	);

	IF LastImportDate IS NOT NULL THEN
		INSERT INTO LeaderboardKeysFromRuns (GameID, CategoryID, LevelID)
		SELECT rn.GameID, rn.CategoryID, rn.LevelID
		FROM tbl_SpeedRun rn
		WHERE COALESCE(rn.ModifiedDate, rn.CreatedDate) > LastImportDate
		GROUP BY rn.GameID, rn.CategoryID, rn.LevelID;
    END IF;	

  	INSERT INTO LeaderboardKeys (GameID, CategoryID, LevelID, IsTimerAscending)
	SELECT g.ID, c.ID, l.ID, COALESCE(c.IsTimerAscending, 0)
	FROM tbl_Game g
	JOIN tbl_Category c ON c.GameID = g.ID
	LEFT JOIN tbl_Level l ON l.GameID = g.ID	
 	WHERE NOT EXISTS (SELECT 1 FROM LeaderboardKeysFromRuns WHERE GameID = g.ID AND CategoryID = c.ID AND COALESCE(LevelID, 0) = COALESCE(l.ID, 0))
 	AND (LastImportDate IS NULL OR COALESCE(g.ModifiedDate, g.CreatedDate) > LastImportDate)
	GROUP BY g.ID, c.ID, l.ID, c.IsTimerAscending;

	INSERT INTO LeaderboardKeys (GameID, CategoryID, LevelID, IsTimerAscending)
	SELECT rn.GameID, rn.CategoryID, rn.LevelID, COALESCE(c.IsTimerAscending, 0)
	FROM LeaderboardKeysFromRuns rn
	JOIN tbl_Category c ON c.ID = rn.CategoryID;

	INSERT INTO SpeedRunsToUpdate(ID, GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, PrimaryTime, IsTimerAscending)
    SELECT rn.ID, rn.GameID, rn.CategoryID, rn.LevelID, SubCategoryVariableValues.Value, PlayerIDs.Value, rn.PrimaryTime, lb.IsTimerAscending
    FROM tbl_SpeedRun rn
    JOIN LeaderboardKeys lb ON lb.GameID = rn.GameID AND lb.CategoryID = rn.CategoryID AND COALESCE(lb.LevelID, 0) = COALESCE(rn.LevelID, 0)
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rp.PlayerID,CHAR) ORDER BY rp.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Player rp
		WHERE rp.SpeedRunID = rn.ID
	) PlayerIDs ON TRUE;
  
	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum, ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs ORDER BY rn.PrimaryTime DESC)
	FROM SpeedRunsToUpdate rn
	WHERE rn.IsTimerAscending = 1;

	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum, ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs ORDER BY rn.PrimaryTime)
	FROM SpeedRunsToUpdate rn
	WHERE rn.IsTimerAscending = 0;

	UPDATE SpeedRunsToUpdate rn
	JOIN SpeedRunsToUpdateRankPriority rn1 ON rn1.RowNum = rn.RowNum
	SET rn.RankPriority = rn1.RankPriority;

	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID, RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime DESC)  
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1
	AND rn.IsTimerAscending = 1;

	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID, RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime)  
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1
	AND rn.IsTimerAscending = 0;

    IF Debug = 0 THEN        
    	SELECT COUNT(*) INTO MaxRowCount FROM SpeedRunsToUpdate;      
        WHILE RowCount < MaxRowCount DO
		   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdateBatch;
			CREATE TEMPORARY TABLE SpeedRunsToUpdateBatch
			(
				ID INT,
				PRIMARY KEY (ID)		
			);

            INSERT INTO SpeedRunsToUpdateBatch (ID)
		    SELECT ID
		    FROM SpeedRunsToUpdate
		    WHERE RowNum > RowCount
		    ORDER BY RowNum
		    LIMIT BatchCount; 
		   
			UPDATE tbl_SpeedRun rn
		  	JOIN SpeedRunsToUpdateBatch rn1 ON rn1.ID = rn.ID
		  	SET rn.`Rank` = NULL;	
		  
			SET RowCount = RowCount + BatchCount;
	    END WHILE;
   
	   	SET RowCount = 0;
    	SELECT COUNT(*) INTO MaxRowCount FROM SpeedRunsRanked;  	   
        WHILE RowCount < MaxRowCount DO	   
		   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRankedBatch;
			CREATE TEMPORARY TABLE SpeedRunsRankedBatch
			(
				ID INT,
				`Rank` INT,				
				PRIMARY KEY (ID)		
			);
		
            INSERT INTO SpeedRunsRankedBatch (ID, `Rank`)
		    SELECT ID, `Rank`
		    FROM SpeedRunsRanked
		    WHERE RowNum > RowCount
		    ORDER BY RowNum
		    LIMIT BatchCount;         
        
			UPDATE tbl_SpeedRun rn
		  	JOIN SpeedRunsRankedBatch rn1 ON rn1.ID = rn.ID
		  	SET rn.`Rank` = rn1.`Rank`;
		  
  			SET RowCount = RowCount + BatchCount;		
	    END WHILE;		
    ELSE
		SELECT rn.RankPriority, rn.ID, rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs, rn.PrimaryTime
        FROM SpeedRunsToUpdate rn
        WHERE rn.SubCategoryVariableValues IS NOT NULL
        ORDER BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs, rn.RankPriority;
        
        SELECT rn1.`Rank`, rn.ID, rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs, rn.PrimaryTime
        FROM SpeedRunsToUpdate rn
        JOIN SpeedRunsRanked rn1 ON rn1.ID = rn.ID
        WHERE rn.SubCategoryVariableValues IS NOT NULL
        ORDER BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn1.`Rank`;     
    END IF;
END $$
DELIMITER ;

-- ImportUpdateSpeedRunOrdered
DROP PROCEDURE IF EXISTS ImportUpdateSpeedRunOrdered;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportUpdateSpeedRunOrdered(
	IN LastImportDate DATETIME
)
BEGIN	
	
    DECLARE CurrDate DATETIME DEFAULT UTC_TIMESTAMP;
	DECLARE StartDate DATETIME DEFAULT DATE_ADD(CurrDate, INTERVAL -3 MONTH);

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	UPDATE tbl_SpeedRun_Ordered dn
	JOIN tbl_SpeedRun rn ON rn.ID = dn.SpeedRunID
	SET dn.Deleted = 1
	WHERE COALESCE(rn.VerifyDate, '1753-01-01 00:00:00') < StartDate;

	INSERT INTO tbl_SpeedRun_Ordered (SpeedRunID, Deleted)
	SELECT rn.ID, 0
	FROM tbl_SpeedRun rn
	WHERE rn.VerifyDate >= StartDate
	AND (LastImportDate IS NULL OR rn.CreatedDate > LastImportDate)
	AND NOT EXISTS (SELECT 1 FROM tbl_SpeedRun_Ordered rn2 WHERE rn2.SpeedRunID = rn.ID)
	ORDER BY rn.VerifyDate;
	
END $$
DELIMITER ;

/*********************************************/
-- populate tables
/*********************************************/
INSERT INTO tbl_Setting(Name, Str, Num, Dte)
SELECT 'LastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'GameLastImportRefDate', NULL, NULL, NULL;

INSERT INTO tbl_CategoryType (ID, Name)
SELECT '0', 'PerGame'
UNION ALL
SELECT '1', 'PerLevel';

INSERT INTO tbl_VariableScopeType (ID, Name)
SELECT '0', 'Global'
UNION ALL
SELECT '1', 'FullGame'
UNION ALL
SELECT '2', 'AllLevels'
UNION ALL
SELECT '3', 'SingleLevel';

INSERT INTO tbl_PlayerType (ID, Name)
SELECT '0', 'User'
UNION ALL
SELECT '1', 'Guest';

/*
INSERT INTO tbl_Platform(Name, Code, Deleted)
SELECT 'Airplane Seats','gz9qv3e0',0 UNION ALL
SELECT 'Electronic Delay Storage Automatic Calculator','jm95rr6o',0 UNION ALL
SELECT 'PC','8gej2n93',0 UNION ALL
SELECT 'MS-DOS','mr6km09z',0 UNION ALL
SELECT 'Tabletop','vm9vkn63',0 UNION ALL
SELECT 'Plug and Play','3167od9q',0 UNION ALL
SELECT 'Magnavox Odyssey','p36npx98',0 UNION ALL
SELECT 'Pong Consoles','wxeo1o9r',0 UNION ALL
SELECT 'LSI','v06ddw64',0 UNION ALL
SELECT 'Atari 2600','o0644863',0 UNION ALL
SELECT 'Apple II','w89ryw6l',0 UNION ALL
SELECT 'Tiger','3167qkeq',0 UNION ALL
SELECT 'Magnavox Odyssey 2','w89rqdel',0 UNION ALL
SELECT 'LCD handheld','8gejwk93',0 UNION ALL
SELECT 'Atari 8-bit family (400/800/XL/XE)','n5e1m7e2',0 UNION ALL
SELECT 'Intellivision','o0643893',0 UNION ALL
SELECT 'Arcade','vm9vn63k',0 UNION ALL
SELECT 'Game & Watch','gz9qkx90',0 UNION ALL
SELECT 'Commodore VIC-20','w89ryd6l',0 UNION ALL
SELECT 'Video Game Machine - Multiframe Colour - 1','mx6pgx63',0 UNION ALL
SELECT 'NEC PC-88 series','7g6mw8er',0 UNION ALL
SELECT 'BBC Micro','gz9q2390',0 UNION ALL
SELECT 'Texas Instruments TI-99/4A','5nego76y',0 UNION ALL
SELECT 'ColecoVision','wxeo8d6r',0 UNION ALL
SELECT 'NEC PC-98 series','o064r893',0 UNION ALL
SELECT 'Commodore 64','gz9qox60',0 UNION ALL
SELECT 'Atari 5200','lq60ol64',0 UNION ALL
SELECT 'ZX Spectrum','n568zo6v',0 UNION ALL
SELECT 'Sharp X1','o0641863',0 UNION ALL
SELECT 'Dragon 32/64','lq60rd64',0 UNION ALL
SELECT 'Vectrex','7g6m1m6r',0 UNION ALL
SELECT 'Nintendo Entertainment System','jm95z9ol',0 UNION ALL
SELECT 'MSX','jm950z6o',0 UNION ALL
SELECT 'Fairchild Channel F','gde31w9k',0 UNION ALL
SELECT 'Oric','8gej5193',0 UNION ALL
SELECT 'SG-1000','83expv9l',0 UNION ALL
SELECT 'Famicom','gde3owek',0 UNION ALL
SELECT 'Casio PV-2000','83ex5m6l',0 UNION ALL
SELECT 'Macintosh','mx6ppw63',0 UNION ALL
SELECT 'Amstrad CPC','5negykey',0 UNION ALL
SELECT 'Super Cassette Vision','5negr76y',0 UNION ALL
SELECT 'Sega Master System','83exwk6l',0 UNION ALL
SELECT 'Graphing Calculator','gz9qwx90',0 UNION ALL
SELECT 'MSX2','83exkk6l',0 UNION ALL
SELECT 'Amiga','gde32g6k',0 UNION ALL
SELECT 'Atari ST','n5e1g7e2',0 UNION ALL
SELECT 'Amstrad PCW','gde3vw9k',0 UNION ALL
SELECT 'Commodore 128 Computer','n5682q6v',0 UNION ALL
SELECT 'Famicom Disk System','mr6k409z',0 UNION ALL
SELECT 'Atari 7800','gde33gek',0 UNION ALL
SELECT 'Apple IIGS','7g6mom9r',0 UNION ALL
SELECT 'TurboGrafx-16/PC Engine','5negxk6y',0 UNION ALL
SELECT 'X68000','n5681o9v',0 UNION ALL
SELECT 'Acorn Archimedes','mx6pow93',0 UNION ALL
SELECT 'Sega Genesis','mr6k0ezw',0 UNION ALL
SELECT 'Game Boy','n5683oev',0 UNION ALL
SELECT 'Atari Lynx','o0641163',0 UNION ALL
SELECT 'FM Towns','jm95k79o',0 UNION ALL
SELECT 'Super Nintendo','83exk6l5',0 UNION ALL
SELECT 'Sega Game Gear','w89r3w9l',0 UNION ALL
SELECT 'Neo Geo AES','mx6p4w63',0 UNION ALL
SELECT 'Super Famicom','31677k6q',0 UNION ALL
SELECT 'Philips CD-i','w89rjw6l',0 UNION ALL
SELECT 'Linux','5neg7key',0 UNION ALL
SELECT 'Commodore CDTV','p36n4x98',0 UNION ALL
SELECT 'Sega CD','31670d9q',0 UNION ALL
SELECT '3DO Interactive Multiplayer','8gejmne3',0 UNION ALL
SELECT 'Atari Jaguar','jm95oz6o',0 UNION ALL
SELECT 'Amiga CD32','wxeo0der',0 UNION ALL
SELECT 'Sega Pico','7m6yjz6p',0 UNION ALL
SELECT 'Sega Saturn','lq60l642',0 UNION ALL
SELECT 'PlayStation','wxeod9rn',0 UNION ALL
SELECT 'Sega 32X','kz9wrn6p',0 UNION ALL
SELECT 'Super Game Boy','3167jd6q',0 UNION ALL
SELECT 'PC-FX','p36n8568',0 UNION ALL
SELECT 'Neo Geo CD','kz9w7mep',0 UNION ALL
SELECT 'Virtual Boy','7g6mk8er',0 UNION ALL
SELECT 'Satellaview','83exokel',0 UNION ALL
SELECT 'MegaNet','mx6px493',0 UNION ALL
SELECT 'Atari Jaguar CD','kz9wzm9p',0 UNION ALL
SELECT 'Casio Loopy','83ex8m6l',0 UNION ALL
SELECT 'Nintendo 64','w89rwelk',0 UNION ALL
SELECT 'Palm OS','nzelrveq',0 UNION ALL
SELECT 'Tamagotchi','8gejn193',0 UNION ALL
SELECT 'DVD Player','p36n0me8',0 UNION ALL
SELECT 'Super Famicom Turbo','gz9q0560',0 UNION ALL
SELECT 'Flash','7m6yqvep',0 UNION ALL
SELECT 'Game.Com','31672keq',0 UNION ALL
SELECT 'Game Boy Color','gde3g9k1',0 UNION ALL
SELECT 'Neo Geo Pocket Color','7m6ydw6p',0 UNION ALL
SELECT 'Java Phone','nzel5r6q',0 UNION ALL
SELECT 'Super Game Boy 2','n5e147e2',0 UNION ALL
SELECT 'TurboGrafx-16 CD-ROM','p36nlxe8',0 UNION ALL
SELECT 'Dreamcast','v06d394z',0 UNION ALL
SELECT 'WonderSwan','vm9v8n63',0 UNION ALL
SELECT 'Binary Runtime Environment for Wireless','n5685z6v',0 UNION ALL
SELECT 'Nintendo 64 Disk Drive','83ex5v6l',0 UNION ALL
SELECT 'PlayStation 2','n5e17e27',0 UNION ALL
SELECT 'Wonderswan Colour','n568kz6v',0 UNION ALL
SELECT 'Nuon','o064v163',0 UNION ALL
SELECT 'GameCube','4p9z06rn',0 UNION ALL
SELECT 'Game Boy Advance','3167d6q2',0 UNION ALL
SELECT 'Xbox','jm95zz9o',0 UNION ALL
SELECT 'Pokémon Mini','vm9vr1e3',0 UNION ALL
SELECT 'iPod','mr6k159z',0 UNION ALL
SELECT 'GamePark 32','31674w6q',0 UNION ALL
SELECT 'Game Boy Player','7m6yvw6p',0 UNION ALL
SELECT 'N-Gage','83exlkel',0 UNION ALL
SELECT 'iQue Player','p36nd598',0 UNION ALL
SELECT 'Leapster Learning Game System','7m6ypz6p',0 UNION ALL
SELECT 'Tapwave Zodiac','mx6pq4e3',0 UNION ALL
SELECT 'Nintendo DS','7g6m8erk',0 UNION ALL
SELECT 'PlayStation Portable','5negk9y7',0 UNION ALL
SELECT 'V.Smile','8gej8n93',0 UNION ALL
SELECT 'TI-84','lq604de4',0 UNION ALL
SELECT 'Xbox 360','n568oevp',0 UNION ALL
SELECT 'Advanced Pico Beena','o7e2dj6w',0 UNION ALL
SELECT 'Leapster TV','n5e1n292',0 UNION ALL
SELECT 'Gizmondo','5neg076y',0 UNION ALL
SELECT 'Xbox 360 Backwards Compatibility','mr6k0gez',0 UNION ALL
SELECT 'Temple Operating System','w89rvo6l',0 UNION ALL
SELECT 'Wii Virtual Console','nzelreqp',0 UNION ALL
SELECT 'PlayStation 3','mx6pwe3g',0 UNION ALL
SELECT 'Wii','v06dk3e4',0 UNION ALL
SELECT 'PSN Download','wxeo2d6r',0 UNION ALL
SELECT 'backwards-compatible PlayStation 3','v06dvz64',0 UNION ALL
SELECT 'Hyperscan','jm9517eo',0 UNION ALL
SELECT 'Wii Backwards compatibility','lq60qp94',0 UNION ALL
SELECT 'Pocket Dream Console','5neg3o6y',0 UNION ALL
SELECT 'iOS','gde3xgek',0 UNION ALL
SELECT 'Xbox 360 Arcade','lq60vde4',0 UNION ALL
SELECT 'Apple TV','vm9vz163',0 UNION ALL
SELECT 'Android','lq60nl94',0 UNION ALL
SELECT 'DSi','wxeo3zer',0 UNION ALL
SELECT 'Leapfrog Didj','nzel3veq',0 UNION ALL
SELECT 'Zeebo','7m6y2zep',0 UNION ALL
SELECT 'Windows Phone','p36no5e8',0 UNION ALL
SELECT 'Nintendo 3DS','gz9qx60q',0 UNION ALL
SELECT 'PlayStation Vita','4p9z70er',0 UNION ALL
SELECT 'Nintendo 3DS Virtual Console','7g6mx89r',0 UNION ALL
SELECT 'Chromebook','7g6mp36r',0 UNION ALL
SELECT 'Wii U','8gejn93d',0 UNION ALL
SELECT 'Wii U Virtual Console','v06dr394',0 UNION ALL
SELECT 'Ouya','nzeloreq',0 UNION ALL
SELECT 'Neo Geo X','o7e2lj9w',0 UNION ALL
SELECT 'Atari Flashback','jm9577eo',0 UNION ALL
SELECT 'Wii Mini','w89rdd6l',0 UNION ALL
SELECT 'WiiU Backwards Compatibility','lq60mde4',0 UNION ALL
SELECT '3DS Backwards Compatibility','vm9vw163',0 UNION ALL
SELECT 'PlayStation 4','nzelkr6q',0 UNION ALL
SELECT 'Xbox One','o7e2mx6w',0 UNION ALL
SELECT 'PlayStation TV','lq60gle4',0 UNION ALL
SELECT 'Xbox One S','o064j163',0 UNION ALL
SELECT 'PICO-8','n568qz6v',0 UNION ALL
SELECT '2DS','jm951reo',0 UNION ALL
SELECT '2DS Backwards Compatibility','nzelm79q',0 UNION ALL
SELECT 'New Nintendo 3DS','kz9wqn9p',0 UNION ALL
SELECT 'New Nintendo 3DS Virtual Console','v06do394',0 UNION ALL
SELECT 'PlayStation Now','wxeo5z6r',0 UNION ALL
SELECT 'Amazon Fire TV','mr6ko5ez',0 UNION ALL
SELECT 'AndroidTV','n5e15292',0 UNION ALL
SELECT 'Arduboy','mr6k206z',0 UNION ALL
SELECT 'Game Boy Interface','vm9v3ne3',0 UNION ALL
SELECT 'Nvidia Shield','v06dmz64',0 UNION ALL
SELECT 'Analogue Nt','3167pk6q',0 UNION ALL
SELECT 'Analogue Nt Mini','kz9wlm6p',0 UNION ALL
SELECT 'Apple Watch','vm9vy893',0 UNION ALL
SELECT 'HTC Vive','w89rwwel',0 UNION ALL
SELECT 'Oculus VR','4p9zq09r',0 UNION ALL
SELECT 'NES Classic Mini','kz9wynep',0 UNION ALL
SELECT 'PlayStation 4 Pro','nzeljv9q',0 UNION ALL
SELECT 'Switch','7m6ylw9p',0 UNION ALL
SELECT 'SNES Classic Mini','83exovel',0 UNION ALL
SELECT 'Xbox One X','4p9z0r6r',0 UNION ALL
SELECT 'Windows Mixed Reality','w89r4d6l',0 UNION ALL
SELECT 'Nt Mini Noir','p36nyx98',0 UNION ALL
SELECT 'TIC-80','4p9zprer',0 UNION ALL
SELECT '2DS XL','o064vv63',0 UNION ALL
SELECT 'Xbox Game Pass','kz9w4oep',0 UNION ALL
SELECT 'PlayStation Classic','o7e2vj6w',0 UNION ALL
SELECT 'Neo Geo Mini','n5e1z292',0 UNION ALL
SELECT 'Switch Virtual Console','mx6p1463',0 UNION ALL
SELECT 'MiSTer','gde3rwek',0 UNION ALL
SELECT 'Analogue Super Nt','gz9qg3e0',0 UNION ALL
SELECT 'Commodore 64 Mini','4p9zrz6r',0 UNION ALL
SELECT 'Google Stadia','o064z1e3',0 UNION ALL
SELECT 'Valve Index','83exvv9l',0 UNION ALL
SELECT 'Sega Genesis Mini','mx6p3493',0 UNION ALL
SELECT 'Mega Sg','5negp7ey',0 UNION ALL
SELECT 'Oculus Quest','o064o193',0 UNION ALL
SELECT 'Nintendo Switch Lite','kz9wdmep',0 UNION ALL
SELECT 'Roku','jm95l76o',0 UNION ALL
SELECT 'PlayStation 5','4p9zjrer',0 UNION ALL
SELECT 'Xbox Series X','nzelyv9q',0 UNION ALL
SELECT 'Xbox Series S','o7e2xj9w',0 UNION ALL
SELECT 'TurboGrafx-16 Mini','jm95w79o',0 UNION ALL
SELECT 'PS5 for backward compatible games','v06dpz64',0 UNION ALL
SELECT 'Evercade','n5e1kg92',0 UNION ALL
SELECT 'Oculus Quest 2','o064xv93',0 UNION ALL
SELECT 'retroUSB AVS','7g6mym6r',0;
*/

/*
SELECT CONCAT('SELECT ''', p.Name, ''',''', dn.SpeedRunComID, ''',0 UNION ALL')
FROM speedrunapp.tbl_platform p
JOIN speedrunapp.tbl_platform_speedruncomid dn ON dn.PlatformID = p.ID
GROUP BY p.Name, dn.SpeedRunComID

INSERT INTO tbl_Game (Name, Code, Abbr, ShowMilliseconds, ReleaseDate, ImportRefDate, CreatedDate, ModifiedDate)
SELECT g.Name, gc.SpeedRunComID, g.Abbr, gr.ShowMilliseconds, MAKEDATE(g.YearOfRelease, 1), g.CreatedDate, g.ImportedDate, NULL
FROM SpeedRunApp.tbl_Game g
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = g.ID
JOIN SpeedRunApp.tbl_Game_Ruleset gr ON gr.GameID = g.ID
ORDER BY g.ID
LIMIT 100;

INSERT INTO tbl_Game_Link (GameID, CoverImageUrl, SrcUrl)
SELECT g1.ID, gl.CoverImageUrl, gl.SrcUrl
FROM SpeedRunApp.tbl_Game_Link gl
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = gl.GameID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
ORDER BY g1.ID
LIMIT 100;

INSERT INTO tbl_CategoryType (ID, Name)
SELECT ct.ID, ct.Name
FROM SpeedRunApp.tbl_CategoryType ct
GROUP BY ct.ID, ct.Name
ORDER BY ct.ID;

INSERT INTO tbl_Game_CategoryType (GameID, CategoryTypeID)
SELECT g1.ID, ct.ID
FROM SpeedRunApp.tbl_CategoryType ct
JOIN SpeedRunApp.tbl_Category c ON c.CategoryTypeID = ct.ID
JOIN SpeedRunApp.tbl_Game g ON g.ID = c.GameID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = g.ID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
GROUP BY g1.ID, ct.ID
ORDER BY g1.ID, ct.ID;

INSERT INTO tbl_Category (Name, Code, GameID, CategoryTypeID, IsMiscellaneous, IsTimerAscending)
SELECT c.Name, cc.SpeedRunComID, g1.ID, c.CategoryTypeID, c.IsMiscellaneous, c.IsTimerAscending
FROM SpeedRunApp.tbl_Category c
JOIN SpeedRunApp.tbl_Category_SpeedRunComID cc ON cc.CategoryID = c.ID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = c.GameID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
GROUP BY c.ID, c.Name, cc.SpeedRunComID, g1.ID, c.CategoryTypeID, c.IsMiscellaneous, c.IsTimerAscending
ORDER BY c.ID;

INSERT INTO tbl_Level (Name, Code, GameID)
SELECT l.Name, lc.SpeedRunComID, g1.ID
FROM SpeedRunApp.tbl_Level l
JOIN SpeedRunApp.tbl_Level_SpeedRunComID lc ON lc.LevelID = l.ID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = l.GameID
JOIN tbl_Level l1 ON l1.Code = lc.SpeedRunComID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
GROUP BY l1.ID, l.Name, lc.SpeedRunComID, g1.ID
ORDER BY l1.ID;

INSERT INTO tbl_VariableScopeType (ID, Name)
SELECT vt.ID, vt.Name
FROM SpeedRunApp.tbl_VariableScopeType vt
ORDER BY vt.ID;

INSERT INTO tbl_Variable (Name, Code, GameID, VariableScopeTypeID, CategoryID, LevelID, IsSubCategory)
SELECT v.Name, gc.SpeedRunComID, g1.ID, v.VariableScopeTypeID, c1.ID, l1.ID, v.IsSubCategory
FROM SpeedRunApp.tbl_Variable v
JOIN SpeedRunApp.tbl_Variable_SpeedRunComID vc ON vc.VariableID = v.ID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = v.GameID
JOIN SpeedRunApp.tbl_Category_SpeedRunComID cc ON cc.CategoryID = v.CategoryID
JOIN SpeedRunApp.tbl_Level_SpeedRunComID lc ON lc.LevelID = v.LevelID
JOIN tbl_Variable v1 ON v1.Code = vc.SpeedRunComID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
JOIN tbl_Category c1 ON c1.Code = cc.SpeedRunComID
JOIN tbl_Level l1 ON l1.Code = lc.SpeedRunComID
GROUP BY v.ID, v.Name, gc.SpeedRunComID, g1.ID, v.VariableScopeTypeID, c1.ID, l1.ID, v.IsSubCategory
ORDER BY v.ID;

INSERT INTO tbl_VariableValue (Name, Code, GameID, VariableID, IsMiscellaneous)
SELECT v.Value, gc.SpeedRunComID, g1.ID, v2.ID, v.IsCustomValue
FROM SpeedRunApp.tbl_VariableValue v
JOIN SpeedRunApp.tbl_VariableValue_SpeedRunComID vc ON vc.VariableValueID = v.ID
JOIN SpeedRunApp.tbl_Variable_SpeedRunComID vc2 ON vc2.VariableID = v.VariableID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = v.GameID
JOIN tbl_VariableValue v1 ON v1.Code = vc.SpeedRunComID
JOIN tbl_Variable v2 ON v2.Code = vc2.SpeedRunComID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID
GROUP BY v.ID, v.Value, gc.SpeedRunComID, g1.ID, v2.ID, v.IsCustomValue
ORDER BY v.ID;

INSERT INTO tbl_Platform (Name, Code, YearOfRelease, CreatedDate)
SELECT DISTINCT p.Name, pc.SpeedRunComID, p.YearOfRelease, p.ImportedDate
FROM SpeedRunApp.tbl_Platform p
JOIN SpeedRunApp.tbl_Platform_SpeedRunComID pc ON pc.PlatformID = p.ID;

INSERT INTO tbl_Game_Platform(GameID, PlatformID)
SELECT DISTINCT g1.ID, p1.ID
FROM SpeedRunApp.tbl_Game_Platform gp
JOIN SpeedRunApp.tbl_Platform_SpeedRunComID pc ON pc.PlatformID = gp.PlatformID
JOIN SpeedRunApp.tbl_Game_SpeedRunComID gc ON gc.GameID = gp.GameID
JOIN tbl_Platform p1 ON p1.Code = pc.SpeedRunComID
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComID;
*/



















