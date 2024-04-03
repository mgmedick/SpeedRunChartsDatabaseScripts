USE SpeedRunAppJRE;

-- tbl_Game
DROP TABLE IF EXISTS tbl_Game;

CREATE TABLE tbl_Game 
( 
    Id int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NULL,
	Abbr varchar(100) NULL,
    ShowMilliseconds bit NOT NULL,
    ReleaseDate datetime NULL,
    Deleted bit NOT NULL,
    ImportRefDate datetime NULL,
    CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),  
    ModifiedDate datetime NULL,
	PRIMARY KEY (Id)
);

-- tbl_Game_Link
DROP TABLE IF EXISTS tbl_Game_Link;

CREATE TABLE tbl_Game_Link 
(
    Id int NOT NULL AUTO_INCREMENT, 
    GameId int NOT NULL,
	CoverImageUrl varchar (80) NULL,
    SpeedRunComUrl varchar (125) NOT NULL,
   	PRIMARY KEY (Id)     
);

-- tbl_CategoryType
DROP TABLE IF EXISTS tbl_CategoryType;

CREATE TABLE tbl_CategoryType 
( 
    Id int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (Id) 
);

-- tbl_Game_CategoryType
DROP TABLE IF EXISTS tbl_Game_CategoryType;

CREATE TABLE tbl_Game_CategoryType 
(
    Id int NOT NULL AUTO_INCREMENT, 
    GameId int NOT NULL,
    CategoryTypeId int NOT NULL,
    Deleted bit NOT NULL,    
    PRIMARY KEY (Id) 
);

-- tbl_Category
DROP TABLE IF EXISTS tbl_Category;

CREATE TABLE tbl_Category
( 
    Id int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NULL,
    GameId int NOT NULL,
    CategoryTypeId int NOT NULL,
    IsMiscellaneous bit NOT NULL, 
    IsTimerAscending bit NOT NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (Id)     
);

-- tbl_Level
DROP TABLE IF EXISTS tbl_Level;

CREATE TABLE tbl_Level 
( 
    Id int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NULL,
	GameId int NOT NULL,
	Deleted bit NOT NULL,
	PRIMARY KEY (Id)
);

-- tbl_VariableScopeType
DROP TABLE IF EXISTS tbl_VariableScopeType;

CREATE TABLE tbl_VariableScopeType 
( 
    Id int NOT NULL,
    Name varchar (25) NOT NULL,
    PRIMARY KEY (Id)      
);

-- tbl_Variable
DROP TABLE IF EXISTS tbl_Variable;

CREATE TABLE tbl_Variable
( 
    Id int NOT NULL AUTO_INCREMENT, 
    Name varchar (250) NOT NULL,
    Code varchar(10) NULL,
    GameId int NOT NULL,
    VariableScopeTypeId int NOT NULL,
    CategoryId int NULL,
    LevelId int NULL,
    IsSubCategory bit NOT NULL,
    SortOrder int NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (Id)        
);

-- tbl_VariableValue
DROP TABLE IF EXISTS tbl_VariableValue;

CREATE TABLE tbl_VariableValue
( 
    Id int NOT NULL AUTO_INCREMENT,
    Name varchar (100) NOT NULL,
    Code varchar(10) NULL,
    GameId int NOT NULL,   
    VariableId int NOT NULL,  
    IsMiscellaneous bit NOT NULL,
    Deleted bit NOT NULL,
    PRIMARY KEY (Id)      
);

-- tbl_Platform
DROP TABLE IF EXISTS tbl_Platform;

CREATE TABLE tbl_Platform 
( 
    Id int NOT NULL AUTO_INCREMENT, 
    Name varchar (50) NOT NULL,
    Code varchar(10) NULL,    
    Deleted bit NOT NULL,
    CreatedDate datetime NOT NULL DEFAULT (UTC_TIMESTAMP),  
    ModifiedDate datetime NULL,
    PRIMARY KEY (Id)   
);

-- tbl_Game_Platform
DROP TABLE IF EXISTS tbl_Game_Platform;

CREATE TABLE tbl_Game_Platform
(     
    Id int NOT NULL AUTO_INCREMENT, 
    GameId int NOT NULL,
    PlatformId int NOT NULL,
    Deleted bit NOT NULL,    
    PRIMARY KEY (Id)     
);

-- vw_Game
DROP VIEW IF EXISTS vw_Game;

CREATE DEFINER=`root`@`localhost` VIEW vw_Game AS

    SELECT g.Id, g.Name, g.Code, g.Abbr, gl.Id AS GameLinkId, gl.CoverImageUrl, gl.SpeedRunComUrl, g.ShowMilliseconds, g.ReleaseDate,
        GameCategoryTypes.Value AS GameCategoryTypesJSON, Categories.Value AS CategoriesJSON, Levels.Value AS LevelsJSON,
        Variables.Value AS VariablesJSON, VariableValues.Value AS VariableValuesJSON, GamePlatforms.Value AS GamePlatformsJSON      
    FROM tbl_Game g
    JOIN tbl_Game_Link gl ON gl.GameId = g.Id
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', ct1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(gc.Id,CHAR), ',"CategoryTypeId":', CONVERT(ct.Id,CHAR), ',"Name":"', ct.Name), '"}' ORDER BY gc.Id SEPARATOR ',') Value
		    FROM tbl_Game_CategoryType gc
		    JOIN tbl_CategoryType ct ON ct.Id = gc.CategoryTypeId
	        WHERE gc.GameId = g.Id
	        AND gc.Deleted = 0
        ) ct1
    ) GameCategoryTypes ON TRUE
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', c1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(c.Id,CHAR), ',"Name":"', c.Name, '","Code":"', c.Code, '","CategoryTypeId":', CONVERT(c.CategoryTypeId,CHAR), ',"IsMiscellaneous":', CASE c.IsMiscellaneous WHEN 1 THEN 'true' ELSE 'false' END, ',"IsTimerAscending":', CASE c.IsTimerAscending WHEN 1 THEN 'true' ELSE 'false' END), '}' ORDER BY c.IsMiscellaneous, c.Id SEPARATOR ',') Value
	        FROM tbl_Category c
	        WHERE c.GameId = g.Id
	        AND c.Deleted = 0	        
        ) c1
    ) Categories ON TRUE    
	LEFT JOIN LATERAL (
		SELECT CONCAT('[', l1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(l.Id,CHAR), ',"Name":"', l.Name), '","Code":"', l.Code, '"}' ORDER BY l.Id SEPARATOR ',') Value
	        FROM tbl_Level l
	        WHERE l.GameId = g.Id
	        AND l.Deleted = 0
        ) l1
    ) Levels ON TRUE
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(v.Id,CHAR), ',"Name":"', v.Name, '","Code":"', v.Code, '","VariableScopeTypeId":', CONVERT(v.VariableScopeTypeId, CHAR), ',"CategoryId":', COALESCE(CONVERT(v.CategoryId, CHAR),''), ',"LevelId":', COALESCE(CONVERT(v.LevelId, CHAR),''), ',"IsSubCategory":', CASE v.IsSubCategory WHEN 1 THEN 'true' ELSE 'false' END), '}' ORDER BY v.SortOrder, v.Id SEPARATOR ',') Value
	        FROM tbl_Variable v
	        WHERE v.GameId = g.Id
	        AND v.Deleted = 0	        
        ) v1
    ) Variables ON TRUE   
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', v2.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(v.Id,CHAR), ',"Name":"', v.Name, '","Code":"', v.Code, '","VariableId":', CONVERT(v.VariableId,CHAR)), '}' ORDER BY v.Id SEPARATOR ',') Value
	        FROM tbl_VariableValue v
	        WHERE v.GameId = g.Id
	        AND v.Deleted = 0	        
        ) v2
    ) VariableValues ON TRUE 
  	LEFT JOIN LATERAL (
		SELECT CONCAT('[', p1.Value, ']') Value
		FROM (
			SELECT GROUP_CONCAT('{', CONCAT('"Id":', CONVERT(gp.Id,CHAR), ',"PlatformId":', CONVERT(p.Id,CHAR), ',"Name":"', p.Name, '","Code":"', p.Code), '"}' ORDER BY p.Id SEPARATOR ',') Value
		    FROM tbl_Game_Platform gp
		    JOIN tbl_Platform p ON p.Id = gp.PlatformId
	        WHERE gp.GameId = g.Id
	        AND gp.Deleted = 0	        
        ) p1
    ) GamePlatforms ON TRUE
   WHERE g.Deleted = 0;
  
INSERT INTO tbl_CategoryType (Id, Name)
SELECT '0', 'PerGame'
UNION ALL
SELECT '1', 'PerLevel';

INSERT INTO tbl_VariableScopeType (Id, Name)
SELECT '0', 'Global'
UNION ALL
SELECT '1', 'FullGame'
UNION ALL
SELECT '2', 'AllLevels'
UNION ALL
SELECT '3', 'SingleLevel';

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

/*
SELECT CONCAT('SELECT ''', p.Name, ''',''', dn.SpeedRunComID, ''',0 UNION ALL')
FROM speedrunapp.tbl_platform p
JOIN speedrunapp.tbl_platform_speedruncomid dn ON dn.PlatformID = p.ID
GROUP BY p.Name, dn.SpeedRunComID

INSERT INTO tbl_Game (Name, Code, Abbr, ShowMilliseconds, ReleaseDate, ImportRefDate, CreatedDate, ModifiedDate)
SELECT g.Name, gc.SpeedRunComId, g.Abbr, gr.ShowMilliseconds, MAKEDATE(g.YearOfRelease, 1), g.CreatedDate, g.ImportedDate, NULL
FROM SpeedRunApp.tbl_Game g
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = g.Id
JOIN SpeedRunApp.tbl_Game_Ruleset gr ON gr.GameId = g.Id
ORDER BY g.Id
LIMIT 100;

INSERT INTO tbl_Game_Link (GameId, CoverImageUrl, SpeedRunComUrl)
SELECT g1.Id, gl.CoverImageUrl, gl.SpeedRunComUrl
FROM SpeedRunApp.tbl_Game_Link gl
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = gl.GameId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
ORDER BY g1.Id
LIMIT 100;

INSERT INTO tbl_CategoryType (Id, Name)
SELECT ct.Id, ct.Name
FROM SpeedRunApp.tbl_CategoryType ct
GROUP BY ct.Id, ct.Name
ORDER BY ct.Id;

INSERT INTO tbl_Game_CategoryType (GameId, CategoryTypeId)
SELECT g1.Id, ct.Id
FROM SpeedRunApp.tbl_CategoryType ct
JOIN SpeedRunApp.tbl_Category c ON c.CategoryTypeId = ct.Id
JOIN SpeedRunApp.tbl_Game g ON g.Id = c.GameId
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = g.Id
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
GROUP BY g1.Id, ct.Id
ORDER BY g1.Id, ct.Id;

INSERT INTO tbl_Category (Name, Code, GameId, CategoryTypeId, IsMiscellaneous, IsTimerAscending)
SELECT c.Name, cc.SpeedRunComId, g1.Id, c.CategoryTypeId, c.IsMiscellaneous, c.IsTimerAscending
FROM SpeedRunApp.tbl_Category c
JOIN SpeedRunApp.tbl_Category_SpeedRunComId cc ON cc.CategoryId = c.Id
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = c.GameId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
GROUP BY c.Id, c.Name, cc.SpeedRunComId, g1.Id, c.CategoryTypeId, c.IsMiscellaneous, c.IsTimerAscending
ORDER BY c.Id;

INSERT INTO tbl_Level (Name, Code, GameId)
SELECT l.Name, lc.SpeedRunComId, g1.Id
FROM SpeedRunApp.tbl_Level l
JOIN SpeedRunApp.tbl_Level_SpeedRunComId lc ON lc.LevelId = l.Id
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = l.GameId
JOIN tbl_Level l1 ON l1.Code = lc.SpeedRunComId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
GROUP BY l1.Id, l.Name, lc.SpeedRunComId, g1.Id
ORDER BY l1.Id;

INSERT INTO tbl_VariableScopeType (Id, Name)
SELECT vt.Id, vt.Name
FROM SpeedRunApp.tbl_VariableScopeType vt
ORDER BY vt.Id;

INSERT INTO tbl_Variable (Name, Code, GameId, VariableScopeTypeId, CategoryId, LevelId, IsSubCategory)
SELECT v.Name, gc.SpeedRunComId, g1.Id, v.VariableScopeTypeId, c1.Id, l1.Id, v.IsSubCategory
FROM SpeedRunApp.tbl_Variable v
JOIN SpeedRunApp.tbl_Variable_SpeedRunComId vc ON vc.VariableId = v.Id
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = v.GameId
JOIN SpeedRunApp.tbl_Category_SpeedRunComId cc ON cc.CategoryId = v.CategoryId
JOIN SpeedRunApp.tbl_Level_SpeedRunComId lc ON lc.LevelId = v.LevelId
JOIN tbl_Variable v1 ON v1.Code = vc.SpeedRunComId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
JOIN tbl_Category c1 ON c1.Code = cc.SpeedRunComId
JOIN tbl_Level l1 ON l1.Code = lc.SpeedRunComId
GROUP BY v.Id, v.Name, gc.SpeedRunComId, g1.Id, v.VariableScopeTypeId, c1.Id, l1.Id, v.IsSubCategory
ORDER BY v.Id;

INSERT INTO tbl_VariableValue (Name, Code, GameId, VariableId, IsMiscellaneous)
SELECT v.Value, gc.SpeedRunComId, g1.Id, v2.Id, v.IsCustomValue
FROM SpeedRunApp.tbl_VariableValue v
JOIN SpeedRunApp.tbl_VariableValue_SpeedRunComId vc ON vc.VariableValueId = v.Id
JOIN SpeedRunApp.tbl_Variable_SpeedRunComId vc2 ON vc2.VariableId = v.VariableId
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = v.GameId
JOIN tbl_VariableValue v1 ON v1.Code = vc.SpeedRunComId
JOIN tbl_Variable v2 ON v2.Code = vc2.SpeedRunComId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId
GROUP BY v.Id, v.Value, gc.SpeedRunComId, g1.Id, v2.Id, v.IsCustomValue
ORDER BY v.Id;

INSERT INTO tbl_Platform (Name, Code, YearOfRelease, CreatedDate)
SELECT DISTINCT p.Name, pc.SpeedRunComId, p.YearOfRelease, p.ImportedDate
FROM SpeedRunApp.tbl_Platform p
JOIN SpeedRunApp.tbl_Platform_SpeedRunComId pc ON pc.PlatformId = p.Id;

INSERT INTO tbl_Game_Platform(GameId, PlatformId)
SELECT DISTINCT g1.Id, p1.Id
FROM SpeedRunApp.tbl_Game_Platform gp
JOIN SpeedRunApp.tbl_Platform_SpeedRunComId pc ON pc.PlatformId = gp.PlatformId
JOIN SpeedRunApp.tbl_Game_SpeedRunComId gc ON gc.GameId = gp.GameId
JOIN tbl_Platform p1 ON p1.Code = pc.SpeedRunComId
JOIN tbl_Game g1 ON g1.Code = gc.SpeedRunComId;
*/



















