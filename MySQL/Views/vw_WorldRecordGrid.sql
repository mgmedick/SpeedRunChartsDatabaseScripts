-- vw_WorldRecordGrid
DROP VIEW IF EXISTS vw_WorldRecordGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_WorldRecordGrid AS

	SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           c.Name AS CategoryName,
           c.CategoryTypeID,       
           c.IsMiscellaneous,
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