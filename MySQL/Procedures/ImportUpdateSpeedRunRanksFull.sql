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
	WHERE rn.RankPriority = 1
	AND COALESCE(PlayerIDs, GuestIDs) IS NOT NULL;
    
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

