-- vw_SpeedRunGrid
DROP VIEW IF EXISTS vw_SpeedRunGrid;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunGrid AS

    SELECT rn.ID,
           rn.GameID,
           rn.CategoryID,
           rn.LevelID,
           p.ID AS PlatformID,
           p.Name AS PlatformName,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           VariableValues.Value AS VariableValues,
           Players.Value AS Players,
		   Guests.Value AS Guests,
		   VideoLinks.Value AS VideoLinks,
           rn.Rank,
           rn.PrimaryTime,
           rc.Comment,
           rn.DateSubmitted,
           rn.VerifyDate
    FROM tbl_SpeedRun rn
   	JOIN tbl_SpeedRun_System rs ON rs.SpeedRunID = rn.ID 
   	LEFT JOIN tbl_SpeedRun_Comment rc ON rc.SpeedRunID = rn.ID
   	LEFT JOIN tbl_Platform p ON p.ID = rs.PlatformID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    JOIN tbl_Variable v ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE      	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(rv.VariableID,CHAR), '|', CONVERT(rv.VariableValueID,CHAR)) SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    WHERE rv.SpeedRunID = rn.ID   
	) VariableValues ON TRUE     
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name, '¦', u.Abbr, '¦', COALESCE(nt.ColorLight,''), '¦', COALESCE(nt.ColorToLight,''), '¦', COALESCE(nt.ColorDark,''), '¦', COALESCE(nt.ColorToDark,'')) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp  
		JOIN tbl_User u ON u.ID = rp.UserID
		LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE    	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(g.ID,CHAR), '¦', g.Name, '¦', g.Abbr) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Guest rg
		JOIN tbl_Guest g ON g.ID = rg.GuestID
		WHERE rg.SpeedRunID = rn.ID
	) Guests ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(COALESCE(dn.VideoLinkUrl,'') SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Video dn
		WHERE dn.SpeedRunID = rn.ID
	) VideoLinks ON TRUE;	