-- vw_SpeedRunGridTab
DROP VIEW IF EXISTS vw_SpeedRunGridTab;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGridTab AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           rn.`Rank`
    FROM tbl_SpeedRun rn
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) SEPARATOR ',') Value
        FROM tbl_SpeedRun_VariableValue rv
        JOIN tbl_Variable v ON v.ID=rv.VariableID AND v.IsSubCategory = 1
        WHERE rv.SpeedRunID = rn.ID     
	) SubCategoryVariableValueIDs ON TRUE;