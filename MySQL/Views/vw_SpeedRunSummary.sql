-- vw_SpeedRunSummary
DROP VIEW IF EXISTS vw_SpeedRunSummary;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunSummary AS

    SELECT rn.ID,
    	   rn1.SpeedRunComID,
           g.ID AS GameID,
           g.Name AS GameName,
		   g.Abbr AS GameAbbr, 
           gl.CoverImageUrl AS GameCoverImageUrl,
		   gr.ShowMilliseconds,           
           ct.ID AS CategoryTypeID,
           ct.Name AS CategoryTypeName,           
           c.ID AS CategoryID,
           c.Name AS CategoryName,
		   l.ID AS LevelID,
		   l.Name AS LevelName,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,		   
           SubCategoryVariableValues.Value AS SubCategoryVariableValues,           
           Players.Value AS Players,
 		   EmbeddedVideoLinks.Value AS EmbeddedVideoLinks,
           rn.`Rank`,
           rn.PrimaryTime,
           rn.DateSubmitted,
		   COALESCE(rn.VerifyDate, rn.DateSubmitted) AS VerifyDate,
           rn.ImportedDate,
           rn.IsExcludeFromSpeedRunList           
    FROM tbl_SpeedRun rn
    JOIN tbl_SpeedRun_SpeedRunComID rn1 ON rn1.SpeedRunID = rn.ID
    JOIN tbl_Game g ON g.ID = rn.GameID
	JOIN tbl_Game_Link gl ON gl.GameID = g.ID
	JOIN tbl_Game_Ruleset gr ON gr.GameID = g.ID
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    JOIN tbl_CategoryType ct ON ct.ID = c.CategoryTypeID 
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) ORDER BY rv.ID SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv FORCE INDEX (IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID)
	    JOIN tbl_Variable v FORCE INDEX FOR JOIN (IDX_tbl_Variable_IsSubCategory) ON v.ID = rv.VariableID AND v.IsSubCategory = 1
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValueIDs ON TRUE     
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(va.Value ORDER BY rv.ID SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_VariableValue rv FORCE INDEX (IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableValueID)
	    JOIN tbl_Variable v FORCE INDEX FOR JOIN (IDX_tbl_Variable_IsSubCategory) ON v.ID = rv.VariableID AND v.IsSubCategory = 1
		JOIN tbl_VariableValue va ON va.ID = rv.VariableValueID
	    WHERE rv.SpeedRunID = rn.ID
	) SubCategoryVariableValues ON TRUE    
 	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(u.ID,CHAR), '¦', u.Name, '¦', u.Abbr, '¦', COALESCE(nt.ColorLight,''), '¦', COALESCE(nt.ColorToLight,''), '¦', COALESCE(nt.ColorDark,''), '¦', COALESCE(nt.ColorToDark,'')) SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Player rp FORCE INDEX (IDX_tbl_SpeedRun_Player_SpeedRunID_UserID)
		JOIN tbl_User u ON u.ID = rp.UserID
		LEFT JOIN tbl_User_NameStyle nt ON nt.UserID = u.ID
		WHERE rp.SpeedRunID = rn.ID
	) Players ON TRUE       
  	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(rd.EmbeddedVideoLinkUrl, '|', COALESCE(rd.ThumbnailLinkUrl,''), '|', CONVERT(COALESCE(rd1.ViewCount,''),CHAR)) ORDER BY rd.ID SEPARATOR '^^') Value
	    FROM tbl_SpeedRun_Video rd FORCE INDEX (IDX_tbl_SpeedRun_Video_SpeedRunID_PlusInclude)
		LEFT JOIN tbl_SpeedRun_Video_Detail rd1 ON rd1.SpeedRunVideoID = rd.ID 
	    WHERE rd.SpeedRunID = rn.ID
	    AND rd.EmbeddedVideoLinkUrl IS NOT NULL
	) EmbeddedVideoLinks ON TRUE;