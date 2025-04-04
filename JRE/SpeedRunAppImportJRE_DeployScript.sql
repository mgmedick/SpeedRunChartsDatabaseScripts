-- USE SpeedRunAppJRE;

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

-- tbl_User_Setting
DROP TABLE IF EXISTS tbl_User_Setting;

CREATE TABLE tbl_User_Setting(
	ID int NOT NULL AUTO_INCREMENT,
	UserID int NOT NULL,
	IsDarkTheme bit NOT NULL,
	PRIMARY KEY (ID)	
);

-- tbl_User_SummaryList
DROP TABLE IF EXISTS tbl_User_SummaryList;

CREATE TABLE tbl_User_SummaryList(
	ID int NOT NULL AUTO_INCREMENT,
	UserID int NOT NULL,
	SummaryListID int NOT NULL,
	PRIMARY KEY (ID)		
);

-- tbl_SummaryList
DROP TABLE IF EXISTS tbl_SummaryList;

CREATE TABLE tbl_SummaryList(
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	DisplayName varchar(50) NULL,
	Description varchar(250) NULL,
	IsDefault bit NOT NULL,
	DefaultSortOrder int NULL,
	PRIMARY KEY (ID) 	
);

-- tbl_Game
DROP TABLE IF EXISTS tbl_Game;

CREATE TABLE tbl_Game 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NOT NULL,
	Abbr varchar(100) NOT NULL,
    ShowMilliseconds bit NOT NULL,
    ReleaseDate datetime NULL,
    Deleted bit NOT NULL,
    SrcCreatedDate datetime NULL,
    CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),  
    ModifiedDate datetime NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX IDX_tbl_Game_Code ON tbl_Game (Code);

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
CREATE INDEX IDX_tbl_Game_Link_GameID ON tbl_Game_Link (GameID);

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
CREATE INDEX IDX_tbl_Game_CategoryType_GameID ON tbl_Game_CategoryType (GameID);

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
CREATE INDEX IDX_tbl_Category_GameID ON tbl_Category (GameID);

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
CREATE INDEX IDX_tbl_Level_GameID ON tbl_Level (GameID);

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
CREATE INDEX IDX_tbl_Variable_GameID ON tbl_Variable (GameID);

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
    SortOrder int NULL,     
    PRIMARY KEY (ID)      
);
CREATE INDEX IDX_tbl_VariableValue_GameID ON tbl_VariableValue (GameID);

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
CREATE INDEX IDX_tbl_Game_Platform_GameID ON tbl_Game_Platform (GameID);

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
	Abbr varchar(100) NOT NULL,    
	PlayerTypeID int NOT NULL,
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
    PRIMARY KEY (ID)
);
CREATE INDEX IDX_tbl_Player_Code ON tbl_Player (Code);
CREATE INDEX IDX_tbl_Player_Abbr ON tbl_Player (Abbr); 

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
CREATE INDEX IDX_tbl_Player_Link_PlayerID ON tbl_Player_Link (PlayerID);

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
CREATE INDEX IDX_tbl_Player_NameStyle_PlayerID ON tbl_Player_NameStyle (PlayerID);

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
	SubCategoryVariableValueIDs varchar(255) NULL,
	PlatformID int NULL,
	`Rank` int NULL,
	PrimaryTime bigint NOT NULL,
	DateSubmitted datetime NULL,
	VerifyDate datetime NULL,
    Deleted bit NOT NULL,
	CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
  	PRIMARY KEY (ID) 	
);
CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID ON tbl_SpeedRun (GameID, CategoryTypeID, CategoryID, LevelID, SubCategoryVariableValueIDs, `Rank`);
CREATE INDEX IDX_tbl_SpeedRun_Code ON tbl_SpeedRun (Code);
CREATE INDEX IDX_tbl_SpeedRun_Deleted_CreatedDate_VerifyDate ON tbl_SpeedRun (Deleted, CreatedDate, VerifyDate);

-- tbl_SpeedRun_Link
DROP TABLE IF EXISTS tbl_SpeedRun_Link;

CREATE TABLE tbl_SpeedRun_Link 
( 
	ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
	SrcUrl varchar(1000) NOT NULL,
 	PRIMARY KEY (ID) 	
);
CREATE INDEX IDX_tbl_SpeedRun_Link_SpeedRunID ON tbl_SpeedRun_Link (SpeedRunID);

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
CREATE INDEX IDX_tbl_SpeedRun_Player_SpeedRunID ON tbl_SpeedRun_Player (SpeedRunID);
CREATE INDEX IDX_tbl_SpeedRun_Player_PlayerID ON tbl_SpeedRun_Player (PlayerID);

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
CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID ON tbl_SpeedRun_VariableValue (SpeedRunID);

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
CREATE INDEX IDX_tbl_SpeedRun_Video_SpeedRunID ON tbl_SpeedRun_Video (SpeedRunID);

-- tbl_SpeedRun_Summary
DROP TABLE IF EXISTS tbl_SpeedRun_Summary;

CREATE TABLE tbl_SpeedRun_Summary 
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

    SELECT g.ID, g.Name, g.Code, g.Abbr, g.ShowMilliseconds, g.ReleaseDate, g.SrcCreatedDate, g.CreatedDate, g.ModifiedDate, gl.ID AS GameLinkID, gl.CoverImageUrl, gl.SrcUrl,
        GameCategoryTypes.Value AS GameCategoryTypesJson, Categories.Value AS CategoriesJson, Levels.Value AS LevelsJson,
        Variables.Value AS VariablesJson, VariableValues.Value AS VariableValuesJson, GamePlatforms.Value AS GamePlatformsJson
    FROM tbl_Game g
    JOIN tbl_Game_Link gl ON gl.GameID = g.ID
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', gc.ID, 'CategoryTypeID', gc.CategoryTypeID)) Value
	    FROM tbl_Game_CategoryType gc		    
        WHERE gc.GameID = g.ID
        AND gc.Deleted = 0
        ORDER BY gc.ID
    ) GameCategoryTypes ON TRUE
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', c.ID, 'Name', c.Name, 'Code', c.Code, 'CategoryTypeID', c.CategoryTypeID, 'IsMiscellaneous', CASE c.IsMiscellaneous WHEN 1 THEN CAST(TRUE AS JSON) ELSE CAST(FALSE AS JSON) END, 'IsTimerAscending', CASE c.IsTimerAscending WHEN 1 THEN CAST(TRUE AS JSON) ELSE CAST(FALSE AS JSON) END)) Value
	    FROM tbl_Category c
	    WHERE c.GameID = g.ID
	    AND c.Deleted = 0
        ORDER BY c.IsMiscellaneous, c.ID 
    ) Categories ON TRUE 
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', l.ID, 'Name', l.Name, 'Code', l.Code)) Value
	    FROM tbl_Level l
	    WHERE l.GameID = g.ID
	    AND l.Deleted = 0
        ORDER BY l.ID 
    ) Levels ON TRUE     
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', v.ID, 'Name', v.Name, 'Code', v.Code, 'VariableScopeTypeID', v.VariableScopeTypeID, 'CategoryID', v.CategoryID, 'LevelID', v.LevelID, 'IsSubCategory', CASE v.IsSubCategory WHEN 1 THEN CAST(TRUE AS JSON) ELSE CAST(FALSE AS JSON) END)) Value
	    FROM tbl_Variable v
	    WHERE v.GameID = g.ID
	    AND v.Deleted = 0	 
        ORDER BY v.SortOrder, v.ID 
    ) Variables ON TRUE   
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', v.ID, 'Name', v.Name, 'Code', v.Code, 'VariableID', v.VariableID)) Value
	    FROM tbl_VariableValue v
	    WHERE v.GameID = g.ID
	    AND v.Deleted = 0	
        ORDER BY v.SortOrder, v.ID 
    ) VariableValues ON TRUE   
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', gp.ID, 'PlatformID', gp.PlatformID)) Value
	    FROM tbl_Game_Platform gp
	    WHERE gp.GameID = g.ID
	    AND gp.Deleted = 0	
        ORDER BY gp.PlatformID 
    ) GamePlatforms ON TRUE
   WHERE g.Deleted = 0;
  
-- vw_Player
DROP VIEW IF EXISTS vw_Player;

CREATE DEFINER=`root`@`localhost` VIEW vw_Player AS

    SELECT p.ID,
           p.Name,    
    	   p.Code,
    	   p.Abbr,
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
           rn.SubCategoryVariableValueIDs,
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
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', rp.ID, 'PlayerID', rp.PlayerID)) Value
        FROM tbl_SpeedRun_Player rp
        WHERE rp.SpeedRunID = rn.ID
        AND rp.Deleted = 0	   
        ORDER BY rp.ID
    ) Players ON TRUE    
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', rv.ID, 'VariableID', rv.VariableID, 'VariableValueID', rv.VariableValueID)) Value
        FROM tbl_SpeedRun_VariableValue rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	   
        ORDER BY rv.ID
    ) VariableValues ON TRUE    
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', rv.ID, 'VideoLinkUrl', rv.VideoLinkUrl)) Value
        FROM tbl_SpeedRun_Video rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	     
        ORDER BY rv.ID
    ) Videos ON TRUE    
    WHERE rn.Deleted = 0;
   
-- vw_SpeedRunGrid
DROP VIEW IF EXISTS vw_SpeedRunGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGrid AS

    SELECT rn.ID,
    	   rn.Code,
           rn.GameID,
           rn.CategoryTypeID,
           c.ID AS CategoryID,
           c.Name AS CategoryName,
           c.IsTimerAscending,
           c.IsMiscellaneous,           
           l.ID AS LevelID,   
           l.Name AS LevelName,
           rn.SubCategoryVariableValueIDs,
           SubCategoryVariableValueNames.Value AS SubCategoryVariableValueNames,
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
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID    
    LEFT JOIN tbl_Platform p ON p.ID = rn.PlatformID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(va.Name ORDER BY rv.ID SEPARATOR ', ') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueNames ON TRUE    
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', p.ID, 'Name', p.Name, 'Abbr', p.Abbr, 'ColorLight', ps.ColorLight, 'ColorToLight', ps.ColorToLight, 'ColorDark', ps.ColorDark, 'ColorToDark', ps.ColorToDark)) Value
        FROM tbl_SpeedRun_Player rp
        JOIN tbl_Player p ON p.ID = rp.PlayerID
        LEFT JOIN tbl_Player_NameStyle ps ON ps.PlayerID = p.ID 
        WHERE rp.SpeedRunID = rn.ID
        AND rp.Deleted = 0	     
        ORDER BY rp.ID
    ) Players ON TRUE
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', rv.VariableValueID, 'VariableID', rv.VariableID)) Value
		FROM tbl_SpeedRun_VariableValue rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	  
        ORDER BY rv.ID
    ) VariableValues ON TRUE      
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(rv.VideoLinkUrl) Value
        FROM tbl_SpeedRun_Video rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	       
        ORDER BY rv.ID
    ) Videos ON TRUE  
   WHERE rn.Deleted = 0;

-- vw_SpeedRunGridPlayer
DROP VIEW IF EXISTS vw_SpeedRunGridPlayer;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridPlayer AS

	SELECT rn.ID,
		   rn.Code,
           rn.GameID,
           rn.CategoryTypeID,
           rn.CategoryID,
           rn.CategoryName,
           rn.IsTimerAscending,
           rn.IsMiscellaneous,
           rn.LevelID,
           rn.LevelName,           
           rn.PlatformID,
           rn.PlatformName,
           rn.SubCategoryVariableValueIDs,
           rn.SubCategoryVariableValueNames,
           rn.VariableValuesJson,
           rn.PlayersJson,
           rn.VideosJson,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.DateSubmitted,
           rn.VerifyDate,
           rn.SrcUrl,
           rp.PlayerID
	    FROM vw_SpeedRunGrid rn
	    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID
	    WHERE rp.Deleted = 0;   
   
-- vw_SpeedRunSummary
DROP VIEW IF EXISTS vw_SpeedRunSummary;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunSummary AS

 	SELECT rs.ID AS SortOrder,
    	   rn.ID,	  
    	   rn.Code, 
           g.ID AS GameID,
           g.Name AS GameName,
		   g.Abbr AS GameAbbr, 
	   	   g.ShowMilliseconds,   
           gl.CoverImageUrl AS GameCoverImageUrl,        
           ct.ID AS CategoryTypeID,
           ct.Name AS CategoryTypeName,           
           c.ID AS CategoryID,
           c.Name AS CategoryName,
		   l.ID AS LevelID,
		   l.Name AS LevelName,
           rn.SubCategoryVariableValueIDs,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.VerifyDate,
           rn.CreatedDate,
           rn.ModifiedDate,
           Video.SpeedRunVideoID,
           Video.VideoLinkUrl,
           Video.EmbeddedVideoLinkUrl,
           Video.ThumbnailLinkUrl,        
           Video.ChannelCode,              
           Video.ViewCount,               
           SubCategoryVariableValueNames.Value AS SubCategoryVariableValueNamesJson,
           Players.Value AS PlayersJson
    FROM tbl_SpeedRun rn
    JOIN tbl_SpeedRun_Summary rs ON rs.SpeedRunID = rn.ID AND rs.Deleted = 0
    JOIN tbl_Game g ON g.ID = rn.GameID
	JOIN tbl_Game_Link gl ON gl.GameID = g.ID
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    JOIN tbl_CategoryType ct ON ct.ID = c.CategoryTypeID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(va.Name) Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	        
        ORDER BY rv.ID
    ) SubCategoryVariableValueNames ON TRUE
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', p.ID, 'Name', p.Name, 'Abbr', p.Abbr, 'ColorLight', ps.ColorLight, 'ColorToLight', ps.ColorToLight, 'ColorDark', ps.ColorDark, 'ColorToDark', ps.ColorToDark)) Value
        FROM tbl_SpeedRun_Player rp
        JOIN tbl_Player p ON p.ID = rp.PlayerID
        LEFT JOIN tbl_Player_NameStyle ps ON ps.PlayerID = p.ID 
        WHERE rp.SpeedRunID = rn.ID
        AND rp.Deleted = 0	     
        ORDER BY rp.ID
    ) Players ON TRUE
	LEFT JOIN LATERAL (
		SELECT rv.ID AS SpeedRunVideoID, rv.VideoLinkUrl, rv.EmbeddedVideoLinkUrl, rv.ThumbnailLinkUrl, rv.ChannelCode, rv.ViewCount
		FROM tbl_SpeedRun_Video rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0
        AND rv.EmbeddedVideoLinkUrl IS NOT NULL
        ORDER BY rv.ID
        LIMIT 1
    ) Video ON TRUE       
    WHERE rn.Deleted = 0;
   
-- vw_SpeedRunDetail
DROP VIEW IF EXISTS vw_SpeedRunDetail;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunDetail AS

    SELECT rn.ID,
    	   rn.Code,
           g.ID AS GameID,
           g.Name AS GameName,
		   g.Abbr AS GameAbbr, 
	   	   g.ShowMilliseconds,   
           gl.CoverImageUrl AS GameCoverImageUrl,             
           rn.CategoryTypeID,
           c.ID AS CategoryID,
           c.Name AS CategoryName,
           c.IsTimerAscending,
           c.IsMiscellaneous,           
           l.ID AS LevelID,   
           l.Name AS LevelName,
           rn.SubCategoryVariableValueIDs,
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
    JOIN tbl_Game g ON g.ID = rn.GameID
	JOIN tbl_Game_Link gl ON gl.GameID = g.ID    
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID    
    LEFT JOIN tbl_Platform p ON p.ID = rn.PlatformID
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', p.ID, 'Name', p.Name, 'Abbr', p.Abbr, 'ColorLight', ps.ColorLight, 'ColorToLight', ps.ColorToLight, 'ColorDark', ps.ColorDark, 'ColorToDark', ps.ColorToDark)) Value
        FROM tbl_SpeedRun_Player rp
        JOIN tbl_Player p ON p.ID = rp.PlayerID
        LEFT JOIN tbl_Player_NameStyle ps ON ps.PlayerID = p.ID 
        WHERE rp.SpeedRunID = rn.ID
        AND rp.Deleted = 0	     
        ORDER BY rp.ID
    ) Players ON TRUE    
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('ID', va.ID, 'Name', va.Name, 'VariableID', v.ID, 'VariableName', v.Name)) Value
		FROM tbl_SpeedRun_VariableValue rv
		JOIN tbl_Variable v ON v.ID = rv.VariableID
		JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID		
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	  
        ORDER BY rv.ID
    ) VariableValues ON TRUE
	LEFT JOIN LATERAL (
		SELECT JSON_ARRAYAGG(JSON_OBJECT('VideoLinkUrl', rv.VideoLinkUrl, 'EmbeddedVideoLinkUrl', rv.EmbeddedVideoLinkUrl, 'ViewCount', rv.ViewCount)) Value
        FROM tbl_SpeedRun_Video rv
        WHERE rv.SpeedRunID = rn.ID
        AND rv.Deleted = 0	     
        ORDER BY rv.ID
    ) Videos ON TRUE      
   WHERE rn.Deleted = 0;
     
-- vw_User
DROP VIEW IF EXISTS vw_User;

CREATE DEFINER=`root`@`localhost` VIEW vw_User AS

    SELECT ua.ID AS UserID,
	ua.Username,
	ua.Email,
	ua.`Password`,
	ua.PromptToChange,
	ua.Locked,
	ua.Active,
	ua.Deleted,
	ua.CreatedBy,
	ua.CreatedDate,
	ua.ModifiedBy,
	ua.ModifiedDate,
	ue.IsDarkTheme,
	COALESCE(SummaryListIDs.Value, DefaultSummaryListIDs.Value) AS SummaryListIDs
    FROM tbl_User ua
	LEFT JOIN tbl_User_Setting ue ON ue.UserID = ua.ID
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(uc.SummaryListID,CHAR) ORDER BY uc.ID SEPARATOR ',') Value
	    FROM tbl_User_SummaryList uc
	    WHERE uc.UserID = ua.ID   
	) SummaryListIDs ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(sc.ID,CHAR) SEPARATOR ',') Value
	    FROM tbl_SummaryList sc
	    WHERE sc.IsDefault = 1 
	) DefaultSummaryListIDs ON TRUE	
	WHERE ua.Deleted = 0;   

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
   
   	DROP TEMPORARY TABLE IF EXISTS GameIDs;
	CREATE TEMPORARY TABLE GameIDs
	(
		ID INT		
	);

   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeysFromRuns;
	CREATE TEMPORARY TABLE LeaderboardKeysFromRuns
	(
		GameID INT,
		CategoryTypeID INT,
		CategoryID INT,
		LevelID INT	
	);

   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeys;
	CREATE TEMPORARY TABLE LeaderboardKeys
	(
		GameID INT,
		CategoryTypeID INT,		
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
          CategoryTypeID INT,          
          CategoryID INT,
          LevelID INT,
          SubCategoryVariableValueIDs VARCHAR(255),
          PlayerIDs VARCHAR(500),
          PrimaryTime BIGINT,
          IsTimerAscending BIT,          
          RankPriority INT,
		  PRIMARY KEY (RowNum)          
	);
	CREATE INDEX IDX_SpeedRunsToUpdate_GameID_CategoryID_LevelID ON SpeedRunsToUpdate (GameID, CategoryTypeID, CategoryID, LevelID, SubCategoryVariableValueIDs, PlayerIDs, PrimaryTime);
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

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdateBatch;
	CREATE TEMPORARY TABLE SpeedRunsToUpdateBatch
	(
		ID INT,
		PRIMARY KEY (ID)		
	);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRankedBatch;
	CREATE TEMPORARY TABLE SpeedRunsRankedBatch
	(
		ID INT,
		`Rank` INT,				
		PRIMARY KEY (ID)		
	);

	IF LastImportDate > '1753-01-01 00:00:00' THEN
		INSERT INTO LeaderboardKeysFromRuns (GameID, CategoryTypeID, CategoryID, LevelID)
		SELECT rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID
		FROM tbl_SpeedRun rn
		WHERE COALESCE(rn.ModifiedDate, rn.CreatedDate) > LastImportDate
		GROUP BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID;
    END IF;	

  	INSERT INTO GameIDs (ID)
 	SELECT g.ID
 	FROM tbl_Game g
 	WHERE COALESCE(g.ModifiedDate, g.CreatedDate) > LastImportDate;
 
  	INSERT INTO LeaderboardKeys (GameID, CategoryTypeID, CategoryID, IsTimerAscending)
	SELECT g.ID, c.CategoryTypeID, c.ID, COALESCE(c.IsTimerAscending, 0)
	FROM GameIDs g
	JOIN tbl_Category c ON c.GameID = g.ID AND c.CategoryTypeID = 0
	WHERE NOT EXISTS (SELECT 1 FROM LeaderboardKeysFromRuns WHERE GameID = g.ID AND CategoryID = c.ID)  
	GROUP BY g.ID, c.CategoryTypeID, c.ID;
 
  	INSERT INTO LeaderboardKeys (GameID, CategoryTypeID, CategoryID, LevelID, IsTimerAscending)
	SELECT g.ID, c.CategoryTypeID, c.ID, l.ID, COALESCE(c.IsTimerAscending, 0)
	FROM GameIDs g
	JOIN tbl_Category c ON c.GameID = g.ID AND c.CategoryTypeID = 1
	JOIN tbl_Level l ON l.GameID = g.ID
	WHERE NOT EXISTS (SELECT 1 FROM LeaderboardKeysFromRuns WHERE GameID = g.ID AND CategoryID = c.ID AND COALESCE(LevelID,0) = COALESCE(l.ID,0))
	GROUP BY g.ID, c.CategoryTypeID, c.ID, l.ID;
 
	INSERT INTO LeaderboardKeys (GameID, CategoryTypeID, CategoryID, LevelID, IsTimerAscending)
	SELECT rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, COALESCE(c.IsTimerAscending, 0)
	FROM LeaderboardKeysFromRuns rn
	JOIN tbl_Category c ON c.ID = rn.CategoryID;

	INSERT INTO SpeedRunsToUpdate(ID, GameID, CategoryTypeID, CategoryID, LevelID, SubCategoryVariableValueIDs, PlayerIDs, PrimaryTime, IsTimerAscending)
    SELECT rn.ID, rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, PlayerIDs.Value, rn.PrimaryTime, lb.IsTimerAscending
    FROM tbl_SpeedRun rn
    JOIN LeaderboardKeys lb ON lb.GameID = rn.GameID AND lb.CategoryTypeID = rn.CategoryTypeID AND lb.CategoryID = rn.CategoryID AND COALESCE(lb.LevelID, 0) = COALESCE(rn.LevelID, 0)
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rp.PlayerID,CHAR) ORDER BY rp.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Player rp
		WHERE rp.SpeedRunID = rn.ID
		AND rp.Deleted = 0
	) PlayerIDs ON TRUE
	WHERE rn.Deleted = 0;
  
	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum, ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn.PlayerIDs ORDER BY rn.PrimaryTime DESC)
	FROM SpeedRunsToUpdate rn
	WHERE rn.IsTimerAscending = 1;

	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum, ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn.PlayerIDs ORDER BY rn.PrimaryTime)
	FROM SpeedRunsToUpdate rn
	WHERE rn.IsTimerAscending = 0;

	UPDATE SpeedRunsToUpdate rn
	JOIN SpeedRunsToUpdateRankPriority rn1 ON rn1.RowNum = rn.RowNum
	SET rn.RankPriority = rn1.RankPriority;

	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID, RANK() OVER (PARTITION BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs ORDER BY rn.PrimaryTime DESC)  
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1
	AND rn.IsTimerAscending = 1;

	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID, RANK() OVER (PARTITION BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs ORDER BY rn.PrimaryTime)  
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1
	AND rn.IsTimerAscending = 0;

    IF Debug = 0 THEN        
    	SELECT COUNT(*) INTO MaxRowCount FROM SpeedRunsToUpdate;      
        WHILE RowCount < MaxRowCount DO
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
			TRUNCATE TABLE SpeedRunsToUpdateBatch;
	    END WHILE;
   
	   	SET RowCount = 0;
    	SELECT COUNT(*) INTO MaxRowCount FROM SpeedRunsRanked;  	   
        WHILE RowCount < MaxRowCount DO	   		
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
			TRUNCATE TABLE SpeedRunsRankedBatch;  		
	    END WHILE;		
    ELSE
		SELECT rn.RankPriority, rn.ID, rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn.PlayerIDs, rn.GuestIDs, rn.PrimaryTime
    	FROM SpeedRunsToUpdate rn
        ORDER BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn.PlayerIDs, rn.GuestIDs, rn.RankPriority;
        
        SELECT rn1.`Rank`, rn.ID, rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn.PlayerIDs, rn.GuestIDs, rn.PrimaryTime
        FROM SpeedRunsToUpdate rn
        JOIN SpeedRunsRanked rn1 ON rn1.ID = rn.ID
        ORDER BY rn.GameID, rn.CategoryTypeID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs, rn1.`Rank`;     
    END IF;
END $$
DELIMITER ;

-- ImportDeleteObsoleteSpeedRuns
DROP PROCEDURE IF EXISTS ImportDeleteObsoleteSpeedRuns;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportDeleteObsoleteSpeedRuns(
	IN LastImportDate DATETIME
)
BEGIN	
	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

   	DROP TEMPORARY TABLE IF EXISTS GameIDs;
	CREATE TEMPORARY TABLE GameIDs
	(
		ID INT		
	);

 	INSERT INTO GameIDs (ID)
 	SELECT g.ID
 	FROM tbl_Game g
 	WHERE COALESCE(g.ModifiedDate, g.CreatedDate) > LastImportDate;

	UPDATE tbl_SpeedRun rn
	JOIN GameIDs g ON g.ID = rn.GameID
	SET rn.Deleted = 1
	WHERE rn.Deleted = 0
	AND COALESCE(rn.ModifiedDate, rn.CreatedDate) <= LastImportDate;
	
END $$
DELIMITER ;

-- ImportUpdateSpeedRunSummary
DROP PROCEDURE IF EXISTS ImportUpdateSpeedRunSummary;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportUpdateSpeedRunSummary(
	IN LastImportDate DATETIME
)
BEGIN	
	
    DECLARE CurrDate DATETIME DEFAULT UTC_TIMESTAMP;
	DECLARE StartDate DATETIME DEFAULT DATE_ADD(CurrDate, INTERVAL -3 MONTH);

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	UPDATE tbl_SpeedRun_Summary dn
	JOIN tbl_SpeedRun rn ON rn.ID = dn.SpeedRunID
	SET dn.Deleted = 1
	WHERE dn.Deleted = 0
	AND COALESCE(rn.VerifyDate, '1753-01-01 00:00:00') < StartDate;

	INSERT INTO tbl_SpeedRun_Summary (SpeedRunID, Deleted)
	SELECT rn.ID, 0
	FROM tbl_SpeedRun rn
	WHERE rn.Deleted = 0
	AND rn.VerifyDate >= StartDate
	AND rn.CreatedDate > LastImportDate
	AND EXISTS (SELECT 1 FROM tbl_SpeedRun_Video rv WHERE rv.SpeedRunID = rn.ID AND rv.EmbeddedVideoLinkUrl IS NOT NULL)
	AND NOT EXISTS (SELECT 1 FROM tbl_SpeedRun_Summary rn2 WHERE rn2.SpeedRunID = rn.ID)
	ORDER BY rn.VerifyDate;
	
END $$
DELIMITER ;

-- GetPlayerSpeedRunCounts
DROP PROCEDURE IF EXISTS GetPlayerSpeedRunCounts;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE GetPlayerSpeedRunCounts(
	IN PlayerID INT
)
BEGIN
	DECLARE TotalSpeedRuns INT DEFAULT 0;
	DECLARE TotalWorldRecords INT DEFAULT 0;
	DECLARE TotalPersonalBests INT DEFAULT 0;

	SELECT COUNT(*) INTO TotalSpeedRuns
	FROM tbl_SpeedRun_Player sp
	WHERE sp.PlayerID = PlayerID;

	SELECT COUNT(*) INTO TotalWorldRecords
	FROM tbl_SpeedRun_Player sp
	JOIN tbl_SpeedRun sr ON sr.ID = sp.SpeedRunID AND sr.`Rank`=1
	WHERE sp.PlayerID = PlayerID;

	SELECT COUNT(*) INTO TotalPersonalBests
	FROM (
			SELECT sr.GameID, sr.CategoryTypeID, sr.CategoryID, sr.LevelID, sr.SubCategoryVariableValueIDs
			FROM tbl_SpeedRun_Player sp
			JOIN tbl_SpeedRun sr ON sr.ID = sp.SpeedRunID
			WHERE sp.PlayerID = PlayerID
			GROUP BY sr.GameID, sr.CategoryTypeID, sr.CategoryID, sr.LevelID, sr.SubCategoryVariableValueIDs
		) SubQuery;

	SELECT PlayerID AS ID,
	TotalSpeedRuns,
	TotalWorldRecords,
	TotalPersonalBests;

END $$
DELIMITER ;

-- GetSummaryListResults
DROP PROCEDURE IF EXISTS GetSummaryListResults;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE GetSummaryListResults
(
	IN SummaryListID INT,
	IN TopAmount INT,
	IN OrderValueOffset INT,
	IN CategoryTypeID INT
)
BEGIN	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- New
	IF SummaryListID = 0 THEN
		SELECT rn.SortOrder,
			   rn.ID,	  
			   rn.Code, 
		       rn.GameID,
		       rn.GameName,
			   rn.GameAbbr, 
		   	   rn.ShowMilliseconds,   
		       rn.GameCoverImageUrl,        
		       rn.CategoryTypeID,
		       rn.CategoryTypeName,           
		       rn.CategoryID,
		       rn.CategoryName,
			   rn.LevelID,
			   rn.LevelName,
		       rn.`Rank`,
		       rn.PrimaryTime,
		       rn.VerifyDate,
	           rn.SpeedRunVideoID,
	           rn.VideoLinkUrl,
	           rn.EmbeddedVideoLinkUrl,
	           rn.ThumbnailLinkUrl,        
	           rn.ChannelCode,              
	           rn.ViewCount,   		       
		       rn.SubCategoryVariableValueNamesJson,
		       rn.PlayersJson  
		      FROM vw_SpeedRunSummary rn
		      WHERE ((OrderValueOffset IS NULL) OR (rn.SortOrder < OrderValueOffset))
			  AND ((CategoryTypeID IS NULL) OR (rn.CategoryTypeID = CategoryTypeID))          
		      ORDER BY rn.SortOrder DESC
		      LIMIT TopAmount;
	ELSEIF SummaryListID = 1 THEN
		SELECT rn.SortOrder,
			   rn.ID,	  
			   rn.Code, 
		       rn.GameID,
		       rn.GameName,
			   rn.GameAbbr, 
		   	   rn.ShowMilliseconds,   
		       rn.GameCoverImageUrl,        
		       rn.CategoryTypeID,
		       rn.CategoryTypeName,           
		       rn.CategoryID,
		       rn.CategoryName,
			   rn.LevelID,
			   rn.LevelName,
		       rn.`Rank`,
		       rn.PrimaryTime,
		       rn.VerifyDate,
	           rn.SpeedRunVideoID,
	           rn.VideoLinkUrl,
	           rn.EmbeddedVideoLinkUrl,
	           rn.ThumbnailLinkUrl,        
	           rn.ChannelCode,              
	           rn.ViewCount,   			       
		       rn.SubCategoryVariableValueNamesJson,
		       rn.PlayersJson  
		      FROM vw_SpeedRunSummary rn
		      WHERE ((OrderValueOffset IS NULL) OR (rn.SortOrder < OrderValueOffset))
			  AND ((CategoryTypeID IS NULL) OR (rn.CategoryTypeID = CategoryTypeID))
			  AND rn.`Rank` = 1
			  AND EXISTS (SELECT 1
		  					FROM tbl_SpeedRun rn1 
		  					WHERE rn1.GameID = rn.GameID
		  					AND rn1.CategoryID = rn.CategoryID
		  					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
		  					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
		  					AND rn1.`Rank` > 1)
		      ORDER BY rn.SortOrder DESC
		      LIMIT TopAmount; 	
	ELSEIF SummaryListID = 2 THEN
		SELECT rn.SortOrder,
			   rn.ID,	  
			   rn.Code, 
		       rn.GameID,
		       rn.GameName,
			   rn.GameAbbr, 
		   	   rn.ShowMilliseconds,   
		       rn.GameCoverImageUrl,        
		       rn.CategoryTypeID,
		       rn.CategoryTypeName,           
		       rn.CategoryID,
		       rn.CategoryName,
			   rn.LevelID,
			   rn.LevelName,
		       rn.`Rank`,
		       rn.PrimaryTime,
		       rn.VerifyDate,
	           rn.SpeedRunVideoID,
	           rn.VideoLinkUrl,
	           rn.EmbeddedVideoLinkUrl,
	           rn.ThumbnailLinkUrl,        
	           rn.ChannelCode,              
	           rn.ViewCount,   			       
		       rn.SubCategoryVariableValueNamesJson,
		       rn.PlayersJson  
		      FROM vw_SpeedRunSummary rn
		      WHERE ((OrderValueOffset IS NULL) OR (rn.SortOrder < OrderValueOffset))
			  AND ((CategoryTypeID IS NULL) OR (rn.CategoryTypeID = CategoryTypeID))
			  AND rn.`Rank` <= 3
			  AND EXISTS (SELECT 1
		  					FROM tbl_SpeedRun rn1 
		  					WHERE rn1.GameID = rn.GameID
		  					AND rn1.CategoryID = rn.CategoryID
		  					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
		  					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
		  					AND rn1.`Rank` > 3)
		      ORDER BY rn.SortOrder DESC
		      LIMIT TopAmount;		
	ELSEIF SummaryListID = 3 THEN
		SELECT rn.SortOrder,
			   rn.ID,	  
			   rn.Code, 
		       rn.GameID,
		       rn.GameName,
			   rn.GameAbbr, 
		   	   rn.ShowMilliseconds,   
		       rn.GameCoverImageUrl,        
		       rn.CategoryTypeID,
		       rn.CategoryTypeName,           
		       rn.CategoryID,
		       rn.CategoryName,
			   rn.LevelID,
			   rn.LevelName,
		       rn.`Rank`,
		       rn.PrimaryTime,
		       rn.VerifyDate,
	           rn.SpeedRunVideoID,
	           rn.VideoLinkUrl,
	           rn.EmbeddedVideoLinkUrl,
	           rn.ThumbnailLinkUrl,        
	           rn.ChannelCode,              
	           rn.ViewCount,   			       
		       rn.SubCategoryVariableValueNamesJson,
		       rn.PlayersJson  
		      FROM vw_SpeedRunSummary rn
		      WHERE ((OrderValueOffset IS NULL) OR (rn.SortOrder < OrderValueOffset))
			  AND ((CategoryTypeID IS NULL) OR (rn.CategoryTypeID = CategoryTypeID))
			  AND rn.ViewCount >= 100
		      ORDER BY rn.SortOrder DESC
		      LIMIT TopAmount; 		     
	END IF;
END $$
DELIMITER ;

-- ImportRenameFullTables
DROP PROCEDURE IF EXISTS ImportRenameFullTables;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportRenameFullTables()
BEGIN	
	
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'SpeedRunAppJREOld')
	   AND EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'SpeedRunAppJRENew') THEN
		RENAME TABLE speedrunappjre.`tbl_game` TO speedrunappjreold.`tbl_game`;
		RENAME TABLE speedrunappjre.`tbl_game_link` TO speedrunappjreold.`tbl_game_link`;
		RENAME TABLE speedrunappjre.`tbl_game_categorytype` TO speedrunappjreold.`tbl_game_categorytype`;
		RENAME TABLE speedrunappjre.`tbl_category` TO speedrunappjreold.`tbl_category`;
		RENAME TABLE speedrunappjre.`tbl_level` TO speedrunappjreold.`tbl_level`;
		RENAME TABLE speedrunappjre.`tbl_variable` TO speedrunappjreold.`tbl_variable`;
		RENAME TABLE speedrunappjre.`tbl_variablevalue` TO speedrunappjreold.`tbl_variablevalue`;
		RENAME TABLE speedrunappjre.`tbl_platform` TO speedrunappjreold.`tbl_platform`;
		RENAME TABLE speedrunappjre.`tbl_game_platform` TO speedrunappjreold.`tbl_game_platform`;
		RENAME TABLE speedrunappjre.`tbl_player_link` TO speedrunappjreold.`tbl_player_link`;
		RENAME TABLE speedrunappjre.`tbl_player_namestyle` TO speedrunappjreold.`tbl_player_namestyle`;
		RENAME TABLE speedrunappjre.`tbl_speedrun_link` TO speedrunappjreold.`tbl_speedrun_link`;
		RENAME TABLE speedrunappjre.`tbl_speedrun_variablevalue` TO speedrunappjreold.`tbl_speedrun_variablevalue`;
		RENAME TABLE speedrunappjre.`tbl_speedrun_video` TO speedrunappjreold.`tbl_speedrun_video`;
		RENAME TABLE speedrunappjre.`tbl_speedrun` TO speedrunappjreold.`tbl_speedrun`;
		RENAME TABLE speedrunappjre.`tbl_speedrun_summary` TO speedrunappjreold.`tbl_speedrun_summary`;
		RENAME TABLE speedrunappjre.`tbl_player` TO speedrunappjreold.`tbl_player`;
		RENAME TABLE speedrunappjre.`tbl_speedrun_player` TO speedrunappjreold.`tbl_speedrun_player`;	
	
		RENAME TABLE speedrunappjrenew.`tbl_game` TO speedrunappjre.`tbl_game`;
		RENAME TABLE speedrunappjrenew.`tbl_game_link` TO speedrunappjre.`tbl_game_link`;
		RENAME TABLE speedrunappjrenew.`tbl_game_categorytype` TO speedrunappjre.`tbl_game_categorytype`;
		RENAME TABLE speedrunappjrenew.`tbl_category` TO speedrunappjre.`tbl_category`;
		RENAME TABLE speedrunappjrenew.`tbl_level` TO speedrunappjre.`tbl_level`;
		RENAME TABLE speedrunappjrenew.`tbl_variable` TO speedrunappjre.`tbl_variable`;
		RENAME TABLE speedrunappjrenew.`tbl_variablevalue` TO speedrunappjre.`tbl_variablevalue`;
		RENAME TABLE speedrunappjrenew.`tbl_platform` TO speedrunappjre.`tbl_platform`;
		RENAME TABLE speedrunappjrenew.`tbl_game_platform` TO speedrunappjre.`tbl_game_platform`;
		RENAME TABLE speedrunappjrenew.`tbl_player_link` TO speedrunappjre.`tbl_player_link`;
		RENAME TABLE speedrunappjrenew.`tbl_player_namestyle` TO speedrunappjre.`tbl_player_namestyle`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun_link` TO speedrunappjre.`tbl_speedrun_link`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun_variablevalue` TO speedrunappjre.`tbl_speedrun_variablevalue`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun_video` TO speedrunappjre.`tbl_speedrun_video`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun` TO speedrunappjre.`tbl_speedrun`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun_summary` TO speedrunappjre.`tbl_speedrun_summary`;
		RENAME TABLE speedrunappjrenew.`tbl_player` TO speedrunappjre.`tbl_player`;
		RENAME TABLE speedrunappjrenew.`tbl_speedrun_player` TO speedrunappjre.`tbl_speedrun_player`;
	
		UPDATE speedrunappjre.`tbl_setting` dn
	  	JOIN speedrunappjrenew.`tbl_setting`dn1 ON dn1.Name = dn.Name
	  	SET dn.Str = dn1.Str,
		    dn.Num = dn1.Num,
		    dn.Dte = dn1.Dte;	
	END IF;

END $$
DELIMITER ;

/*********************************************/
-- populate tables
/*********************************************/
INSERT INTO tbl_Setting(Name, Str, Num, Dte)
SELECT 'LastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'GameLastImportRefDate', NULL, NULL, NULL
UNION ALL
SELECT 'SpeedRunLastImportRefDate', NULL, NULL, NULL
UNION ALL
SELECT 'ReloadTime', '07:00', NULL, NULL
UNION ALL
SELECT 'YouTubeAPIEnabled',NULL,'1',NULL
UNION ALL
SELECT 'TwitchAPIEnabled',NULL,'1',NULL
UNION ALL
SELECT 'TwitchToken','6joldecpxrwo46fn7dwq95xfd9163l',NULL,NULL;

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

INSERT INTO tbl_SummaryList (ID, Name, DisplayName, Description, IsDefault, DefaultSortOrder) 
SELECT '0', 'New', 'New', 'Newly verified runs', 1, 0
UNION ALL
SELECT '1', 'WorldRecord', 'World Records', 'World Records in category with pre-existing runs', 1, 2
UNION ALL
SELECT '2', 'Top3', 'Top 3', 'Runs in top 3 of category with pre-existing runs', 1, 3
UNION ALL
SELECT '3', 'Popular', 'Popular', 'Runs with 100+ views', 1, 1

















