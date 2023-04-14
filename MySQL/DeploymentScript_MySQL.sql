USE SpeedRunApp;
-- ALTER DATABASE SpeedRunApp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

/*********************************************/
-- create/alter tables
/*********************************************/
-- tbl_UserRole
-- CALL drop_foreign_key('tbl_User', 'FK_tbl_User_tbl_UserRole');	
DROP TABLE IF EXISTS tbl_UserRole;

CREATE TABLE tbl_UserRole
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (ID)
);

-- tbl_User
-- CALL drop_foreign_key('tbl_SpeedRun_Player', 'FK_tbl_SpeedRun_Player_tbl_User');	
-- CALL drop_foreign_key('tbl_Game_Moderator', 'FK_tbl_Game_Moderator_tbl_User');
DROP TABLE IF EXISTS tbl_User;

CREATE TABLE tbl_User
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (100) NOT NULL,
	UserRoleID int NOT NULL,
    SignUpDate datetime NULL,  
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
	Abbr varchar (100) NULL,
	IsChanged bit NULL,
    PRIMARY KEY (ID)
);
-- ALTER TABLE tbl_User ADD CONSTRAINT FK_tbl_User_tbl_UserRole FOREIGN KEY (UserRoleID) REFERENCES tbl_UserRole (ID);
CREATE INDEX IDX_tbl_User_Name_PlusInclude ON tbl_User (Name, Abbr);

-- tbl_User_SpeedRunComID
DROP TABLE IF EXISTS tbl_User_SpeedRunComID;

CREATE TABLE tbl_User_SpeedRunComID
(
	UserID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (UserID)
);
CREATE INDEX IDX_tbl_User_SpeedRunComID_SpeedRunComID ON tbl_User_SpeedRunComID (SpeedRunComID);

-- tbl_User_Location
DROP TABLE IF EXISTS tbl_User_Location;

CREATE TABLE tbl_User_Location
( 
    UserID int NOT NULL,
    Location varchar (100) NULL,
    PRIMARY KEY (UserID)
);

-- tbl_User_NameStyle
DROP TABLE IF EXISTS tbl_User_NameStyle;

CREATE TABLE tbl_User_NameStyle
( 
    UserID int NOT NULL,
    IsGradient bit NOT NULL,
    ColorLight VARCHAR(10) NULL,
    ColorDark VARCHAR(10) NULL,    
    ColorToLight VARCHAR(10) NULL,
    ColorToDark VARCHAR(10) NULL,    
    PRIMARY KEY (UserID)
);

-- tbl_User_Link
DROP TABLE IF EXISTS tbl_User_Link;

CREATE TABLE tbl_User_Link
( 
    UserID int NOT NULL,
	SpeedRunComUrl varchar (1000) NULL, 
    ProfileImageUrl varchar (1000) NULL,
    TwitchProfileUrl varchar (1000) NULL,
    HitboxProfileUrl varchar (1000) NULL,
    YoutubeProfileUrl varchar (1000) NULL,
    TwitterProfileUrl varchar (1000) NULL,
    SpeedRunsLiveProfileUrl varchar (1000) NULL,
    PRIMARY KEY (UserID)    
);

-- tbl_Guest
-- CALL drop_foreign_key('tbl_Guest', 'FK_tbl_SpeedRun_Guest_tbl_Guest');	
DROP TABLE IF EXISTS tbl_Guest;

CREATE TABLE tbl_Guest
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name nvarchar (100) NOT NULL,
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	Abbr varchar(100) NULL,
	PRIMARY KEY (ID)
);
CREATE INDEX IDX_tbl_Guest_Name_PlusInclude ON tbl_Guest (Name, Abbr);

-- tbl_Guest_Link
DROP TABLE IF EXISTS tbl_Guest_Link;

CREATE TABLE tbl_Guest_Link
( 
    GuestID int NOT NULL,
	SpeedRunComUrl varchar (1000) NULL,
    PRIMARY KEY (GuestID)    
);

-- tbl_Game 
-- CALL drop_foreign_key('tbl_Level', 'FK_tbl_Level_tbl_Game');
-- CALL drop_foreign_key('tbl_Category', 'FK_tbl_Category_tbl_Game');
-- CALL drop_foreign_key('tbl_Variable', 'FK_tbl_Variable_tbl_Game');
-- CALL drop_foreign_key('tbl_VariableValue', 'FK_tbl_VariableValue_tbl_Game');
-- CALL drop_foreign_key('tbl_Game_Platform', 'FK_tbl_Game_Platform_tbl_Game');
-- CALL drop_foreign_key('tbl_Game_Region', 'FK_tbl_Game_Region_tbl_Game');
-- CALL drop_foreign_key('tbl_Game_Moderator', 'FK_tbl_Game_Moderator_tbl_Game');
-- CALL drop_foreign_key('tbl_Game_TimingMethod', 'FK_tbl_Game_TimingMethod_tbl_Game');
-- CALL drop_foreign_key('tbl_SpeedRun', 'FK_tbl_SpeedRun_tbl_Game');
DROP TABLE IF EXISTS tbl_Game;

CREATE TABLE tbl_Game 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (100) NOT NULL,
    IsRomHack bit NOT NULL,
    YearOfRelease int NULL,
    CreatedDate datetime NULL,  
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
    ModifiedDate datetime NULL,
	Abbr varchar(100) NULL,
	IsChanged bit NULL,
	PRIMARY KEY (ID)
); 
CREATE INDEX IDX_tbl_Game_Name_PlusInclude ON tbl_Game (Name, Abbr);

-- tbl_Game_SpeedRunComID
DROP TABLE IF EXISTS tbl_Game_SpeedRunComID;

CREATE TABLE tbl_Game_SpeedRunComID 
(
	GameID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
   	PRIMARY KEY (GameID) 
);
CREATE INDEX IDX_tbl_Game_SpeedRunComID_SpeedRunComID ON tbl_Game_SpeedRunComID (SpeedRunComID);

-- tbl_Game_Link
DROP TABLE IF EXISTS tbl_Game_Link;

CREATE TABLE tbl_Game_Link 
(
    GameID int NOT NULL,
    SpeedRunComUrl varchar (125) NOT NULL,
    CoverImageUrl varchar (80) NULL,
    CoverImagePath varchar (80) NULL,
   	PRIMARY KEY (GameID)     
);

-- tbl_Level
-- CALL drop_foreign_key('tbl_Variable', 'FK_tbl_Variable_tbl_Level');
-- CALL drop_foreign_key('tbl_SpeedRun', 'FK_tbl_SpeedRun_tbl_Level');
DROP TABLE IF EXISTS tbl_Level;

CREATE TABLE tbl_Level 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (100) NOT NULL,
    GameID int NOT NULL,
    PRIMARY KEY (ID) 
);
-- ALTER TABLE tbl_Level ADD CONSTRAINT FK_tbl_Level_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
CREATE INDEX IDX_tbl_Level_GameID_PlusInclude ON tbl_Level (GameID, Name);

-- tbl_Level_SpeedRunComID
DROP TABLE IF EXISTS tbl_Level_SpeedRunComID;

CREATE TABLE tbl_Level_SpeedRunComID 
(
	LevelID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (LevelID) 
);
CREATE INDEX IDX_tbl_Level_SpeedRunComID_SpeedRunComID ON tbl_Level_SpeedRunComID (SpeedRunComID);

-- tbl_Level_Rule
DROP TABLE IF EXISTS tbl_Level_Rule;

CREATE TABLE tbl_Level_Rule 
( 
    LevelID int NOT NULL, 
    Rules varchar (8000) NULL,
    PRIMARY KEY (LevelID) 
); 

-- tbl_CategoryType
-- CALL drop_foreign_key('tbl_Category', 'FK_tbl_Category_tbl_CategoryType');
DROP TABLE IF EXISTS tbl_CategoryType;

CREATE TABLE tbl_CategoryType 
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (ID) 
);

-- tbl_Category
-- CALL drop_foreign_key('tbl_Variable', 'FK_tbl_Variable_tbl_Category');
-- CALL drop_foreign_key('tbl_SpeedRun', 'FK_tbl_SpeedRun_tbl_Category');
DROP TABLE IF EXISTS tbl_Category;

CREATE TABLE tbl_Category
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (100) NOT NULL,
    GameID int NOT NULL,
    CategoryTypeID int NOT NULL,
    IsMiscellaneous bit NOT NULL, 
    IsTimerAscending bit NOT NULL,     
    PRIMARY KEY (ID)     
);
-- ALTER TABLE tbl_Category ADD CONSTRAINT FK_tbl_Category_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Category (ID);
-- ALTER TABLE tbl_Category ADD CONSTRAINT FK_tbl_Category_tbl_CategoryType FOREIGN KEY (CategoryTypeID) REFERENCES tbl_Category (ID);
CREATE INDEX IDX_tbl_Category_GameID_CategoryTypeID_PlusInclude ON tbl_Category (GameID, CategoryTypeID, Name);

-- tbl_Category_SpeedRunComID
DROP TABLE IF EXISTS tbl_Category_SpeedRunComID;

CREATE TABLE tbl_Category_SpeedRunComID 
(
	CategoryID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (CategoryID)        
);
CREATE INDEX IDX_tbl_Category_SpeedRunComID_SpeedRunComID ON tbl_Category_SpeedRunComID (SpeedRunComID);

-- tbl_Category_Rule
DROP TABLE IF EXISTS tbl_Category_Rule;

CREATE TABLE tbl_Category_Rule 
( 
    CategoryID int NOT NULL, 
    Rules varchar (15500) NULL,
    PRIMARY KEY (CategoryID)      
);

-- tbl_VariableScopeType
-- CALL drop_foreign_key('tbl_Variable', 'FK_tbl_Variable_tbl_VariableScopeType');
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
    Name varchar (100) NOT NULL,
    GameID int NOT NULL,
    VariableScopeTypeID int NOT NULL,
    CategoryID int NULL,
    LevelID int NULL,
    IsSubCategory bit NOT NULL,
    PRIMARY KEY (ID)        
);
-- ALTER TABLE tbl_Variable ADD CONSTRAINT FK_tbl_Variable_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_Variable ADD CONSTRAINT FK_tbl_Variable_tbl_Level FOREIGN KEY (CategoryTypeID) REFERENCES tbl_Level (ID);
-- ALTER TABLE tbl_Variable ADD CONSTRAINT FK_tbl_Variable_tbl_Category FOREIGN KEY (CategoryID) REFERENCES tbl_Category (ID);
-- ALTER TABLE tbl_Variable ADD CONSTRAINT FK_tbl_Variable_tbl_VariableScopeType FOREIGN KEY (VariableScopeTypeID) REFERENCES tbl_VariableScopeType (ID);
CREATE INDEX IDX_tbl_Variable_GameID ON tbl_Variable (GameID);
CREATE INDEX IDX_tbl_Variable_IsSubCategory ON tbl_Variable (IsSubCategory);

-- tbl_Variable_SpeedRunComID
DROP TABLE IF EXISTS tbl_Variable_SpeedRunComID;

CREATE TABLE tbl_Variable_SpeedRunComID 
(
	VariableID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (VariableID)       
);
CREATE INDEX IDX_tbl_Variable_SpeedRunComID_SpeedRunComID ON tbl_Variable_SpeedRunComID (SpeedRunComID);

-- tbl_VariableValue
DROP TABLE IF EXISTS tbl_VariableValue;

CREATE TABLE tbl_VariableValue
( 
    ID int NOT NULL AUTO_INCREMENT, 
    GameID int NOT NULL,   
    VariableID int NOT NULL, 
    Value varchar (100) NOT NULL, 
    IsCustomValue bit NOT NULL,
    PRIMARY KEY (ID)      
);
-- ALTER TABLE tbl_VariableValue ADD CONSTRAINT FK_tbl_VariableValue_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
CREATE INDEX IDX_tbl_VariableValue_GameID_PlusInclude ON tbl_VariableValue (GameID,VariableID,Value);

-- tbl_VariableValue_SpeedRunComID
DROP TABLE IF EXISTS tbl_VariableValue_SpeedRunComID;

CREATE TABLE tbl_VariableValue_SpeedRunComID 
(
	VariableValueID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (VariableValueID)          
);
CREATE INDEX IDX_tbl_VariableValue_SpeedRunComID_SpeedRunComID ON tbl_VariableValue_SpeedRunComID (SpeedRunComID);

-- tbl_Platform
-- CALL drop_foreign_key('tbl_Game_Platform', 'FK_tbl_Game_Platform_tbl_Platform');
-- CALL drop_foreign_key('tbl_SpeedRun_System', 'FK_tbl_SpeedRun_System_tbl_Platform');
DROP TABLE IF EXISTS tbl_Platform;

CREATE TABLE tbl_Platform 
( 
    ID int NOT NULL AUTO_INCREMENT, 
    Name varchar (50) NOT NULL,
    YearOfRelease int NULL,
    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
    PRIMARY KEY (ID)   
);

-- tbl_Platform_SpeedRunComID
DROP TABLE IF EXISTS tbl_Platform_SpeedRunComID;

CREATE TABLE tbl_Platform_SpeedRunComID 
(
	PlatformID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (PlatformID)       
);
CREATE INDEX IDX_tbl_Platform_SpeedRunComID_SpeedRunComID ON tbl_Platform_SpeedRunComID (SpeedRunComID);

-- tbl_Game_Platform
DROP TABLE IF EXISTS tbl_Game_Platform;

CREATE TABLE tbl_Game_Platform
(     
    ID int NOT NULL AUTO_INCREMENT, 
    GameID int NOT NULL,
    PlatformID int NOT NULL,
    PRIMARY KEY (ID)     
);
-- ALTER TABLE tbl_Game_Platform ADD CONSTRAINT FK_tbl_Game_Platform_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_Game_Platform ADD CONSTRAINT FK_tbl_Game_Platform_tbl_Platform FOREIGN KEY (PlatformID) REFERENCES tbl_Platform (ID);
CREATE INDEX IDX_tbl_Game_Platform_GameID_PlatformID ON tbl_Game_Platform (GameID,PlatformID);

-- tbl_Region
DROP TABLE IF EXISTS tbl_Region;

CREATE TABLE tbl_Region
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL, 
    Abbreviation varchar (10) NULL,
    PRIMARY KEY (ID)       
);

-- tbl_Region_SpeedRunComID
DROP TABLE IF EXISTS tbl_Region_SpeedRunComID;

CREATE TABLE tbl_Region_SpeedRunComID 
(
	RegionID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
    PRIMARY KEY (RegionID)      
);

-- tbl_Game_Region
DROP TABLE IF EXISTS tbl_Game_Region;

CREATE TABLE tbl_Game_Region 
( 
    ID int NOT NULL AUTO_INCREMENT,
    GameID int NOT NULL,
    RegionID int NOT NULL,
    PRIMARY KEY (ID)      
);
-- ALTER TABLE tbl_Game_Region ADD CONSTRAINT FK_tbl_Game_Region_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_Game_Region ADD CONSTRAINT FK_tbl_Game_Region_tbl_Region FOREIGN KEY (RegionID) REFERENCES tbl_Region (ID);

-- tbl_Game_Moderator
DROP TABLE IF EXISTS tbl_Game_Moderator;

CREATE TABLE tbl_Game_Moderator 
( 
    ID int NOT NULL AUTO_INCREMENT,
    GameID int NOT NULL,
    UserID int NOT NULL,
    PRIMARY KEY (ID)      
);
-- ALTER TABLE tbl_Game_Moderator ADD CONSTRAINT FK_tbl_Game_Moderator_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_Game_Moderator ADD CONSTRAINT FK_tbl_Game_Moderator_tbl_User FOREIGN KEY (UserID) REFERENCES tbl_User (ID);
CREATE INDEX IDX_tbl_Game_Moderator_GameID_UserID ON tbl_Game_Moderator (GameID,UserID);

-- tbl_TimingMethod
-- CALL drop_foreign_key('tbl_Game_TimingMethod', 'FK_tbl_Game_TimingMethod_tbl_TimingMethod');
DROP TABLE IF EXISTS tbl_TimingMethod;

CREATE TABLE tbl_TimingMethod 
( 
    ID int NOT NULL,
    Name varchar (50) NOT NULL,
    PRIMARY KEY (ID)     
);

-- tbl_Game_TimingMethod
DROP TABLE IF EXISTS tbl_Game_TimingMethod;

CREATE TABLE tbl_Game_TimingMethod 
( 
    ID int NOT NULL AUTO_INCREMENT,
    GameID int NOT NULL,
    TimingMethodID int NOT NULL,
  	PRIMARY KEY (ID)  
);
-- ALTER TABLE tbl_Game_TimingMethod ADD CONSTRAINT FK_tbl_Game_TimingMethod_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_Game_TimingMethod ADD CONSTRAINT FK_tbl_Game_TimingMethod_tbl_TimingMethod FOREIGN KEY (TimingMethodID) REFERENCES tbl_TimingMethod (ID);

-- tbl_Game_Ruleset
DROP TABLE IF EXISTS tbl_Game_Ruleset;

CREATE TABLE tbl_Game_Ruleset 
( 
    GameID int NOT NULL,
    ShowMilliseconds bit NOT NULL,
    RequiresVerification bit NOT NULL,
    RequiresVideo bit NOT NULL,
    DefaultTimingMethodID int NOT NULL,
    EmulatorsAllowed bit NOT NULL,
  	PRIMARY KEY (GameID)      
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

-- tbl_SpeedRunStatusType
-- CALL drop_foreign_key('tbl_SpeedRun', 'FK_tbl_SpeedRun_tbl_RunStatusType');
DROP TABLE IF EXISTS tbl_RunStatusType;

CREATE TABLE tbl_RunStatusType 
( 
    ID int NOT NULL,
    Name varchar (25) NOT NULL,
  	PRIMARY KEY (ID)      
);

-- tbl_SpeedRun
-- CALL drop_foreign_key('tbl_SpeedRun_Player', 'FK_tbl_SpeedRun_Player_tbl_SpeedRun');
-- CALL drop_foreign_key('tbl_SpeedRun_Guest', 'FK_tbl_SpeedRun_Guest_tbl_SpeedRun');
-- CALL drop_foreign_key('tbl_SpeedRun_VariableValue', 'FK_tbl_SpeedRun_VariableValue_tbl_SpeedRun');
-- CALL drop_foreign_key('tbl_SpeedRun_Video', 'FK_tbl_SpeedRun_Video_tbl_SpeedRun');
DROP TABLE IF EXISTS tbl_SpeedRun;

CREATE TABLE tbl_SpeedRun 
( 
    ID int NOT NULL AUTO_INCREMENT, 
	StatusTypeID int NOT NULL,
	GameID int NOT NULL,
	CategoryID int NOT NULL,
	LevelID int NULL,
	`Rank` int NULL,
	PrimaryTime bigint NOT NULL,
	IsExcludeFromSpeedRunList bit NOT NULL,
	RunDate datetime NULL,
	DateSubmitted datetime NULL,
	VerifyDate datetime NULL,
	ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	ModifiedDate datetime NULL,
  	PRIMARY KEY (ID) 	
);
-- ALTER TABLE tbl_SpeedRun ADD CONSTRAINT FK_tbl_SpeedRun_tbl_Game FOREIGN KEY (GameID) REFERENCES tbl_Game (ID);
-- ALTER TABLE tbl_SpeedRun ADD CONSTRAINT FK_tbl_SpeedRun_tbl_RunStatusType FOREIGN KEY (StatusTypeID) REFERENCES tbl_RunStatusType (ID);
-- ALTER TABLE tbl_SpeedRun ADD CONSTRAINT FK_tbl_SpeedRun_tbl_Level FOREIGN KEY (LevelID) REFERENCES tbl_Level (ID);
-- ALTER TABLE tbl_SpeedRun ADD CONSTRAINT FK_tbl_SpeedRun_tbl_Category FOREIGN KEY (CategoryID) REFERENCES tbl_Category (ID);
-- ALTER TABLE tbl_SpeedRun_Guest ADD CONSTRAINT FK_tbl_SpeedRun_tbl_Category FOREIGN KEY (CategoryID) REFERENCES tbl_Category (ID);
CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate ON tbl_SpeedRun (GameID, CategoryID, LevelID, `Rank`, VerifyDate);
CREATE INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank ON tbl_SpeedRun (IsExcludeFromSpeedRunList, `Rank`);

-- tbl_SpeedRun_SpeedRunComID
DROP TABLE IF EXISTS tbl_SpeedRun_SpeedRunComID;

CREATE TABLE tbl_SpeedRun_SpeedRunComID 
(
	SpeedRunID int NOT NULL,
    SpeedRunComID varchar (10) NOT NULL,
  	PRIMARY KEY (SpeedRunID)     
);
CREATE INDEX IDX_tbl_SpeedRun_SpeedRunComID_SpeedRunComID ON tbl_SpeedRun_SpeedRunComID (SpeedRunComID);

-- tbl_SpeedRun_System
DROP TABLE IF EXISTS tbl_SpeedRun_System;

CREATE TABLE tbl_SpeedRun_System 
( 
    SpeedRunID int NOT NULL,
	PlatformID int NULL,
	RegionID int NULL,
 	IsEmulated bit NOT NULL,
 	PRIMARY KEY (SpeedRunID)   	
);
-- ALTER TABLE tbl_SpeedRun_System ADD CONSTRAINT FK_tbl_SpeedRun_System_tbl_Platform FOREIGN KEY (PlatformID) REFERENCES tbl_Platform (ID);
-- ALTER TABLE tbl_SpeedRun_System ADD CONSTRAINT FK_tbl_SpeedRun_System_tbl_Region FOREIGN KEY (RegionID) REFERENCES tbl_Region (ID);

-- tbl_SpeedRun_Times
DROP TABLE IF EXISTS tbl_SpeedRun_Time;

CREATE TABLE tbl_SpeedRun_Time 
( 
    SpeedRunID int NOT NULL,
	PrimaryTime bigint NOT NULL,
	RealTime bigint NULL,
	RealTimeWithoutLoads bigint NULL,
	GameTime bigint NULL,
 	PRIMARY KEY (SpeedRunID)   	
);

-- tbl_SpeedRun_Link
DROP TABLE IF EXISTS tbl_SpeedRun_Link;

CREATE TABLE tbl_SpeedRun_Link 
( 
    SpeedRunID int NOT NULL,
	SpeedRunComUrl varchar(1000) NOT NULL,
	SplitsUrl varchar(1000) NULL,
 	PRIMARY KEY (SpeedRunID) 	
);

-- tbl_SpeedRun_Comment
DROP TABLE IF EXISTS tbl_SpeedRun_Comment;

CREATE TABLE tbl_SpeedRun_Comment 
(
    SpeedRunID int NOT NULL,
	Comment varchar(2000) NULL,
 	PRIMARY KEY (SpeedRunID)	
);

-- tbl_SpeedRun_Player
DROP TABLE IF EXISTS tbl_SpeedRun_Player;

CREATE TABLE tbl_SpeedRun_Player 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    UserID int NOT NULL,
	PRIMARY KEY (ID)	 
);
-- ALTER TABLE tbl_SpeedRun_Player ADD CONSTRAINT FK_tbl_SpeedRun_Player_tbl_SpeedRun FOREIGN KEY (SpeedRunID) REFERENCES tbl_SpeedRun (ID);
-- ALTER TABLE tbl_SpeedRun_Player ADD CONSTRAINT FK_tbl_SpeedRun_Player_tbl_User FOREIGN KEY (UserID) REFERENCES tbl_User (ID);
CREATE INDEX IDX_tbl_SpeedRun_Player_SpeedRunID_UserID ON tbl_SpeedRun_Player (SpeedRunID,UserID);
CREATE INDEX IDX_tbl_SpeedRun_Player_UserID ON tbl_SpeedRun_Player (UserID);

-- tbl_SpeedRun_Guest
DROP TABLE IF EXISTS tbl_SpeedRun_Guest;

CREATE TABLE tbl_SpeedRun_Guest 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    GuestID int NOT NULL,
	PRIMARY KEY (ID)	    
); 
-- ALTER TABLE tbl_SpeedRun_Guest ADD CONSTRAINT FK_tbl_SpeedRun_Guest_tbl_SpeedRun FOREIGN KEY (SpeedRunID) REFERENCES tbl_SpeedRun (ID);
CREATE INDEX IDX_tbl_SpeedRun_Guest_SpeedRunID_GuestID ON tbl_SpeedRun_Guest (SpeedRunID,GuestID);

-- tbl_SpeedRun_VariableValue
DROP TABLE IF EXISTS tbl_SpeedRun_VariableValue;

CREATE TABLE tbl_SpeedRun_VariableValue 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    VariableID int NOT NULL,
    VariableValueID int NOT NULL,
	PRIMARY KEY (ID)    
); 
-- ALTER TABLE tbl_SpeedRun_VariableValue ADD CONSTRAINT FK_tbl_SpeedRun_VariableValue_tbl_SpeedRun FOREIGN KEY (SpeedRunID) REFERENCES tbl_SpeedRun (ID);
CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableValueID ON tbl_SpeedRun_VariableValue (SpeedRunID,VariableValueID,VariableID);
CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID ON tbl_SpeedRun_VariableValue (SpeedRunID,VariableID,VariableValueID);

-- tbl_SpeedRun_Video
DROP TABLE IF EXISTS tbl_SpeedRun_Video;

CREATE TABLE tbl_SpeedRun_Video 
( 
    ID int NOT NULL AUTO_INCREMENT,
    SpeedRunID int NOT NULL,
    VideoLinkUrl varchar (500) NOT NULL,
    EmbeddedVideoLinkUrl varchar (250) NULL,
	ThumbnailLinkUrl varchar(250) NULL,
	PRIMARY KEY (ID) 	
);
-- ALTER TABLE tbl_SpeedRun_Video ADD CONSTRAINT FK_tbl_SpeedRun_Video_tbl_SpeedRun FOREIGN KEY (SpeedRunID) REFERENCES tbl_SpeedRun (ID);
-- CREATE INDEX IDX_tbl_SpeedRun_Video_SpeedRunID_EmbeddedVideoLinkUrl_PlusInclude ON tbl_SpeedRun_Video (SpeedRunID,EmbeddedVideoLinkUrl,ThumbnailLinkUrl);
CREATE INDEX IDX_tbl_SpeedRun_Video_SpeedRunID ON tbl_SpeedRun_Video (SpeedRunID);

-- tbl_SpeedRun_Video_Detail
DROP TABLE IF EXISTS tbl_SpeedRun_Video_Detail;

CREATE TABLE tbl_SpeedRun_Video_Detail(
	SpeedRunVideoID int NOT NULL,
	SpeedRunID int NOT NULL,
	ChannelCode varchar(50) NULL,
	ViewCount int NULL,
	PRIMARY KEY (SpeedRunVideoID) 	
);
CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_SpeedRunID ON tbl_SpeedRun_Video_Detail (SpeedRunID);
CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_ChannelCode_SpeedRunID ON tbl_SpeedRun_Video_Detail (ChannelCode, SpeedRunID);

-- tbl_SpeedRunListCategory
DROP TABLE IF EXISTS tbl_SpeedRunListCategory;

CREATE TABLE tbl_SpeedRunListCategory(
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	DisplayName varchar(50) NULL,
	Description varchar(250) NULL,
	IsDefault bit NOT NULL,
	DefaultSortOrder int NULL,
	PRIMARY KEY (ID) 	
);

-- tbl_UserAccount
DROP TABLE IF EXISTS tbl_UserAccount;

CREATE TABLE tbl_UserAccount(
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

-- tbl_UserAccount_Setting
DROP TABLE IF EXISTS tbl_UserAccount_Setting;

CREATE TABLE tbl_UserAccount_Setting(
	UserAccountID int NOT NULL,
	IsDarkTheme bit NOT NULL,
	PRIMARY KEY (UserAccountID)	
);

-- tbl_UserAccount_SpeedRunListCategory
DROP TABLE IF EXISTS tbl_UserAccount_SpeedRunListCategory;

CREATE TABLE tbl_UserAccount_SpeedRunListCategory(
	ID int NOT NULL AUTO_INCREMENT,
	UserAccountID int NOT NULL,
	SpeedRunListCategoryID int NOT NULL,
	PRIMARY KEY (ID)		
);

-- tbl_Channel
DROP TABLE IF EXISTS tbl_Channel;

CREATE TABLE tbl_Channel
( 
    ID int NOT NULL AUTO_INCREMENT,
    Code varchar (25) NOT NULL,
    Name varchar (50) NOT NULL,
    PRIMARY KEY (ID)
);

/*********************************************/
-- create/alter views
/*********************************************/
-- vw_Game
DROP VIEW IF EXISTS vw_Game;

CREATE DEFINER=`root`@`localhost` VIEW vw_Game AS

    SELECT g.ID, g.Name, g.Abbr, gl.CoverImagePath AS CoverImageUrl, g.YearOfRelease, COALESCE(g.IsChanged, 0) AS IsChanged, gr.ShowMilliseconds, CategoryTypes.Value AS CategoryTypes, Categories.Value AS Categories, Levels.Value AS Levels,
        Variables.Value AS Variables, VariableValues.Value AS VariableValues, Platforms.Value AS Platforms, Moderators.Value AS Moderators, gl.SpeedRunComUrl        
    FROM tbl_Game g
    JOIN tbl_Game_Link gl ON gl.GameID = g.ID
    JOIN tbl_Game_Ruleset gr ON gr.GameID = g.ID
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(ct1.ID,CHAR), '|', ct1.Name) ORDER BY ct1.ID SEPARATOR '^^') Value
		FROM (SELECT ct.ID, ct.Name
		FROM tbl_CategoryType ct
		JOIN tbl_Category c ON c.CategoryTypeID = ct.ID
		WHERE c.GameID = g.ID
		GROUP BY ct.ID, ct.Name) ct1
	) CategoryTypes ON TRUE   
    LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(c.ID,CHAR), '|', CONVERT(c.CategoryTypeID,CHAR), '|', CASE c.IsTimerAscending WHEN 1 THEN 'True' ELSE 'False' END, '|', c.Name) ORDER BY c.IsMiscellaneous, c.ID SEPARATOR '^^') Value
        FROM tbl_Category c
        WHERE c.GameID = g.ID
    ) Categories ON TRUE
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(l.ID,CHAR), '|', l.Name) ORDER BY l.ID SEPARATOR '^^') Value
        FROM tbl_Level l
        WHERE l.GameID = g.ID
    ) Levels ON TRUE  
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(v.ID,CHAR), '|', CASE v.IsSubCategory WHEN 1 THEN 'True' ELSE 'False' END, '|', CONVERT(v.VariableScopeTypeID, CHAR), '|', COALESCE(CONVERT(v.CategoryID, CHAR),''), '|', COALESCE(CONVERT(v.LevelID, CHAR),''), '|', v.Name) ORDER BY v.ID SEPARATOR '^^') Value
        FROM tbl_Variable v
        WHERE v.GameID = g.ID
    ) Variables ON TRUE      
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(v.ID,CHAR), '|', CONVERT(v.VariableID,CHAR), '|', v.Value) ORDER BY v.ID SEPARATOR '^^') Value
        FROM tbl_VariableValue v
        WHERE v.GameID = g.ID
    ) VariableValues ON TRUE    
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(p.ID,CHAR), '|', p.Name) ORDER BY p.ID SEPARATOR '^^') Value
	    FROM tbl_Platform p
	    JOIN tbl_Game_Platform gp ON gp.PlatformID = p.ID 
        WHERE gp.GameID = g.ID
    ) Platforms ON TRUE   
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name, '¦', u.Abbr, '¦', COALESCE(nt.ColorLight,''), '¦', COALESCE(nt.ColorToLight,''), '¦', COALESCE(nt.ColorDark,''), '¦', COALESCE(nt.ColorToDark,'')) ORDER BY gm.ID SEPARATOR '^^') Value
		FROM tbl_User u
		JOIN tbl_Game_Moderator gm ON gm.UserID = u.ID
		LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID
		WHERE gm.GameID = g.ID
    ) Moderators ON TRUE;
   
 -- vw_GameSpeedRunCom
 DROP VIEW IF EXISTS vw_GameSpeedRunCom;

CREATE DEFINER=`root`@`localhost` VIEW vw_GameSpeedRunCom AS
	
	SELECT g.ID,
	       gc.SpeedRunComID,  
	       g.Name,
	       g.IsRomHack,
	       g.YearOfRelease,
	       gl.CoverImageUrl,      
	       Categories.Value AS CategorySpeedRunComIDs,
	       Levels.Value AS LevelSpeedRunComIDs,
	       Variables.Value AS VariableSpeedRunComIDs,
	       VariableValues.Value AS VariableValueSpeedRunComIDs,
	       Platforms.Value AS PlatformSpeedRunComIDs,
	       Moderators.Value AS ModeratorSpeedRunComIDs,
	       g.CreatedDate,
	       g.ModifiedDate,
	       g.IsChanged
	FROM tbl_Game g
	JOIN tbl_Game_SpeedRunComID gc ON gc.GameID = g.ID
	JOIN tbl_Game_Link gl ON gl.GameID = g.ID 
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(cc.SpeedRunComID ORDER BY c.ID SEPARATOR ',') Value
	    FROM tbl_Category c
	    JOIN tbl_Category_SpeedRunComID cc ON cc.CategoryID=c.ID
	    WHERE c.GameID = g.ID
	) Categories ON TRUE   
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(lc.SpeedRunComID ORDER BY l.ID SEPARATOR ',') Value
	    FROM tbl_Level l
	    JOIN tbl_Level_SpeedRunComID lc ON lc.LevelID = l.ID
	    WHERE l.GameID = g.ID
	) Levels ON TRUE 
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(vc.SpeedRunComID ORDER BY v.ID SEPARATOR ',') Value
	    FROM tbl_Variable v
	    JOIN tbl_Variable_SpeedRunComID vc ON vc.VariableID = v.ID
	    WHERE v.GameID = g.ID
	) Variables ON TRUE  
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(vc.SpeedRunComID ORDER BY v.ID SEPARATOR ',') Value
	    FROM tbl_VariableValue v
	    JOIN tbl_VariableValue_SpeedRunComID vc ON vc.VariableValueID = v.ID
	    WHERE v.GameID = g.ID
	) VariableValues ON TRUE  	    	   
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(pc.SpeedRunComID ORDER BY p.ID SEPARATOR ',') Value
	    FROM tbl_Platform p
	    JOIN tbl_Game_Platform gp ON gp.PlatformID = p.ID
	    JOIN tbl_Platform_SpeedRunComID pc ON pc.PlatformID = p.ID
	    WHERE gp.GameID = g.ID
	) Platforms ON TRUE    	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(uc.SpeedRunComID ORDER BY gm.ID SEPARATOR ',') Value
		FROM tbl_User u
		JOIN tbl_Game_Moderator gm ON gm.UserID = u.ID
	    JOIN tbl_User_SpeedRunComID uc ON uc.UserID = u.ID 
		WHERE gm.GameID = g.ID
	) Moderators ON TRUE;     
     
-- vw_SpeedRun
DROP VIEW IF EXISTS vw_SpeedRun;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRun AS

    SELECT rn.ID,
           g.ID AS GameID,
           g.Name AS GameName,
           st.ID AS StatusTypeID,
           st.Name AS StatusTypeName,           
           gl.CoverImageUrl AS GameCoverImageUrl,
           ct.ID AS CategoryTypeID,
           ct.Name AS CategoryTypeName,
           c.ID AS CategoryID,
           c.Name AS CategoryName,
		   l.ID AS LevelID,
		   l.Name AS LevelName,
           pl.ID AS PlatformID,
           pl.Name AS PlatformName,
           VariableValues.Value AS VariableValues,
           Players.Value AS Players,
           Guests.Value AS Guests,
           VideoLinks.Value AS VideoLinks,
		   EmbeddedVideoLinks.Value AS EmbeddedVideoLinks,
           rs.IsEmulated,
           rn.Rank,
           rt.PrimaryTime,
           rt.RealTime,
           rt.RealTimeWithoutLoads,
           rt.GameTime,
           rc.Comment,
           rl.SpeedRunComUrl,
           rl.SplitsUrl,
           rn.RunDate,
           rn.DateSubmitted,
           rn.VerifyDate
    FROM tbl_SpeedRun rn 
    JOIN tbl_Game g  ON g.ID = rn.GameID
	JOIN tbl_Game_Link gl  ON gl.GameID = rn.GameID
    JOIN tbl_RunStatusType st ON st.ID = rn.StatusTypeID 
    JOIN tbl_Category c  ON c.ID = rn.CategoryID
    JOIN tbl_CategoryType ct ON ct.ID = c.CategoryTypeID
    JOIN tbl_SpeedRun_System rs ON rs.SpeedRunID = rn.ID
    JOIN tbl_SpeedRun_Time rt ON rt.SpeedRunID = rn.ID
    JOIN tbl_SpeedRun_Link rl ON rl.SpeedRunID = rn.ID
    LEFT JOIN tbl_Level l  ON l.ID = rn.LevelID
    LEFT JOIN tbl_Platform pl on pl.ID = rs.PlatformID
    LEFT JOIN tbl_SpeedRun_Comment rc ON rc.SpeedRunID = rn.ID
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(rv.VariableID,CHAR), '|', CONVERT(rv.VariableValueID,CHAR)) ORDER BY rv.ID SEPARATOR ',') Value
        FROM tbl_SpeedRun_VariableValue rv
        WHERE rv.SpeedRunID = rn.ID
	) VariableValues ON TRUE      
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '|', u.Name) ORDER BY rp.ID SEPARATOR '^^') Value
        FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE 
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(g.ID,CHAR), '|', g.Name) ORDER BY rg.ID SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Guest rg  
		JOIN tbl_Guest g ON g.ID = rg.GuestID
		WHERE rg.SpeedRunID = rn.ID
	) Guests ON TRUE 
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(rd.VideoLinkUrl ORDER BY rd.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Video rd 
	    WHERE rd.SpeedRunID = rn.ID
	) VideoLinks ON TRUE 
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(rd.EmbeddedVideoLinkUrl ORDER BY rd.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Video rd
	    WHERE rd.SpeedRunID = rn.ID
	    AND rd.EmbeddedVideoLinkUrl IS NOT NULL
	) EmbeddedVideoLinks ON TRUE;

-- vw_SpeedRunGrid
DROP VIEW IF EXISTS vw_SpeedRunGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGrid AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
           p.ID AS PlatformID,
           p.Name AS PlatformName,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           VariableValues.Value AS VariableValues,
           Players.Value AS Players,
		   Guests.Value AS Guests,
           rn.Rank,
           rn.PrimaryTime,
           rc.Comment,
           rn.DateSubmitted,
           rn.VerifyDate
    FROM tbl_SpeedRun rn
   	JOIN tbl_SpeedRun_System rs ON rs.SpeedRunID = rn.ID 
   	LEFT JOIN tbl_SpeedRun_Comment rc ON rc.SpeedRunID = rn.ID
   	LEFT JOIN tbl_Platform p ON p.ID = rs.PlatformID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE      	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(rv.VariableID,CHAR), '|', CONVERT(rv.VariableValueID,CHAR)) SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    WHERE rv.SpeedRunID = rn.ID   
	) VariableValues ON TRUE     
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name, '¦', u.Abbr, '¦', COALESCE(nt.ColorLight,''), '¦', COALESCE(nt.ColorToLight,''), '¦', COALESCE(nt.ColorDark,''), '¦', COALESCE(nt.ColorToDark,'')) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE    	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(g.ID,CHAR), '¦', g.Name, '¦', g.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Guest rg
		JOIN tbl_Guest g ON g.ID = rg.GuestID
		WHERE rg.SpeedRunID = rn.ID
	) Guests ON TRUE;

-- vw_SpeedRunGridTab
DROP VIEW IF EXISTS vw_SpeedRunGridTab;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridTab AS

    SELECT rn.ID,
           rn.GameID,
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

-- vw_SpeedRunGridUser
DROP VIEW IF EXISTS vw_SpeedRunGridUser;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridUser AS

	SELECT rn.ID,
		   rn1.SpeedRunComID,
           rn.GameID,
           c.ID AS CategoryID,
           c.Name AS CategoryName,
           c.IsTimerAscending,
           c.IsMiscellaneous,
           l.ID AS LevelID,
           l.Name AS LevelName,           
           rn.PlatformID,
           rn.PlatformName,
           rn.SubCategoryVariableValueIDs,
           SubCategoryVariableValues.Value AS SubCategoryVariableValues,
           rn.VariableValues,
           rn.Players,
           rn.Guests,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.Comment,
           rn.DateSubmitted,
           rn.VerifyDate,
           rp.UserID
    FROM vw_SpeedRunGrid rn
    JOIN tbl_speedrun_speedruncomid rn1 ON rn1.SpeedRunID = rn.ID
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(va.Value ORDER BY rv.ID SEPARATOR ', ') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE;

-- vw_WorldRecordGrid
DROP VIEW IF EXISTS vw_WorldRecordGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_WorldRecordGrid AS

	SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           c.Name AS CategoryName,
           c.CategoryTypeID,           
           rn.LevelID,
           l.Name AS LevelName,           
           rn.PlatformID,
           rn.PlatformName,
           rn.SubCategoryVariableValueIDs,
           rn.VariableValues,
           rn.Players,
		   rn.Guests,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.Comment,
           rn.DateSubmitted,
           rn.VerifyDate
    FROM vw_SpeedRunGrid rn
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID;
	
-- vw_WorldRecordGridUser
DROP VIEW IF EXISTS vw_WorldRecordGridUser;

CREATE DEFINER=`root`@`localhost` VIEW vw_WorldRecordGridUser AS

	SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.CategoryName,
           rn.CategoryTypeID,           
           rn.LevelID,
           rn.LevelName,           
           rn.PlatformID,
           rn.PlatformName,
           rn.SubCategoryVariableValueIDs,
           rn.VariableValues,
           rn.Players,
		   rn.Guests,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.Comment,
           rn.DateSubmitted,
           rn.VerifyDate,
           rp.UserID
    FROM vw_WorldRecordGrid rn
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID;
   
-- vw_SpeedRunSummary
DROP VIEW IF EXISTS vw_SpeedRunSummary;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunSummary AS

    SELECT rn.ID,
    	   rn1.SpeedRunComID,
           g.ID AS GameID,
           g.Name AS GameName,
		   g.Abbr AS GameAbbr, 
           gl.CoverImagePath AS GameCoverImageUrl,
		   gr.ShowMilliseconds,           
           ct.ID AS CategoryTypeID,
           ct.Name AS CategoryTypeName,           
           c.ID AS CategoryID,
           c.Name AS CategoryName,
		   l.ID AS LevelID,
		   l.Name AS LevelName,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,		   
           SubCategoryVariableValues.Value AS SubCategoryVariableValues,           
           Players.Value AS Players,
 		   EmbeddedVideoLinks.Value AS EmbeddedVideoLinks,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.DateSubmitted,
		   COALESCE(rn.VerifyDate, rn.DateSubmitted) AS VerifyDate,
           rn.ImportedDate,
           rn.IsExcludeFromSpeedRunList           
    FROM tbl_SpeedRun rn
    JOIN tbl_SpeedRun_SpeedRunComID rn1 ON rn1.SpeedRunID = rn.ID
    JOIN tbl_Game g ON g.ID = rn.GameID
	JOIN tbl_Game_Link gl ON gl.GameID = g.ID
	JOIN tbl_Game_Ruleset gr ON gr.GameID = g.ID
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    JOIN tbl_CategoryType ct ON ct.ID = c.CategoryTypeID 
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE     
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(va.Value ORDER BY rv.ID SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
		JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE    
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name, '¦', u.Abbr, '¦', COALESCE(nt.ColorLight,''), '¦', COALESCE(nt.ColorToLight,''), '¦', COALESCE(nt.ColorDark,''), '¦', COALESCE(nt.ColorToDark,'')) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE       
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(rd.EmbeddedVideoLinkUrl, '|', COALESCE(rd.ThumbnailLinkUrl,''), '|', CONVERT(COALESCE(rd1.ViewCount,''),CHAR)) ORDER BY rd.ID SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Video rd
		LEFT JOIN tbl_SpeedRun_Video_Detail rd1 ON rd1.SpeedRunVideoID = rd.ID 
	    WHERE rd.SpeedRunID = rn.ID
	    AND rd.EmbeddedVideoLinkUrl IS NOT NULL
	) EmbeddedVideoLinks ON TRUE;

-- vw_SpeedRunSummaryLite
DROP VIEW IF EXISTS vw_SpeedRunSummaryLite;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunSummaryLite AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           PlayerIDs.Value AS PlayerIDs,
           rn.`Rank`,
           rn.VerifyDate,
           rn.ImportedDate
    FROM tbl_SpeedRun rn   
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE 		
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR)) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		WHERE rp.SpeedRunID = rn.ID
	) PlayerIDs ON TRUE;

-- vw_SpeedRunChart
DROP VIEW IF EXISTS vw_SpeedRunChart;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunChart AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           c.CategoryTypeID,
           rn.LevelID,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           rn.PrimaryTime,
           rn.`Rank`,
           Players.Value AS Players,
           Guests.Value AS Guests,           
           rn.DateSubmitted
    FROM tbl_SpeedRun rn
    JOIN tbl_Category c ON c.ID = rn.CategoryID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE 		
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name  , '¦', u.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(g.ID,CHAR), '¦', g.Name  , '¦', g.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Guest rg
		JOIN tbl_Guest g ON g.ID = rg.GuestID
		WHERE rg.SpeedRunID = rn.ID
	) Guests ON TRUE;

-- vw_SpeedRunChartUser
DROP VIEW IF EXISTS vw_SpeedRunChartUser;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunChartUser AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.CategoryTypeID,
           rn.LevelID,
           rn.SubCategoryVariableValueIDs,
           rn.PrimaryTime,
           rn.`Rank`,
           rn.Players,
           rn.Guests,           
           rn.DateSubmitted,
           rp.UserID
    FROM vw_SpeedRunChart rn
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID;

-- vw_SpeedRunVideo
DROP VIEW IF EXISTS vw_SpeedRunVideo;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunVideo AS

	SELECT dn.ID AS SpeedRunID, dn1.ID AS SpeedRunVideoID, dn1.VideoLinkUrl, dn1.ThumbnailLinkUrl, dn1.EmbeddedVideoLinkUrl, dn.VerifyDate, dn2.ViewCount, dn2.ChannelCode,
	CASE WHEN dn2.SpeedRunVideoID IS NOT NULL THEN 1 ELSE 0 END AS HasDetails
	FROM tbl_speedrun dn
	JOIN tbl_speedrun_video dn1 ON dn1.SpeedRunID = dn.ID
	LEFT JOIN tbl_speedrun_video_detail dn2 ON dn2.SpeedRunVideoID = dn1.ID;

-- vw_User
DROP VIEW IF EXISTS vw_User;

CREATE DEFINER=`root`@`localhost` VIEW vw_User AS

	SELECT u.ID, u.Name, u.Abbr, u.SignUpDate, COALESCE(u.IsChanged, 0) AS IsChanged, uc.Location,
	ul.SpeedRunComUrl, ul.ProfileImageUrl, ul.TwitchProfileUrl, ul.HitboxProfileUrl, ul.YoutubeProfileUrl, ul.TwitterProfileUrl, ul.SpeedRunsLiveProfileUrl,
	TotalSpeedRuns.Value AS TotalSpeedRuns,
	TotalWorldRecords.Value AS TotalWorldRecords,
	TotalPersonalBests.Value AS TotalPersonalBests
	FROM tbl_User u
	JOIN tbl_User_Link ul ON ul.UserID = u.ID
	LEFT JOIN tbl_User_Location uc ON uc.UserID = u.ID
	LEFT JOIN LATERAL (
		SELECT COUNT(*) AS Value
		FROM tbl_SpeedRun_Player sp
		WHERE sp.UserID = u.ID 
	) TotalSpeedRuns ON TRUE  	
	LEFT JOIN LATERAL (
		SELECT COUNT(*) AS Value				
		FROM tbl_SpeedRun_Player sp
		JOIN tbl_SpeedRun sr ON sr.ID=sp.SpeedRunID AND sr.`Rank`=1
		WHERE sp.UserID = u.ID
	) TotalWorldRecords ON TRUE  		
	LEFT JOIN LATERAL (
		SELECT COUNT(*) AS Value				
		FROM (
			SELECT sr.GameID, sr.CategoryID, sr.LevelID, SubCategoryVariableValueIDs.Value
			FROM tbl_SpeedRun_Player sp
			JOIN tbl_SpeedRun sr ON sr.ID=sp.SpeedRunID
		  	LEFT JOIN LATERAL (
				SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
			    FROM tbl_SpeedRun_VariableValue rv
			    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
			    WHERE rv.SpeedRunID = sr.ID
			) SubCategoryVariableValueIDs ON TRUE   
			WHERE sp.UserID = u.ID
			GROUP BY sr.GameID, sr.CategoryID, sr.LevelID, SubCategoryVariableValueIDs.Value
		) SubQuery
	) TotalPersonalBests ON TRUE;

-- vw_UserAccount
DROP VIEW IF EXISTS vw_UserAccount;

CREATE DEFINER=`root`@`localhost` VIEW vw_UserAccount AS

    SELECT ua.ID AS UserAccountID,
	ua.Username,
	ua.Email,
	ue.IsDarkTheme,
	COALESCE(SpeedRunListCategoryIDs.Value, DefaultSpeedRunListCategoryIDs.Value) AS SpeedRunListCategoryIDs
    FROM tbl_UserAccount ua
	LEFT JOIN tbl_UserAccount_Setting ue ON ue.UserAccountID = ua.ID
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(uc.SpeedRunListCategoryID,CHAR) ORDER BY uc.UserAccountID, uc.ID SEPARATOR ',') Value
	    FROM tbl_UserAccount_SpeedRunListCategory uc
	    WHERE uc.UserAccountID = ua.ID   
	) SpeedRunListCategoryIDs ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(sc.ID,CHAR) SEPARATOR ',') Value
	    FROM tbl_SpeedRunListCategory sc
	    WHERE sc.IsDefault = 1 
	) DefaultSpeedRunListCategoryIDs ON TRUE;

-- vw_UserSpeedRunCom
DROP VIEW IF EXISTS vw_UserSpeedRunCom;

CREATE DEFINER=`root`@`localhost` VIEW vw_UserSpeedRunCom AS

    SELECT u.ID,
           uc.SpeedRunComID,  
           u.Name,            
		   lc.Location,
           nt.IsGradient,
           nt.ColorLight,
           nt.ColorDark,   
           nt.ColorToLight,
           nt.ColorToDark,  		   
           ul.SpeedRunComUrl,      
           ul.ProfileImageUrl,      
           ul.TwitchProfileUrl,      
           ul.HitboxProfileUrl,      
           ul.YoutubeProfileUrl,      
           ul.TwitterProfileUrl,      
           ul.SpeedRunsLiveProfileUrl,
	       u.IsChanged           
    FROM tbl_User u
    JOIN tbl_User_SpeedRunComID uc ON uc.UserID = u.ID
    JOIN tbl_User_Link ul ON ul.UserID = u.ID
    LEFT JOIN tbl_User_Location lc ON lc.UserID = u.ID
    LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID;
  
/*********************************************/
-- create/alter procs
/*********************************************/
-- GetLatestSpeedRuns
DROP PROCEDURE IF EXISTS GetLatestSpeedRuns;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE GetLatestSpeedRuns
(
	IN SpeedRunListCategoryID INT,
	IN TopAmount INT,
	IN OrderValueOffset INT,
	IN SpeedRunListCategoryTypeID INT
)
BEGIN	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

     -- New
     IF SpeedRunListCategoryID = 0 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))          
		  AND rn.IsExcludeFromSpeedRunList = 0
          AND rn.EmbeddedVideoLinks IS NOT NULL
          ORDER BY rn.ID DESC
          LIMIT TopAmount;
	 -- Top 5%
     ELSEIF SpeedRunListCategoryID = 1 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
		  FROM vw_SpeedRunSummary rn,        
		  LATERAL (SELECT FLOOR(5 / 100 * (MAX(rn1.`Rank`) + 1)) AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.`Rank` IS NOT NULL
					HAVING MAX(rn1.`Rank`) > 1
				) AS MaxRankPercent
		  WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))  		  
		  AND rn.IsExcludeFromSpeedRunList = 0  
		  AND rn.EmbeddedVideoLinks IS NOT NULL
		  AND rn.`Rank` IS NOT NULL	  
		  AND rn.`Rank` <= CASE WHEN MaxRankPercent.Value < 1 THEN 1 ELSE MaxRankPercent.Value END
		  ORDER BY rn.ID DESC
          LIMIT TopAmount;                    
	 -- World Records
     ELSEIF SpeedRunListCategoryID = 2 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,              
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn,
		  LATERAL (SELECT MAX(rn1.`Rank`) AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.`Rank` IS NOT NULL
				) AS MaxRank          
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0             
          AND rn.EmbeddedVideoLinks IS NOT NULL
		  AND rn.`Rank` = 1
		  AND MaxRank.Value > 1
          ORDER BY rn.ID DESC
          LIMIT TopAmount;         
	 -- Top 3
     ELSEIF SpeedRunListCategoryID = 3 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,            
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn,
		  LATERAL (SELECT MAX(rn1.`Rank`) AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.`Rank` IS NOT NULL
				) AS MaxRank             
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0             
          AND rn.EmbeddedVideoLinks IS NOT NULL
		  AND rn.`Rank` <= 3
		  AND MaxRank.Value > 3
          ORDER BY rn.ID DESC
          LIMIT TopAmount;            
	 -- Person Bests
     ELSEIF SpeedRunListCategoryID = 4 THEN
		  SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,         
		  rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
		  rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
		  FROM vw_SpeedRunSummary rn
		  LEFT JOIN LATERAL (
				SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR)) SEPARATOR '^^') Value
			    FROM tbl_SpeedRun_Player rp  
				JOIN tbl_User u ON u.ID = rp.UserID
				WHERE rp.SpeedRunID = rn.ID
		  ) PlayerIDs ON TRUE		  
		  LEFT JOIN LATERAL (SELECT rn1.ID AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.PlayerIDs = PlayerIDs.Value
					AND rn1.ID <> rn.ID
					LIMIT 1
			) AS OtherRun ON TRUE		  
		  WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))  		  
		  AND rn.IsExcludeFromSpeedRunList = 0    		  
		  AND rn.EmbeddedVideoLinks IS NOT NULL
		  AND rn.`Rank` IS NOT NULL
		  AND OtherRun.Value IS NOT NULL
		  ORDER BY rn.ID DESC
		  LIMIT TopAmount;        
	 -- Hot
     ELSEIF SpeedRunListCategoryID = 5 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,             
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn,
		  LATERAL (SELECT MAX(rn1.ViewCount) AS Value, COUNT(rn1.SpeedRunVideoID) AS VideoCount
					FROM tbl_SpeedRun_Video_Detail rn1
					WHERE rn1.SpeedRunID = rn.ID
			    ) AS MaxViewCount          
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0           
          AND rn.EmbeddedVideoLinks IS NOT NULL         
          AND MaxViewCount.Value >= 100
          AND MaxViewCount.VideoCount = 1
          ORDER BY rn.ID DESC
          LIMIT TopAmount;          
	 -- Events
     ELSEIF SpeedRunListCategoryID = 7 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,          
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0             
          AND rn.EmbeddedVideoLinks IS NOT NULL
          AND EXISTS (SELECT 1 FROM tbl_SpeedRun_Video_Detail rn1 JOIN tbl_Channel ca ON ca.Code = rn1.ChannelCode WHERE rn1.SpeedRunID = rn.ID)
		  ORDER BY rn.ID DESC
          LIMIT TopAmount;  
	 -- Fresh
     ELSEIF SpeedRunListCategoryID = 8 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,           
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate
          FROM vw_SpeedRunSummary rn,
		  LATERAL (SELECT MAX(rn1.`Rank`) AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.`Rank` IS NOT NULL
				) AS MaxRank          
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0              
          AND rn.EmbeddedVideoLinks IS NOT NULL
		  AND rn.`Rank` = 1
		  AND rn.`Rank` = MaxRank.Value
          ORDER BY rn.ID DESC
          LIMIT TopAmount;   
	 -- Trending
     ELSEIF SpeedRunListCategoryID = 9 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,            
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate            
          FROM vw_SpeedRunSummary rn
		  JOIN tbl_game g ON g.ID = rn.GameID,
 		  LATERAL (SELECT COUNT(rn1.ID) AS Value, MIN(rn1.`Rank`) AS MinRank
				FROM vw_SpeedRunSummaryLite rn1
				WHERE rn1.GameID = rn.GameID
				AND rn1.CategoryID = rn.CategoryID
				AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
				AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
				AND rn1.ID <> rn.ID
				AND rn1.`Rank` IS NOT NULL
				AND rn1.VerifyDate < rn.VerifyDate
				AND rn1.VerifyDate >= DATE_ADD(rn.VerifyDate, INTERVAL -5 DAY)				
			) AS RecentRuns  
		  WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0              
          AND rn.EmbeddedVideoLinks IS NOT NULL
          AND rn.`Rank` IS NOT NULL
          AND g.CreatedDate >= DATE_ADD(rn.VerifyDate, INTERVAL -30 DAY)
          AND RecentRuns.Value >= 2
          AND rn.`Rank` < RecentRuns.MinRank
          ORDER BY rn.ID DESC
          LIMIT TopAmount;   
	 -- Popular
     ELSEIF SpeedRunListCategoryID = 10 THEN
          SELECT rn.ID, rn.SpeedRunComID, rn.GameID, rn.GameName, rn.GameAbbr, rn.GameCoverImageUrl, rn.ShowMilliseconds,            
               rn.CategoryTypeID, rn.CategoryTypeName, rn.CategoryID, rn.CategoryName, rn.LevelID, rn.LevelName,
			   rn.SubCategoryVariableValues, rn.Players, rn.EmbeddedVideoLinks, rn.`Rank`, rn.PrimaryTime, rn.DateSubmitted, rn.VerifyDate, rn.ImportedDate            
          FROM vw_SpeedRunSummary rn,
 		  LATERAL (SELECT COUNT(rn1.ID) AS Value, MIN(rn1.`Rank`) AS MinRank
				FROM vw_SpeedRunSummaryLite rn1
				WHERE rn1.GameID = rn.GameID
				AND rn1.CategoryID = rn.CategoryID
				AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
				AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
				AND rn1.ID <> rn.ID
				AND rn1.`Rank` IS NOT NULL
				AND rn1.VerifyDate < rn.VerifyDate
				AND rn1.VerifyDate >= DATE_ADD(rn.VerifyDate, INTERVAL -5 DAY)				
			) AS RecentRuns             
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0              
          AND rn.EmbeddedVideoLinks IS NOT NULL
          AND rn.`Rank` IS NOT NULL          
          AND RecentRuns.Value >= 2
		  AND rn.`Rank` < RecentRuns.MinRank          
          ORDER BY rn.ID DESC
          LIMIT TopAmount;      
     END IF;
END $$
DELIMITER ;

-- GetPersonalBestsByUserID
DROP PROCEDURE IF EXISTS GetPersonalBestsByUserID;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE GetPersonalBestsByUserID(
	IN GameID INT,
	IN CategoryTypeID INT,	
	IN CategoryID INT,
	IN LevelID INT,
	IN UserID INT
)
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DROP TEMPORARY TABLE IF EXISTS ResultsRaw;
	CREATE TEMPORARY TABLE ResultsRaw 
	SELECT ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs ORDER BY rn.PrimaryTime) AS RowNum,
	rn.ID,
	rn.GameID, 
	rn.CategoryID,
	rn.CategoryName,
	rn.LevelID,
	rn.LevelName,	
	rn.PlatformID,
	rn.PlatformName,
	rn.SubCategoryVariableValueIDs,
	rn.VariableValues,
	rn.Players,
	rn.Guests, 
	rn.`Rank`,
	rn.PrimaryTime,
	rn.Comment,
	rn.DateSubmitted,
	rn.VerifyDate
	FROM vw_WorldRecordGridUser rn
	WHERE rn.GameID = GameID
    AND rn.CategoryTypeID = CategoryTypeID
	AND ((CategoryID IS NULL) OR (rn.CategoryID = CategoryID))    
	AND ((LevelID IS NULL) OR (rn.LevelID = LevelID))
    AND rn.UserID = UserID;
   
	SELECT rn.ID,
	rn.GameID,
	rn.CategoryID,
	rn.CategoryName,
	rn.LevelID,
	rn.LevelName,	
	rn.PlatformID,
	rn.PlatformName,
	rn.SubCategoryVariableValueIDs,
	rn.VariableValues,
	rn.Players,
	rn.Guests,
	rn.`Rank`,
	rn.PrimaryTime,
	rn.Comment,
	rn.DateSubmitted,
	rn.VerifyDate
	FROM ResultsRaw rn
	WHERE rn.RowNum = 1
	ORDER BY rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValueIDs;
END $$
DELIMITER ;

-- ImportCreateFullTables
DROP PROCEDURE IF EXISTS ImportCreateFullTables;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportCreateFullTables()
BEGIN
	-- tbl_Platform_Full
	DROP TABLE IF EXISTS tbl_Platform_Full;
	
	CREATE TABLE tbl_Platform_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (50) NOT NULL,
	    YearOfRelease int NULL,
	    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	    PRIMARY KEY (ID)   
	);
		
	-- tbl_Platform_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Platform_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Platform_SpeedRunComID_Full 
	(
		PlatformID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (PlatformID)       
	);

	-- tbl_Platform_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Platform_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Platform_SpeedRunComID_Full 
	(
		PlatformID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (PlatformID)       
	);

	-- tbl_User_Full
	DROP TABLE IF EXISTS tbl_User_Full;
	
	CREATE TABLE tbl_User_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (100) NOT NULL,
		UserRoleID int NOT NULL,
	    SignUpDate datetime NULL,  
	    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
		ModifiedDate datetime NULL,
		Abbr varchar (100) NULL,
		IsChanged bit NULL,		
	    PRIMARY KEY (ID)
	);
	
	-- tbl_User_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_User_SpeedRunComID_Full;
	
	CREATE TABLE tbl_User_SpeedRunComID_Full
	(
		UserID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (UserID)
	);
	
	-- tbl_User_Location_Full
	DROP TABLE IF EXISTS tbl_User_Location_Full;
	
	CREATE TABLE tbl_User_Location_Full
	( 
	    UserID int NOT NULL,
	    Location varchar (100) NULL,
	    PRIMARY KEY (UserID)
	);

	-- tbl_User_NameStyle_Full
	DROP TABLE IF EXISTS tbl_User_NameStyle_Full;
	
	CREATE TABLE tbl_User_NameStyle_Full
	( 
	    UserID int NOT NULL,
	    IsGradient bit NOT NULL,
	    ColorLight VARCHAR(10) NULL,
	    ColorDark VARCHAR(10) NULL,    
	    ColorToLight VARCHAR(10) NULL,
	    ColorToDark VARCHAR(10) NULL,    
	    PRIMARY KEY (UserID)
	);
			
	-- tbl_User_Link_Full
	DROP TABLE IF EXISTS tbl_User_Link_Full;
	
	CREATE TABLE tbl_User_Link_Full
	( 
	    UserID int NOT NULL,
		SpeedRunComUrl varchar (1000) NULL, 
	    ProfileImageUrl varchar (1000) NULL,
	    TwitchProfileUrl varchar (1000) NULL,
	    HitboxProfileUrl varchar (1000) NULL,
	    YoutubeProfileUrl varchar (1000) NULL,
	    TwitterProfileUrl varchar (1000) NULL,
	    SpeedRunsLiveProfileUrl varchar (1000) NULL,
	    PRIMARY KEY (UserID)    
	);

	-- tbl_Guest_Full
	DROP TABLE IF EXISTS tbl_Guest_Full;
	
	CREATE TABLE tbl_Guest_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name nvarchar (100) NOT NULL,
	    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
		Abbr varchar(100) NULL,
		PRIMARY KEY (ID)
	);
	
	-- tbl_Guest_Link_Full
	DROP TABLE IF EXISTS tbl_Guest_Link_Full;
	
	CREATE TABLE tbl_Guest_Link_Full
	( 
	    GuestID int NOT NULL,
		SpeedRunComUrl varchar (1000) NULL,
	    PRIMARY KEY (GuestID)    
	);

	-- tbl_Game_Full
	DROP TABLE IF EXISTS tbl_Game_Full;
	
	CREATE TABLE tbl_Game_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (100) NOT NULL,
	    IsRomHack bit NOT NULL,
	    YearOfRelease int NULL,
	    CreatedDate datetime NULL,  
	    ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
	    ModifiedDate datetime NULL,
		Abbr varchar(100) NULL,
		IsChanged bit NULL,
		PRIMARY KEY (ID)
	);

	-- tbl_Game_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Game_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Game_SpeedRunComID_Full
	(
		GameID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	   	PRIMARY KEY (GameID) 
	);

	-- tbl_Game_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Game_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Game_SpeedRunComID_Full
	(
		GameID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	   	PRIMARY KEY (GameID) 
	);
	
	-- tbl_Game_Link_Full
	DROP TABLE IF EXISTS tbl_Game_Link_Full;
	
	CREATE TABLE tbl_Game_Link_Full
	(
	    GameID int NOT NULL,
	    SpeedRunComUrl varchar (125) NOT NULL,
	    CoverImageUrl varchar (80) NULL,
	    CoverImagePath varchar (80) NULL,
	   	PRIMARY KEY (GameID)     
	);

	-- tbl_Level_Full
	DROP TABLE IF EXISTS tbl_Level_Full;
	
	CREATE TABLE tbl_Level_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (100) NOT NULL,
	    GameID int NOT NULL,
	    PRIMARY KEY (ID) 
	);

	-- tbl_Level_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Level_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Level_SpeedRunComID_Full 
	(
		LevelID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (LevelID) 
	);

	-- tbl_Level_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Level_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Level_SpeedRunComID_Full 
	(
		LevelID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (LevelID) 
	);

	-- tbl_Level_Rule_Full
	DROP TABLE IF EXISTS tbl_Level_Rule_Full;
	
	CREATE TABLE tbl_Level_Rule_Full 
	( 
	    LevelID int NOT NULL, 
	    Rules varchar (8000) NULL,
	    PRIMARY KEY (LevelID) 
	); 
	
	-- tbl_Category_Full
	DROP TABLE IF EXISTS tbl_Category_Full;
	
	CREATE TABLE tbl_Category_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (100) NOT NULL,
	    GameID int NOT NULL,
	    CategoryTypeID int NOT NULL,
	    IsMiscellaneous bit NOT NULL, 
	    IsTimerAscending bit NOT NULL,  	    
	    PRIMARY KEY (ID)     
	);

	-- tbl_Category_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Category_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Category_SpeedRunComID_Full 
	(
		CategoryID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (CategoryID)        
	);

	-- tbl_Category_Rule_Full
	DROP TABLE IF EXISTS tbl_Category_Rule_Full;
	
	CREATE TABLE tbl_Category_Rule_Full 
	( 
	    CategoryID int NOT NULL, 
	    Rules varchar (15500) NULL,
	    PRIMARY KEY (CategoryID)      
	);

	-- tbl_Variable_Full
	DROP TABLE IF EXISTS tbl_Variable_Full;
	
	CREATE TABLE tbl_Variable_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    Name varchar (100) NOT NULL,
	    GameID int NOT NULL,
	    VariableScopeTypeID int NOT NULL,
	    CategoryID int NULL,
	    LevelID int NULL,
	    IsSubCategory bit NOT NULL,
	    PRIMARY KEY (ID)        
	);

	-- tbl_Variable_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_Variable_SpeedRunComID_Full;
	
	CREATE TABLE tbl_Variable_SpeedRunComID_Full 
	(
		VariableID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (VariableID)       
	);

	-- tbl_VariableValue_Full
	DROP TABLE IF EXISTS tbl_VariableValue_Full;
	
	CREATE TABLE tbl_VariableValue_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    GameID int NOT NULL,   
	    VariableID int NOT NULL, 
	    Value varchar (100) NOT NULL, 
	    IsCustomValue bit NOT NULL,
	    PRIMARY KEY (ID)      
	);

	-- tbl_VariableValue_Full
	DROP TABLE IF EXISTS tbl_VariableValue_Full;
	
	CREATE TABLE tbl_VariableValue_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
	    GameID int NOT NULL,   
	    VariableID int NOT NULL, 
	    Value varchar (100) NOT NULL, 
	    IsCustomValue bit NOT NULL,
	    PRIMARY KEY (ID)      
	);

	-- tbl_VariableValue_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_VariableValue_SpeedRunComID_Full;
	
	CREATE TABLE tbl_VariableValue_SpeedRunComID_Full 
	(
		VariableValueID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	    PRIMARY KEY (VariableValueID)          
	);

	-- tbl_Game_Platform_Full
	DROP TABLE IF EXISTS tbl_Game_Platform_Full;
	
	CREATE TABLE tbl_Game_Platform_Full
	(     
	    ID int NOT NULL AUTO_INCREMENT, 
	    GameID int NOT NULL,
	    PlatformID int NOT NULL,
	    PRIMARY KEY (ID)     
	);
	
	-- tbl_Game_Region_Full
	DROP TABLE IF EXISTS tbl_Game_Region_Full;
	
	CREATE TABLE tbl_Game_Region_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    GameID int NOT NULL,
	    RegionID int NOT NULL,
	    PRIMARY KEY (ID)      
	);

	-- tbl_Game_Moderator_Full
	DROP TABLE IF EXISTS tbl_Game_Moderator_Full;
	
	CREATE TABLE tbl_Game_Moderator_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    GameID int NOT NULL,
	    UserID int NOT NULL,
	    PRIMARY KEY (ID)      
	);

	-- tbl_Game_TimingMethod_Full
	DROP TABLE IF EXISTS tbl_Game_TimingMethod_Full;
	
	CREATE TABLE tbl_Game_TimingMethod_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    GameID int NOT NULL,
	    TimingMethodID int NOT NULL,
	  	PRIMARY KEY (ID)  
	);

	-- tbl_Game_Ruleset_Full
	DROP TABLE IF EXISTS tbl_Game_Ruleset_Full;
	
	CREATE TABLE tbl_Game_Ruleset_Full 
	( 
	    GameID int NOT NULL,
	    ShowMilliseconds bit NOT NULL,
	    RequiresVerification bit NOT NULL,
	    RequiresVideo bit NOT NULL,
	    DefaultTimingMethodID int NOT NULL,
	    EmulatorsAllowed bit NOT NULL,
	  	PRIMARY KEY (GameID)      
	);

	-- tbl_SpeedRun_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Full;
	
	CREATE TABLE tbl_SpeedRun_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
		StatusTypeID int NOT NULL,
		GameID int NOT NULL,
		CategoryID int NOT NULL,
		LevelID int NULL,
		`Rank` int NULL,
		PrimaryTime bigint NOT NULL,
		IsExcludeFromSpeedRunList bit NOT NULL,		
		RunDate datetime NULL,
		DateSubmitted datetime NULL,
		VerifyDate datetime NULL,
		ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
		ModifiedDate datetime NULL,
		IsProcessed bit NULL,
	  	PRIMARY KEY (ID) 	
	);

	-- tbl_SpeedRun_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Full_Ordered 
	( 
	    ID int NOT NULL AUTO_INCREMENT, 
		StatusTypeID int NOT NULL,
		GameID int NOT NULL,
		CategoryID int NOT NULL,
		LevelID int NULL,
		`Rank` int NULL,
		PrimaryTime bigint NOT NULL,
		IsExcludeFromSpeedRunList bit NOT NULL,		
		RunDate datetime NULL,
		DateSubmitted datetime NULL,
		VerifyDate datetime NULL,
		ImportedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),
		ModifiedDate datetime NULL,
	  	PRIMARY KEY (ID) 	
	);

	-- tbl_SpeedRun_SpeedRunComID_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_SpeedRunComID_Full;
	
	CREATE TABLE tbl_SpeedRun_SpeedRunComID_Full 
	(
		SpeedRunID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	  	PRIMARY KEY (SpeedRunID)     
	);

	-- tbl_SpeedRun_SpeedRunComID_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_SpeedRunComID_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_SpeedRunComID_Full_Ordered
	(
		SpeedRunID int NOT NULL,
	    SpeedRunComID varchar (10) NOT NULL,
	  	PRIMARY KEY (SpeedRunID)     
	);

	-- tbl_SpeedRun_System_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_System_Full;
	
	CREATE TABLE tbl_SpeedRun_System_Full 
	( 
	    SpeedRunID int NOT NULL,
		PlatformID int NULL,
		RegionID int NULL,
	 	IsEmulated bit NOT NULL,
	 	PRIMARY KEY (SpeedRunID)   	
	);

	-- tbl_SpeedRun_System_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_System_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_System_Full_Ordered 
	( 
	    SpeedRunID int NOT NULL,
		PlatformID int NULL,
		RegionID int NULL,
	 	IsEmulated bit NOT NULL,
	 	PRIMARY KEY (SpeedRunID)   	
	);

	-- tbl_SpeedRun_Time_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Time_Full;
	
	CREATE TABLE tbl_SpeedRun_Time_Full 
	( 
	    SpeedRunID int NOT NULL,
		PrimaryTime bigint NOT NULL,
		RealTime bigint NULL,
		RealTimeWithoutLoads bigint NULL,
		GameTime bigint NULL,
	 	PRIMARY KEY (SpeedRunID)   	
	);

	-- tbl_SpeedRun_Time_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Time_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Time_Full_Ordered 
	( 
	    SpeedRunID int NOT NULL,
		PrimaryTime bigint NOT NULL,
		RealTime bigint NULL,
		RealTimeWithoutLoads bigint NULL,
		GameTime bigint NULL,
	 	PRIMARY KEY (SpeedRunID)   	
	);

	-- tbl_SpeedRun_Link_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Link_Full;
	
	CREATE TABLE tbl_SpeedRun_Link_Full 
	( 
	    SpeedRunID int NOT NULL,
		SpeedRunComUrl varchar(1000) NOT NULL,
		SplitsUrl varchar(1000) NULL,
	 	PRIMARY KEY (SpeedRunID) 	
	);

	-- tbl_SpeedRun_Link_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Link_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Link_Full_Ordered 
	( 
	    SpeedRunID int NOT NULL,
		SpeedRunComUrl varchar(1000) NOT NULL,
		SplitsUrl varchar(1000) NULL,
	 	PRIMARY KEY (SpeedRunID) 	
	);

	-- tbl_SpeedRun_Comment_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Comment_Full;
	
	CREATE TABLE tbl_SpeedRun_Comment_Full 
	( 
	    SpeedRunID int NOT NULL,
		Comment varchar(2000) NULL,
	 	PRIMARY KEY (SpeedRunID)	
	);

	-- tbl_SpeedRun_Comment_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Comment_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Comment_Full_Ordered 
	( 
	    SpeedRunID int NOT NULL,
		Comment varchar(2000) NULL,
	 	PRIMARY KEY (SpeedRunID)	
	);

	-- tbl_SpeedRun_Player_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Player_Full;
	
	CREATE TABLE tbl_SpeedRun_Player_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    UserID int NOT NULL,
		PRIMARY KEY (ID)	 
	);

	-- tbl_SpeedRun_Player_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Player_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Player_Full_Ordered 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    UserID int NOT NULL,
		PRIMARY KEY (ID)	 
	);

	-- tbl_SpeedRun_Guest_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Guest_Full;
	
	CREATE TABLE tbl_SpeedRun_Guest_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    GuestID int NOT NULL,
		PRIMARY KEY (ID)	    
	); 

	-- tbl_SpeedRun_Guest_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Guest_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Guest_Full_Ordered 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    GuestID int NOT NULL,
		PRIMARY KEY (ID)	    
	);

	-- tbl_SpeedRun_VariableValue_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_VariableValue_Full;
	
	CREATE TABLE tbl_SpeedRun_VariableValue_Full
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    VariableID int NOT NULL,
	    VariableValueID int NOT NULL,
		PRIMARY KEY (ID)    
	); 

	-- tbl_SpeedRun_VariableValue_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_VariableValue_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_VariableValue_Full_Ordered
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    VariableID int NOT NULL,
	    VariableValueID int NOT NULL,
		PRIMARY KEY (ID)    
	);

	-- tbl_SpeedRun_Video_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Video_Full;
	
	CREATE TABLE tbl_SpeedRun_Video_Full 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    VideoLinkUrl varchar (500) NOT NULL,
	    EmbeddedVideoLinkUrl varchar (250) NULL,
		ThumbnailLinkUrl varchar(250) NULL,
		PRIMARY KEY (ID) 	
	);

	-- tbl_SpeedRun_Video_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Video_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Video_Full_Ordered 
	( 
	    ID int NOT NULL AUTO_INCREMENT,
	    SpeedRunID int NOT NULL,
	    VideoLinkUrl varchar (500) NOT NULL,
	    EmbeddedVideoLinkUrl varchar (250) NULL,
		ThumbnailLinkUrl varchar(250) NULL,		
		PRIMARY KEY (ID) 	
	);

	-- tbl_SpeedRun_Video_Detail_Full
	DROP TABLE IF EXISTS tbl_SpeedRun_Video_Detail_Full;
	
	CREATE TABLE tbl_SpeedRun_Video_Detail_Full(
		SpeedRunVideoID int NOT NULL,
		SpeedRunID int NOT NULL,
		ChannelCode varchar(50) NULL,
		ViewCount int NULL,
		PRIMARY KEY (SpeedRunVideoID) 	
	);

	-- tbl_SpeedRun_Video_Detail_Full_Ordered
	DROP TABLE IF EXISTS tbl_SpeedRun_Video_Detail_Full_Ordered;
	
	CREATE TABLE tbl_SpeedRun_Video_Detail_Full_Ordered(
		SpeedRunVideoID int NOT NULL,
		SpeedRunID int NOT NULL,
		ChannelCode varchar(50) NULL,
		ViewCount int NULL,
		PRIMARY KEY (SpeedRunVideoID) 	
	);

	CREATE INDEX IDX_tbl_SpeedRun_VariableValue_Full_SpeedRunID ON tbl_SpeedRun_VariableValue_Full (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Player_Full_SpeedRunID ON tbl_SpeedRun_Player_Full (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Guest_Full_SpeedRunID ON tbl_SpeedRun_Guest_Full (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Video_Full_SpeedRunID ON tbl_SpeedRun_Video_Full (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_Full_SpeedRunID ON tbl_SpeedRun_Video_Detail_Full (SpeedRunID);
END $$
DELIMITER ;

-- ImportGetGamesForSitemap
DROP PROCEDURE IF EXISTS ImportGetGamesForSitemap;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportGetGamesForSitemap()
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    SELECT ID, Abbr, COALESCE(ModifiedDate, ImportedDate) AS LastModifiedDate 
    FROM tbl_Game
    ORDER BY COALESCE(ModifiedDate, ImportedDate) DESC;	
END $$
DELIMITER ;

-- ImportReorderSpeedRuns
DROP PROCEDURE IF EXISTS ImportReorderSpeedRuns;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportReorderSpeedRuns()
BEGIN	
    DECLARE BatchCount INT DEFAULT 1000;
    DECLARE RowCount INT DEFAULT 0;
    DECLARE MaxRowCount INT;
    DECLARE LastInsertID INT;

    SELECT COUNT(*) INTO MaxRowCount FROM tbl_SpeedRun_Full;
   
   	DROP TEMPORARY TABLE IF EXISTS IDsToProcess;
	CREATE TEMPORARY TABLE IDsToProcess
	(
		RowNum INT AUTO_INCREMENT,
		ID INT,
		PRIMARY KEY (RowNum)	
	); 

   	DROP TEMPORARY TABLE IF EXISTS InsertedIDs;
	CREATE TEMPORARY TABLE InsertedIDs
	(
		RowNum INT AUTO_INCREMENT,
		NewID INT,
		OldID INT,
		PRIMARY KEY (RowNum)
	);

   	DROP TEMPORARY TABLE IF EXISTS InsertedVideoIDs;
	CREATE TEMPORARY TABLE InsertedVideoIDs
	(
		RowNum INT AUTO_INCREMENT,	
		NewVideoID INT,
		NewID INT,
		OldVideoID INT,
		PRIMARY KEY (RowNum)		
	);

   	DROP TEMPORARY TABLE IF EXISTS OldVideoIDs;
	CREATE TEMPORARY TABLE OldVideoIDs
	(
		RowNum INT AUTO_INCREMENT,	
		OldVideoID INT,
		PRIMARY KEY (RowNum)		
	);

	WHILE RowCount < MaxRowCount DO
        INSERT INTO IDsToProcess (ID)
	    SELECT ID
	    FROM tbl_SpeedRun_Full
	    WHERE COALESCE(IsProcessed, 0) = 0
	    ORDER BY COALESCE(VerifyDate, DateSubmitted)
	    LIMIT BatchCount;  
    
        INSERT INTO tbl_SpeedRun_Full_Ordered (StatusTypeID, GameID, CategoryID, LevelID, `Rank`, PrimaryTime, IsExcludeFromSpeedRunList, RunDate, DateSubmitted, VerifyDate)
        SELECT StatusTypeID, GameID, CategoryID, LevelID, `Rank`, PrimaryTime, IsExcludeFromSpeedRunList, RunDate, DateSubmitted, VerifyDate
        FROM tbl_SpeedRun_Full rn
        JOIN IDsToProcess rn1 ON rn1.ID = rn.ID;
              
        SELECT LAST_INSERT_ID() INTO LastInsertID;
       
       	INSERT INTO InsertedIDs (NewID)
       	SELECT rn.ID
       	FROM tbl_SpeedRun_Full_Ordered rn
       	WHERE rn.ID >= LastInsertID
        ORDER BY rn.ID;
       	
		UPDATE InsertedIDs rn
	  	JOIN IDsToProcess rn1 ON rn1.RowNum = rn.RowNum
	  	SET rn.OldID = rn1.ID;
	  
        INSERT INTO tbl_SpeedRun_SpeedRunComID_Full_Ordered (SpeedRunID, SpeedRunComID)
        SELECT dn.NewID, rn1.SpeedRunComID
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_SpeedRunComID_Full rn1 ON rn1.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_System_Full_Ordered (SpeedRunID, PlatformID, RegionID, IsEmulated)
        SELECT dn.NewID, rs.PlatformID, rs.RegionID, rs.IsEmulated
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_System_Full rs ON rs.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_Time_Full_Ordered (SpeedRunID, PrimaryTime, RealTime, RealTimeWithoutLoads, GameTime)
        SELECT dn.NewID, rt.PrimaryTime, rt.RealTime, rt.RealTimeWithoutLoads, rt.GameTime
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_Time_Full rt ON rt.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_Link_Full_Ordered (SpeedRunID, SpeedRunComUrl, SplitsUrl)
        SELECT dn.NewID, rl.SpeedRunComUrl, rl.SplitsUrl
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_Link_Full rl ON rl.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_Comment_Full_Ordered (SpeedRunID, Comment)
        SELECT dn.NewID, rc.Comment
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_Comment_Full rc ON rc.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_Player_Full_Ordered (SpeedRunID, UserID)
        SELECT dn.NewID, rd.UserID
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_Player_Full rd ON rd.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_Guest_Full_Ordered (SpeedRunID, GuestID)
        SELECT dn.NewID, rg.GuestID
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_Guest_Full rg ON rg.SpeedRunID = dn.OldID;

        INSERT INTO tbl_SpeedRun_VariableValue_Full_Ordered (SpeedRunID, VariableID, VariableValueID)
        SELECT dn.NewID, rv.VariableID, rv.VariableValueID
        FROM InsertedIDs dn
        JOIN tbl_SpeedRun_VariableValue_Full rv ON rv.SpeedRunID = dn.OldID;  
        
        INSERT INTO tbl_SpeedRun_Video_Full_Ordered (SpeedRunID, VideoLinkUrl, EmbeddedVideoLinkUrl, ThumbnailLinkUrl)
		SELECT dn.NewID, rv.VideoLinkUrl, rv.EmbeddedVideoLinkUrl, rv.ThumbnailLinkUrl
		FROM InsertedIDs dn
		JOIN tbl_SpeedRun_Video_Full rv ON rv.SpeedRunID = dn.OldID      
		ORDER BY dn.NewID;	
	
		SELECT LAST_INSERT_ID() INTO LastInsertID;	
	
       	INSERT INTO InsertedVideoIDs (NewVideoID, NewID)
        SELECT rv.ID, rv.SpeedRunID
		FROM tbl_SpeedRun_Video_Full_Ordered rv
		WHERE rv.ID >= LastInsertID
		ORDER BY rv.ID;
	
       	INSERT INTO OldVideoIDs (OldVideoID)
        SELECT rv.ID
		FROM InsertedIDs dn
		JOIN tbl_SpeedRun_Video_Full rv ON rv.SpeedRunID = dn.OldID
		ORDER BY dn.NewID;	
	
		UPDATE InsertedVideoIDs rn
	  	JOIN OldVideoIDs rn1 ON rn1.RowNum = rn.RowNum
	  	SET rn.OldVideoID = rn1.OldVideoID;	
	
        INSERT INTO tbl_SpeedRun_Video_Detail_Full_Ordered (SpeedRunVideoID, SpeedRunID, ChannelCode, ViewCount)
		SELECT dn.NewVideoID, dn.NewID, rv.ChannelCode, rv.ViewCount
		FROM InsertedVideoIDs dn
		JOIN tbl_SpeedRun_Video_Detail_Full rv ON rv.SpeedRunVideoID = dn.OldVideoID;

		UPDATE tbl_SpeedRun_Full rn
	  	JOIN IDsToProcess rn1 ON rn1.ID = rn.ID
	  	SET rn.IsProcessed = 1;
	  
	  	SELECT COUNT(*) INTO RowCount FROM tbl_SpeedRun_Full WHERE COALESCE(IsProcessed, 0) = 1;
	  
        TRUNCATE TABLE IDsToProcess;
        TRUNCATE TABLE InsertedIDs;
        TRUNCATE TABLE InsertedVideoIDs;  
        TRUNCATE TABLE OldVideoIDs;         
   	END WHILE;
   
	DROP TABLE tbl_SpeedRun_Full;
	DROP TABLE tbl_SpeedRun_SpeedRunComID_Full;
	DROP TABLE tbl_SpeedRun_System_Full;
	DROP TABLE tbl_SpeedRun_Time_Full;
	DROP TABLE tbl_SpeedRun_Link_Full;
	DROP TABLE tbl_SpeedRun_Comment_Full;
	DROP TABLE tbl_SpeedRun_Player_Full;
   	DROP TABLE tbl_SpeedRun_Guest_Full;
	DROP TABLE tbl_SpeedRun_VariableValue_Full;
	DROP TABLE tbl_SpeedRun_Video_Full;
	DROP TABLE tbl_SpeedRun_Video_Detail_Full;

	ALTER TABLE tbl_SpeedRun_Full_Ordered RENAME tbl_SpeedRun_Full;
	ALTER TABLE tbl_SpeedRun_SpeedRunComID_Full_Ordered RENAME tbl_SpeedRun_SpeedRunComID_Full;
	ALTER TABLE tbl_SpeedRun_System_Full_Ordered RENAME tbl_SpeedRun_System_Full;	
	ALTER TABLE tbl_SpeedRun_Time_Full_Ordered RENAME tbl_SpeedRun_Time_Full;	
	ALTER TABLE tbl_SpeedRun_Link_Full_Ordered RENAME tbl_SpeedRun_Link_Full;
	ALTER TABLE tbl_SpeedRun_Comment_Full_Ordered RENAME tbl_SpeedRun_Comment_Full;
	ALTER TABLE tbl_SpeedRun_Player_Full_Ordered RENAME tbl_SpeedRun_Player_Full;
	ALTER TABLE tbl_SpeedRun_Guest_Full_Ordered RENAME tbl_SpeedRun_Guest_Full;
	ALTER TABLE tbl_SpeedRun_VariableValue_Full_Ordered RENAME tbl_SpeedRun_VariableValue_Full;
	ALTER TABLE tbl_SpeedRun_Video_Full_Ordered RENAME tbl_SpeedRun_Video_Full;
	ALTER TABLE tbl_SpeedRun_Video_Detail_Full_Ordered RENAME tbl_SpeedRun_Video_Detail_Full;
END $$
DELIMITER ;

-- ImportRenameFullTables
DROP PROCEDURE IF EXISTS ImportRenameFullTables;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportRenameFullTables()
BEGIN	
	-- Drop Tables
	DROP TABLE tbl_Platform;
	DROP TABLE tbl_Platform_SpeedRunComID;
	DROP TABLE tbl_User;
	DROP TABLE tbl_User_SpeedRunComID;
	DROP TABLE tbl_User_Location;
	DROP TABLE tbl_User_NameStyle;
	DROP TABLE tbl_User_Link;
    DROP TABLE tbl_Guest;
	DROP TABLE tbl_Game;
	DROP TABLE tbl_Game_SpeedRunComID;
	DROP TABLE tbl_Game_Link;
	DROP TABLE tbl_Level;
	DROP TABLE tbl_Level_SpeedRunComID;
	DROP TABLE tbl_Level_Rule;
	DROP TABLE tbl_Category;
	DROP TABLE tbl_Category_SpeedRunComID;
	DROP TABLE tbl_Category_Rule;
	DROP TABLE tbl_Variable;
	DROP TABLE tbl_Variable_SpeedRunComID;
	DROP TABLE tbl_VariableValue;
	DROP TABLE tbl_VariableValue_SpeedRunComID;
	DROP TABLE tbl_Game_Platform;
	DROP TABLE tbl_Game_Region;
	DROP TABLE tbl_Game_Moderator;
	DROP TABLE tbl_Game_TimingMethod;
	DROP TABLE tbl_Game_Ruleset;
	DROP TABLE tbl_SpeedRun;
	DROP TABLE tbl_SpeedRun_SpeedRunComID;
	DROP TABLE tbl_SpeedRun_System;
	DROP TABLE tbl_SpeedRun_Time;
	DROP TABLE tbl_SpeedRun_Link;
	DROP TABLE tbl_SpeedRun_Comment;
	DROP TABLE tbl_SpeedRun_Player;
   	DROP TABLE tbl_SpeedRun_Guest;
	DROP TABLE tbl_SpeedRun_VariableValue;
	DROP TABLE tbl_SpeedRun_Video;
	DROP TABLE tbl_SpeedRun_Video_Detail;
	
    -- Rename tables
	ALTER TABLE tbl_Platform_Full RENAME tbl_Platform;
	ALTER TABLE tbl_Platform_SpeedRunComID_Full RENAME tbl_Platform_SpeedRunComID;
	ALTER TABLE tbl_User_Full RENAME tbl_User;
	ALTER TABLE tbl_User_SpeedRunComID_Full RENAME tbl_User_SpeedRunComID;
	ALTER TABLE tbl_User_Location_Full RENAME tbl_User_Location;
	ALTER TABLE tbl_User_NameStyle_Full RENAME tbl_User_NameStyle;
	ALTER TABLE tbl_User_Link_Full RENAME tbl_User_Link;
	ALTER TABLE tbl_Guest_Full RENAME tbl_Guest;
	ALTER TABLE tbl_Game_Full RENAME tbl_Game;
	ALTER TABLE tbl_Game_SpeedRunComID_Full RENAME tbl_Game_SpeedRunComID;
	ALTER TABLE tbl_Game_Link_Full RENAME tbl_Game_Link;
	ALTER TABLE tbl_Level_Full RENAME tbl_Level;
 	ALTER TABLE tbl_Level_SpeedRunComID_Full RENAME tbl_Level_SpeedRunComID;
	ALTER TABLE tbl_Level_Rule_Full RENAME tbl_Level_Rule;
	ALTER TABLE tbl_Category_Full RENAME tbl_Category;
	ALTER TABLE tbl_Category_SpeedRunComID_Full RENAME tbl_Category_SpeedRunComID;
	ALTER TABLE tbl_Category_Rule_Full RENAME tbl_Category_Rule;
	ALTER TABLE tbl_Variable_Full RENAME tbl_Variable;
	ALTER TABLE tbl_Variable_SpeedRunComID_Full RENAME tbl_Variable_SpeedRunComID;
	ALTER TABLE tbl_VariableValue_Full RENAME tbl_VariableValue;
	ALTER TABLE tbl_VariableValue_SpeedRunComID_Full RENAME tbl_VariableValue_SpeedRunComID;
	ALTER TABLE tbl_Game_Platform_Full RENAME tbl_Game_Platform;
	ALTER TABLE tbl_Game_Region_Full RENAME tbl_Game_Region;
	ALTER TABLE tbl_Game_Moderator_Full RENAME tbl_Game_Moderator;
	ALTER TABLE tbl_Game_TimingMethod_Full RENAME tbl_Game_TimingMethod;
	ALTER TABLE tbl_Game_Ruleset_Full RENAME tbl_Game_Ruleset;
	ALTER TABLE tbl_SpeedRun_Full RENAME tbl_SpeedRun;
	ALTER TABLE tbl_SpeedRun_SpeedRunComID_Full RENAME tbl_SpeedRun_SpeedRunComID;
	ALTER TABLE tbl_SpeedRun_System_Full RENAME tbl_SpeedRun_System;
	ALTER TABLE tbl_SpeedRun_Time_Full RENAME tbl_SpeedRun_Time;
	ALTER TABLE tbl_SpeedRun_Link_Full RENAME tbl_SpeedRun_Link;
	ALTER TABLE tbl_SpeedRun_Comment_Full RENAME tbl_SpeedRun_Comment;
	ALTER TABLE tbl_SpeedRun_Player_Full RENAME tbl_SpeedRun_Player;
	ALTER TABLE tbl_SpeedRun_Guest_Full RENAME tbl_SpeedRun_Guest;
	ALTER TABLE tbl_SpeedRun_VariableValue_Full RENAME tbl_SpeedRun_VariableValue;
	ALTER TABLE tbl_SpeedRun_Video_Full RENAME tbl_SpeedRun_Video;
	ALTER TABLE tbl_SpeedRun_Video_Detail_Full RENAME tbl_SpeedRun_Video_Detail;

	-- SearchUsers
	CREATE INDEX IDX_tbl_User_Name_PlusInclude ON tbl_User (Name, Abbr);
	CREATE INDEX IDX_tbl_Guest_Name_PlusInclude ON tbl_Guest (Name, Abbr);
	-- SearchUsers
	CREATE INDEX IDX_tbl_Game_Name_PlusInclude ON tbl_Game (Name, Abbr);
	-- vw_Game
	CREATE INDEX IDX_tbl_Level_GameID_PlusInclude ON tbl_Level (GameID, Name);
	CREATE INDEX IDX_tbl_Category_GameID_CategoryTypeID_PlusInclude ON tbl_Category (GameID, CategoryTypeID, Name);
	CREATE INDEX IDX_tbl_Category_CategoryTypeID_PlusInclude ON tbl_Category (CategoryTypeID, Name);
	CREATE INDEX IDX_tbl_Variable_GameID ON tbl_Variable (GameID, Name);
	CREATE INDEX IDX_tbl_VariableValue_GameID_PlusInclude ON tbl_VariableValue (GameID, VariableID, Value);
	CREATE INDEX IDX_tbl_Game_Platform_GameID_PlatformID ON tbl_Game_Platform (GameID, PlatformID);
	CREATE INDEX IDX_tbl_Game_Moderator_GameID_UserID ON tbl_Game_Moderator (GameID, UserID);
	-- vw_SpeedRunGrid
	CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate ON tbl_SpeedRun (GameID, CategoryID, LevelID, `Rank`, VerifyDate);
	CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableValueID ON tbl_SpeedRun_VariableValue (SpeedRunID, VariableValueID, VariableID);
	CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID ON tbl_SpeedRun_VariableValue (SpeedRunID, VariableID, VariableValueID);
	CREATE INDEX IDX_tbl_Variable_IsSubCategory ON tbl_Variable (IsSubCategory);
	CREATE INDEX IDX_tbl_SpeedRun_Player_SpeedRunID_UserID ON tbl_SpeedRun_Player (SpeedRunID, UserID);
	CREATE INDEX IDX_tbl_SpeedRun_Guest_SpeedRunID_GuestID ON tbl_SpeedRun_Guest (SpeedRunID, GuestID);
	-- vw_SpeedRunSummary
	CREATE INDEX IDX_tbl_SpeedRun_Video_SpeedRunID_PlusInclude ON tbl_SpeedRun_Video (SpeedRunID, EmbeddedVideoLinkUrl, ThumbnailLinkUrl);
	CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_SpeedRunID ON tbl_SpeedRun_Video_Detail (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_ChannelCode_SpeedRunID ON tbl_SpeedRun_Video_Detail (ChannelCode, SpeedRunID);
	CREATE INDEX IDX_tbl_Category_CategoryTypeID ON tbl_Category (CategoryTypeID);
	CREATE INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank ON tbl_SpeedRun (IsExcludeFromSpeedRunList, `Rank`);
	CREATE INDEX IDX_tbl_Game_Link_CoverImagePath ON tbl_Game_Link (CoverImagePath);
	-- vw_SpeedRunVideo
	CREATE INDEX IDX_tbl_SpeedRun_VerifyDate ON tbl_SpeedRun (VerifyDate);
	-- vw_User
	CREATE INDEX IDX_tbl_SpeedRun_Player_UserID ON tbl_SpeedRun_Player (UserID);
	-- tbl_speedrun_speedruncomid
	CREATE INDEX IDX_tbl_SpeedRun_SpeedRunComID_SpeedRunComID ON tbl_SpeedRun_SpeedRunComID (SpeedRunComID);
END $$
DELIMITER ;

-- RecreateSpeedRunIndexes
DROP PROCEDURE IF EXISTS RecreateSpeedRunIndexes;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE RecreateSpeedRunIndexes()
BEGIN
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_VerifyDate;

	CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate ON tbl_SpeedRun (GameID, CategoryID, LevelID, `Rank`, VerifyDate);
	CREATE INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank ON tbl_SpeedRun (IsExcludeFromSpeedRunList, `Rank`);	
	CREATE INDEX IDX_tbl_SpeedRun_VerifyDate ON tbl_SpeedRun (VerifyDate);
END

-- ImportUpdateSpeedRunRanksFull
DROP PROCEDURE IF EXISTS ImportUpdateSpeedRunRanksFull;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportUpdateSpeedRunRanksFull()
BEGIN	
    DECLARE CurrDate DATETIME DEFAULT UTC_TIMESTAMP;
    DECLARE BatchCount INT DEFAULT 200;
	DECLARE RowCount INT DEFAULT 0;
	DECLARE MaxRowCount INT;     
    DECLARE Debug BIT DEFAULT 0;

   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeys;
	CREATE TEMPORARY TABLE LeaderboardKeys
	(
		GameID INT,
		CategoryID INT,
		IsTimerAscending BIT
	);
	CREATE INDEX IDX_LeaderboardKeys_GameID_CategoryID ON LeaderboardKeys (GameID, CategoryID);

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
          GuestIDs VARCHAR(150),
          PrimaryTime BIGINT,
          IsTimerAscending BIT,
          RankPriority INT,
		  PRIMARY KEY (RowNum)          
	);
	CREATE INDEX IDX_SpeedRunsToUpdate_GameID_CategoryID_LevelID_PlusInclude ON SpeedRunsToUpdate (GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, GuestIDs, PrimaryTime);
	CREATE INDEX IDX_SpeedRunsToUpdate_RankPriority_PlayerIDs_GuestIDs ON SpeedRunsToUpdate (RankPriority, PlayerIDs, GuestIDs);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRanked;
	CREATE TEMPORARY TABLE SpeedRunsRanked
	(
		RowNum INT AUTO_INCREMENT,
		ID INT,
		`Rank` INT,
		PRIMARY KEY (RowNum)		
	);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRankedBatch;
	CREATE TEMPORARY TABLE SpeedRunsRankedBatch
	(
		ID INT,
		`Rank` INT,
		PRIMARY KEY (ID)		
	);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdateRankPriority;
	CREATE TEMPORARY TABLE SpeedRunsToUpdateRankPriority
	(
		RowNum INT,
		RankPriority INT,
		PRIMARY KEY (RowNum)		
	);

    CREATE INDEX IDX_tbl_SpeedRun_Full_GameID_CategoryID_LevelID_PrimaryTime ON tbl_SpeedRun_Full (GameID, CategoryID, LevelID, PrimaryTime);
    CREATE INDEX IDX_tbl_SpeedRun_VariableValue_Full_SpeedRunID_VariableID ON tbl_SpeedRun_VariableValue_Full (SpeedRunID, VariableID, VariableValueID);
    CREATE INDEX IDX_tbl_Variable_Full_IsSubCategory ON tbl_Variable_Full (IsSubCategory);   
    CREATE INDEX IDX_tbl_SpeedRun_Player_Full_SpeedRunID_VariableID ON tbl_SpeedRun_Player_Full (SpeedRunID, UserID);
    CREATE INDEX IDX_tbl_SpeedRun_Guest_Full_SpeedRunID ON tbl_SpeedRun_Guest_Full (SpeedRunID, GuestID);
       
	INSERT INTO LeaderboardKeys (GameID, CategoryID, IsTimerAscending)
	SELECT g.ID, c.ID, COALESCE(c.IsTimerAscending, 0)
	FROM tbl_Game_Full g
	JOIN tbl_Category_Full c ON c.GameID = g.ID
	GROUP BY g.ID, c.ID;

	INSERT INTO SpeedRunsToUpdate(ID, GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, GuestIDs, PrimaryTime, IsTimerAscending)
    SELECT rn.ID, rn.GameID, rn.CategoryID, rn.LevelID, SubCategoryVariableValues.Value, PlayerIDs.Value, GuestIDs.Value, rn.PrimaryTime, lb.IsTimerAscending
    FROM tbl_SpeedRun_Full rn
    JOIN LeaderboardKeys lb ON lb.GameID = rn.GameID AND lb.CategoryID = rn.CategoryID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue_Full rv
	    JOIN tbl_Variable_Full v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rp.UserID,CHAR) ORDER BY rp.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Player_Full rp
		WHERE rp.SpeedRunID = rn.ID
	) PlayerIDs ON TRUE      
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rg.GuestID,CHAR) ORDER BY rg.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Guest_Full rg
		WHERE rg.SpeedRunID = rn.ID
	) GuestIDs ON TRUE;

	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum,		
		   CASE rn.IsTimerAscending
				WHEN 1 THEN
				ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs ORDER BY rn.PrimaryTime DESC)
				ELSE
				ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs ORDER BY rn.PrimaryTime)
		   END
	FROM SpeedRunsToUpdate rn;
		
	UPDATE SpeedRunsToUpdate rn
	JOIN SpeedRunsToUpdateRankPriority rn1 ON rn1.RowNum = rn.RowNum
	SET rn.RankPriority = rn1.RankPriority;
	   
	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID,
	CASE rn.IsTimerAscending
		WHEN 1 THEN
		RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime DESC)
		ELSE
		RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime)
	END    
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1;

    IF Debug = 0 THEN        
	   	SET RowCount = 0;
    	SELECT COUNT(*) INTO MaxRowCount FROM SpeedRunsRanked;  	   
        WHILE RowCount < MaxRowCount DO	   
            INSERT INTO SpeedRunsRankedBatch (ID, `Rank`)
		    SELECT ID, `Rank`
		    FROM SpeedRunsRanked
		    WHERE RowNum > RowCount
		    ORDER BY RowNum
		    LIMIT BatchCount;         
        
			UPDATE tbl_SpeedRun_Full rn
		  	JOIN SpeedRunsRankedBatch rn1 ON rn1.ID = rn.ID
		  	SET rn.`Rank` = rn1.`Rank`;
		  
  			SET RowCount = RowCount + BatchCount;
	        TRUNCATE TABLE SpeedRunsRankedBatch;  		
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
   
	DROP INDEX IDX_tbl_SpeedRun_Full_GameID_CategoryID_LevelID_PrimaryTime ON tbl_SpeedRun_Full;
	DROP INDEX IDX_tbl_SpeedRun_VariableValue_Full_SpeedRunID_VariableID ON tbl_SpeedRun_VariableValue_Full;
	DROP INDEX IDX_tbl_Variable_Full_IsSubCategory ON tbl_Variable_Full;
	DROP INDEX IDX_tbl_SpeedRun_Player_Full_SpeedRunID_VariableID ON tbl_SpeedRun_Player_Full;
	DROP INDEX IDX_tbl_SpeedRun_Guest_Full_SpeedRunID ON tbl_SpeedRun_Guest_Full;

END $$
DELIMITER ;

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
		LevelID INT
	);
	CREATE INDEX IDX_LeaderboardKeysFromRuns_GameID_CategoryID_LevelID ON LeaderboardKeysFromRuns (GameID, CategoryID, LevelID);

   	DROP TEMPORARY TABLE IF EXISTS GameIDs;
	CREATE TEMPORARY TABLE GameIDs
	(
		ID INT		
	);

   	DROP TEMPORARY TABLE IF EXISTS LeaderboardKeys;
	CREATE TEMPORARY TABLE LeaderboardKeys
	(
		GameID INT,
		CategoryID INT,
		LevelID INT,
		IsTimerAscending BIT		
	);
	CREATE INDEX IDX_LeaderboardKeys_GameID_CategoryID_LevelID ON LeaderboardKeys (GameID, CategoryID, LevelID);

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
          GuestIDs VARCHAR(150),
          PrimaryTime BIGINT,
          IsTimerAscending BIT,          
          RankPriority INT,
		  PRIMARY KEY (RowNum)          
	);
	CREATE INDEX IDX_SpeedRunsToUpdate_GameID_CategoryID_LevelID_PlusInclude ON SpeedRunsToUpdate (GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, GuestIDs, PrimaryTime);
	CREATE INDEX IDX_SpeedRunsToUpdate_RankPriority_PlayerIDs_GuestIDs ON SpeedRunsToUpdate (RankPriority, PlayerIDs, GuestIDs);

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsRanked;
	CREATE TEMPORARY TABLE SpeedRunsRanked
	(
		RowNum INT AUTO_INCREMENT,
		ID INT,
		`Rank` INT,
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

   	DROP TEMPORARY TABLE IF EXISTS SpeedRunsToUpdateRankPriority;
	CREATE TEMPORARY TABLE SpeedRunsToUpdateRankPriority
	(
		RowNum INT,
		RankPriority INT,
		PRIMARY KEY (RowNum)		
	);

	IF LastImportDate > '1753-01-01 00:00:00' THEN	
		INSERT INTO LeaderboardKeysFromRuns (GameID, CategoryID, LevelID)
		SELECT rn.GameID, rn.CategoryID, rn.LevelID
		FROM tbl_SpeedRun rn
		WHERE COALESCE(rn.ModifiedDate, rn.ImportedDate) >= LastImportDate
		GROUP BY rn.GameID, rn.CategoryID, rn.LevelID;
 	END IF;
 
 	INSERT INTO GameIDs (ID)
 	SELECT g.ID
 	FROM tbl_Game g
 	WHERE COALESCE(g.ModifiedDate, g.ImportedDate) >= LastImportDate;
 
  	INSERT INTO LeaderboardKeys (GameID, CategoryID, IsTimerAscending)
	SELECT g.ID, c.ID, COALESCE(c.IsTimerAscending, 0)
	FROM GameIDs g
	JOIN tbl_Category c ON c.GameID = g.ID AND c.CategoryTypeID = 0
	WHERE NOT EXISTS (SELECT 1 FROM LeaderboardKeysFromRuns WHERE GameID = g.ID AND CategoryID = c.ID)  
	GROUP BY g.ID, c.ID;
 
  	INSERT INTO LeaderboardKeys (GameID, CategoryID, LevelID, IsTimerAscending)
	SELECT g.ID, c.ID, l.ID, COALESCE(c.IsTimerAscending, 0)
	FROM GameIDs g
	JOIN tbl_Category c ON c.GameID = g.ID AND c.CategoryTypeID = 1
	JOIN tbl_Level l ON l.GameID = g.ID
	WHERE NOT EXISTS (SELECT 1 FROM LeaderboardKeysFromRuns WHERE GameID = g.ID AND CategoryID = c.ID AND COALESCE(LevelID,'') = COALESCE(l.ID,''))
	GROUP BY g.ID, c.ID, l.ID;

	INSERT INTO LeaderboardKeys (GameID, CategoryID, LevelID, IsTimerAscending)
	SELECT rn.GameID, rn.CategoryID, rn.LevelID, COALESCE(c.IsTimerAscending, 0)
	FROM LeaderboardKeysFromRuns rn
	JOIN tbl_Category c ON c.ID = rn.CategoryID;
	
	INSERT INTO SpeedRunsToUpdate(ID, GameID, CategoryID, LevelID, SubCategoryVariableValues, PlayerIDs, GuestIDs, PrimaryTime, IsTimerAscending)
    SELECT rn.ID, rn.GameID, rn.CategoryID, rn.LevelID, SubCategoryVariableValues.Value, PlayerIDs.Value, GuestIDs.Value, rn.PrimaryTime, lb.IsTimerAscending
    FROM tbl_SpeedRun rn
    JOIN LeaderboardKeys lb ON lb.GameID = rn.GameID AND lb.CategoryID = rn.CategoryID AND COALESCE(lb.LevelID,'') = COALESCE(rn.LevelID,'')
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rp.UserID,CHAR) ORDER BY rp.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Player rp
		WHERE rp.SpeedRunID = rn.ID
	) PlayerIDs ON TRUE      
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rg.GuestID,CHAR) ORDER BY rg.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_Guest rg
		WHERE rg.SpeedRunID = rn.ID
	) GuestIDs ON TRUE;
  
	INSERT INTO SpeedRunsToUpdateRankPriority (RowNum, RankPriority)
	SELECT rn.RowNum,		
		   CASE rn.IsTimerAscending
				WHEN 1 THEN
				ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs ORDER BY rn.PrimaryTime DESC)
				ELSE
				ROW_NUMBER() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues, rn.PlayerIDs, rn.GuestIDs ORDER BY rn.PrimaryTime)
		   END
	FROM SpeedRunsToUpdate rn;
		
	UPDATE SpeedRunsToUpdate rn
	JOIN SpeedRunsToUpdateRankPriority rn1 ON rn1.RowNum = rn.RowNum
	SET rn.RankPriority = rn1.RankPriority;

	INSERT INTO SpeedRunsRanked(ID, `Rank`)
	SELECT ID,
	CASE rn.IsTimerAscending
		WHEN 1 THEN
		RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime DESC)
		ELSE
		RANK() OVER (PARTITION BY rn.GameID, rn.CategoryID, rn.LevelID, rn.SubCategoryVariableValues ORDER BY rn.PrimaryTime)
	END    
	FROM SpeedRunsToUpdate rn
	WHERE rn.RankPriority = 1;

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

-- ImportRebuildIndexes
DROP PROCEDURE IF EXISTS ImportRebuildIndexes;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportRebuildIndexes()
BEGIN
	set @tables_like = null;
	set @optimize = null;
	set @show_tables = concat("show tables where", ifnull(concat(" `Tables_in_", database(), "` like '", @tables_like, "' and"), ''), " (@optimize:=concat_ws(',',@optimize,`Tables_in_", database() ,"`))");
	
	Prepare `bd` from @show_tables;
	EXECUTE `bd`;
	DEALLOCATE PREPARE `bd`;
	
	set @optimize := concat('ANALYZE TABLE ', @optimize);
	PREPARE `sql` FROM @optimize;
	EXECUTE `sql`;
	DEALLOCATE PREPARE `sql`;
	
	set @show_tables = null, @optimize = null, @tables_like = null;
END $$
DELIMITER ;

-- ImportKillOtherProcesses
DROP PROCEDURE IF EXISTS ImportKillOtherProcesses;

DELIMITER $$

CREATE PROCEDURE ImportKillOtherProcesses()
BEGIN
  DECLARE finished INT DEFAULT 0;
  DECLARE proc_id INT;
  DECLARE proc_id_cursor CURSOR FOR SELECT ID FROM information_schema.processlist WHERE USER = 'root' AND INFO LIKE '%FROM vw_SpeedRunSummary%';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

  OPEN proc_id_cursor;
  proc_id_cursor_loop: LOOP
    FETCH proc_id_cursor INTO proc_id;

    IF finished = 1 THEN 
      LEAVE proc_id_cursor_loop;
    END IF;

    IF proc_id <> CONNECTION_ID() THEN
      KILL proc_id;
    END IF;

  END LOOP proc_id_cursor_loop;
  CLOSE proc_id_cursor;
END$$

DELIMITER ;

/*********************************************/
-- populate tables
/*********************************************/
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

INSERT INTO tbl_Region (ID, Name, Abbreviation)
SELECT '1','BRA / PAL','BRA'
UNION ALL
SELECT '2','CHN / PAL','CHN'
UNION ALL
SELECT '3','EUR / PAL','PAL'
UNION ALL
SELECT '4','JPN / NTSC','NTSC-J'
UNION ALL
SELECT '5','KOR / NTSC','KOR'
UNION ALL
SELECT '6','USA / NTSC','NTSC-U';

INSERT INTO tbl_Region_SpeedRunComID(RegionID, SpeedRunComID)
SELECT '1', 'ypl25l47'
UNION ALL
SELECT '2', 'mol4z19n'
UNION ALL
SELECT '3', 'e6lxy1dz'
UNION ALL
SELECT '4', 'o316x197'
UNION ALL
SELECT '5', 'p2g50lnk'
UNION ALL
SELECT '6', 'pr184lqn';

INSERT INTO tbl_Setting(Name, Str, Num, Dte)
SELECT 'GameLastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'UserLastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'SpeedRunLastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'LeaderboardLastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'PlatformLastImportDate', NULL, NULL, NULL
UNION ALL
SELECT 'ImportLastRunDate', NULL, NULL, NULL
UNION ALL
SELECT 'UpdateSpeedRunsTime', '07:00', NULL, NULL
UNION ALL
SELECT 'TwitchToken', '0tu8l8tiw6pwwaa064wnuel47bn1fu', NULL, NULL
UNION ALL
SELECT 'TwitchAPIEnabled', NULL, '1', NULL
UNION ALL
SELECT 'YouTubeAPIEnabled', NULL, '1', NULL
UNION ALL
SELECT 'IsBulkReloadRunning', NULL, '0', NULL
UNION ALL
SELECT 'IsBulkReloadPostProcessRunning', NULL, '0', NULL
UNION ALL
SELECT 'IsProcessGameCoverImages', NULL, '1', NULL
UNION ALL
SELECT 'ImportLastBulkReloadDate',NULL,NULL,NULL
UNION ALL
SELECT 'ImportLastUpdateSpeedRunsDate',NULL,NULL,NULL;

INSERT INTO tbl_TimingMethod (ID, Name)
SELECT '0', 'GameTime'
UNION ALL
SELECT '1', 'RealTime'
UNION ALL
SELECT '2', 'RealTimeWithoutLoads';

INSERT INTO tbl_UserRole (ID, Name)
SELECT '0', 'Banned'
UNION ALL
SELECT '1', 'User'
UNION ALL
SELECT '2', 'Trusted'
UNION ALL
SELECT '3', 'Moderator'
UNION ALL
SELECT '4', 'Admin'
UNION ALL
SELECT '5', 'Programmer'
UNION ALL
SELECT '6', 'ContentModerator';

INSERT INTO tbl_RunStatusType (ID, Name)
SELECT '0', 'New'
UNION ALL
SELECT '1', 'Verified'
UNION ALL
SELECT '2', 'Rejected';

INSERT INTO tbl_SpeedRunListCategory(ID, Name, DisplayName, Description, IsDefault, DefaultSortOrder)
SELECT '0','New','New','Newly verified runs',1,'0'
UNION ALL
SELECT '1','Top5Perc','Top 5%','Runs in top 5% of category with pre-existing runs',1,'2'
UNION ALL
SELECT '2','WorldRecord','WRs','World Records in category with pre-existing runs',1,'3'
UNION ALL
SELECT '3','Top3','Top 3','Runs in top 3 of category with pre-existing runs',1,'4'
UNION ALL
SELECT '4','PersonalBest','PBs','Personal Bests in category where user has pre-existing runs',1,'5'
UNION ALL
SELECT '5','Hot','Hot','Most recent popular runs based on twitch/youtube view counts',1,'1'
UNION ALL
SELECT '7','GDQ','GDQ','Newly verified GDQ runs',1,'6';

INSERT INTO tbl_Channel(Code, Name)
SELECT '22510310', 'gamesdonequick'
UNION ALL
SELECT 'UCI3DTtB-a3fJPjKtQ5kYHfA', 'Games Done Quick'
UNION ALL
SELECT '54739364', 'esamarathon'
UNION ALL
SELECT 'UC3Oe-jfrIqEGygxYBYyN6jQ', 'ESA Speedrunning'
UNION ALL
SELECT '30685577', 'bsg_marathon'
UNION ALL
SELECT 'UCAz_hjVviI8yfsSCLVT9gNQ', 'Benelux Speedrunner Gathering'
UNION ALL
SELECT 'UC3amJzoWdv_cf_O1jAXilcw', 'United Kingdom Speedrunner Gathering'
UNION ALL
SELECT 'UCId5mQSBVAOrOdLdfY1J4VQ', 'SpeedDemosArchiveSDA'
UNION ALL
SELECT '54739364', 'esamarathon'
UNION ALL
SELECT 'UC3Oe-jfrIqEGygxYBYyN6jQ', 'ESA Speedrunning'
UNION ALL
SELECT '30685577', 'bsg_marathon'
UNION ALL
SELECT 'UCAz_hjVviI8yfsSCLVT9gNQ', 'Benelux Speedrunner Gathering'
UNION ALL
SELECT 'UC3amJzoWdv_cf_O1jAXilcw', 'United Kingdom Speedrunner Gathering'
UNION ALL
SELECT 'UCId5mQSBVAOrOdLdfY1J4VQ', 'SpeedDemosArchiveSDA'
UNION ALL
SELECT '104477535', 'nasamarathon'
UNION ALL
SELECT 'UCYeXD06E5nIk7BwRr5Q954w', 'NASA Marathon'
UNION ALL
SELECT '70518383', 'rpglimitbreak'
UNION ALL
SELECT 'UCJn8IWyQmWEIfpVjX7o2VnQ', 'RPG Limit Break'
UNION ALL
SELECT '60522923', 'FinnRuns ry'
UNION ALL
SELECT 'UCCRSplaoV7Cg22MSxbIbb6Q', 'FinnRuns ry'
UNION ALL
SELECT '105042012', 'Calithon'
UNION ALL
SELECT 'UCVbK6vDL35e9HKzpTZwR2SQ', 'Calithon'
UNION ALL
SELECT '92570994', 'ausspeedruns'
UNION ALL
SELECT 'UCjmGR3lE2OJxc9ocNVuUgbA', 'Australian Speedruns'
UNION ALL
SELECT '125282480', 'buckeyespeedbash'
UNION ALL
SELECT 'UC3ayhrbeYfw-YqPWk8yU5KA', 'Buckeye Speed Bash'
UNION ALL
SELECT '134850221', 'rtainjapan'
UNION ALL
SELECT 'UCV8gEA4XEycdFx-myEpokLg', 'RTA in Japan'
UNION ALL
SELECT '160145980', 'gramypomagamy'
UNION ALL
SELECT 'UCCMLGwlKcnCZE8WwidGJPzQ', 'Gramy Szybko Pomagamy Skutecznie'
UNION ALL
SELECT '77426186', 'midwestspeedfest'
UNION ALL
SELECT 'UCxZU3lVJEAW5P-PI9ozlqOg', 'Midwest Speedfest'
UNION ALL
SELECT '163454212', 'uksmlive'
UNION ALL
SELECT 'UCo04ydmakpLAbYR3wed-knA', 'UKSM'
UNION ALL
SELECT '168086830', 'nwspeedfest'
UNION ALL
SELECT 'UCxE5zKNAJg8P3UDhEP59_kw', 'NorthWest SpeedFest'
UNION ALL
SELECT '234463737', 'helveticspeedrunners'
UNION ALL
SELECT 'UCQYgMHDeiRptzNNTQVfB_EQ', 'Helvetic Speedrunners'
UNION ALL
SELECT '234463737', 'helveticspeedrunners'
UNION ALL
SELECT 'UCQYgMHDeiRptzNNTQVfB_EQ', 'Helvetic Speedrunners'
UNION ALL
SELECT '99437655', 'shotsfiredmarathon'
UNION ALL
SELECT 'UCpszWgQxBaV8Iq9W8n_evgA', 'Shots Fired Marathon'
UNION ALL
SELECT '99437655', 'shotsfiredmarathon'
UNION ALL
SELECT 'UCpszWgQxBaV8Iq9W8n_evgA', 'Shots Fired Marathon'
UNION ALL
SELECT '80145304', 'speedgaming'
UNION ALL
SELECT 'UC-lm_blkZ_ujmRSwYcJY2ow', 'SpeedGaming'
UNION ALL
SELECT '192857056', 'valuethon'
UNION ALL
SELECT 'UCZvxx12KmWhDeCHh48MEKjg', 'theboyks'
UNION ALL
SELECT '69682407', 'jrtamarathon'
UNION ALL
SELECT '87671094', 'speedstuff4charity'
UNION ALL
SELECT 'UCuQJYIuK2n_QMzzSeetrqFg', 'Speed Stuff 4 Charity'
UNION ALL
SELECT '127836772', 'powerupwithpride'
UNION ALL
SELECT 'UCetbLnxj8DW8pbU5lSrHMgw', 'Power Up With Pride'
UNION ALL
SELECT '132289787', 'theraceagainsttime'
UNION ALL
SELECT '157854348', 'bigbadgameathon'
UNION ALL
SELECT 'UC0bAmkzWnvGA2Ia514YzcSA', 'Big Bad Game-a-thon'
UNION ALL
SELECT '119481642', 'reallyreallylongathon'
UNION ALL
SELECT 'UCDfCg4AMach4zc8jzklLQog', 'reallyreally longathon'
UNION ALL
SELECT '137422507', 'lefrenchrestream'
UNION ALL
SELECT 'UC1ryU4mxIyPLc4ZwEbAHt1Q', 'Bourg La Run';


























