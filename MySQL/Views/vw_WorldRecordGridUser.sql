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
		   rn.VideoLinks,		   
           rn.`Rank`,
           rn.PrimaryTime,
           rn.Comment,
           rn.DateSubmitted,
           rn.VerifyDate,
           rp.UserID
    FROM vw_WorldRecordGrid rn
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID;
    
   
   