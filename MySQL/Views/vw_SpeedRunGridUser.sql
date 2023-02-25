-- vw_SpeedRunGridUser
DROP VIEW IF EXISTS vw_SpeedRunGridUser;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridUser AS

	SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
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
    FROM vw_SpeedRunGrid rn
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID;