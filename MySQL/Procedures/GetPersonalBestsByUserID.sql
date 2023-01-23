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
END