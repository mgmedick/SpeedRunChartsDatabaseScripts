-- vw_SpeedRunChart
DROP VIEW IF EXISTS vw_SpeedRunChart;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunChart AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           rn.PrimaryTime,
           rn.`Rank`,
           Players.Value AS Players,
           Guests.Value AS Guests,           
           rn.DateSubmitted
    FROM tbl_SpeedRun rn
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE 		
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name  , '¦', u.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(g.ID,CHAR), '¦', g.Name  , '¦', g.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Guest rg
		JOIN tbl_Guest g ON g.ID = rg.GuestID
		WHERE rg.SpeedRunID = rn.ID
	) Guests ON TRUE;
	
