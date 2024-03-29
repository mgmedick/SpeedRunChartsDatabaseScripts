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
		  FROM vw_SpeedRunSummary rn,
		  LATERAL (
				SELECT GROUP_CONCAT(CONVERT(u.ID,CHAR) SEPARATOR '^^') Value
			    FROM tbl_SpeedRun_Player rp
				JOIN tbl_User u ON u.ID = rp.UserID
				WHERE rp.SpeedRunID = rn.ID
		  ) AS PlayerIDs,		  
		  LATERAL (SELECT rn1.ID AS Value
					FROM vw_SpeedRunSummaryLite rn1
					WHERE rn1.GameID = rn.GameID
					AND rn1.CategoryID = rn.CategoryID
					AND COALESCE(rn1.LevelID,'') = COALESCE(rn.LevelID,'')
					AND COALESCE(rn1.SubCategoryVariableValueIDs,'') = COALESCE(rn.SubCategoryVariableValueIDs,'')
					AND rn1.PlayerIDs = PlayerIDs.Value
					AND rn1.ID <> rn.ID
					LIMIT 1
			) AS OtherRun		  
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
          FROM vw_SpeedRunSummary rn,
		  LATERAL (SELECT MAX(rn1.SpeedRunVideoID) AS Value
					FROM tbl_SpeedRun_Video_Detail rn1
					JOIN tbl_Channel ca ON ca.Code = rn1.ChannelCode
					WHERE rn1.SpeedRunID = rn.ID
			    ) AS MaxSpeedRunVideoID              
          WHERE ((OrderValueOffset IS NULL) OR (rn.ID < OrderValueOffset))
		  AND ((SpeedRunListCategoryTypeID IS NULL) OR (rn.CategoryTypeID = SpeedRunListCategoryTypeID))            
		  AND rn.IsExcludeFromSpeedRunList = 0             
          AND rn.EmbeddedVideoLinks IS NOT NULL
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
