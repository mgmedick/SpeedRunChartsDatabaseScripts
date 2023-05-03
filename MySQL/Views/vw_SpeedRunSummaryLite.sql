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
	    FROM tbl_SpeedRun_VariableValue rv FORCE INDEX (IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID)
	    JOIN tbl_Variable v FORCE INDEX FOR JOIN (IDX_tbl_Variable_IsSubCategory) ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE 		
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR)) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp FORCE INDEX (IDX_tbl_SpeedRun_Player_SpeedRunID_UserID)
		JOIN tbl_User u ON u.ID = rp.UserID
		WHERE rp.SpeedRunID = rn.ID
	) PlayerIDs ON TRUE;