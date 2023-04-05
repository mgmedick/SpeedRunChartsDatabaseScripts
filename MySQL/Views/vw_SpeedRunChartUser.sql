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
   
   
	
