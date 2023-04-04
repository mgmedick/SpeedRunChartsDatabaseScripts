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
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(va.Value ORDER BY rv.ID SEPARATOR ', ') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE;
	
