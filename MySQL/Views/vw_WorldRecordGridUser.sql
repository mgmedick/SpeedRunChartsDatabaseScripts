-- vw_WorldRecordGridUser
DROP VIEW IF EXISTS vw_WorldRecordGridUser;

CREATE DEFINER=`root`@`localhost` VIEW vw_WorldRecordGridUser AS

	SELECT rn.ID,
           rn.GameID,
           c.ID AS CategoryID,
           c.Name AS CategoryName,
           l.ID AS LevelID,
           l.Name AS LevelName,           
           p.ID AS PlatformID,
           p.Name AS PlatformName,
           SubCategoryVariableValueIDs.Value AS SubCategoryVariableValueIDs,
           VariableValues.Value AS VariableValues,
           Players.Value AS Players,
		   Guests.Value AS Guests,
           rn.`Rank`,
           rn.PrimaryTime,
           rc.Comment,
           rn.DateSubmitted,
           rn.VerifyDate,
           rp.UserID
    FROM tbl_SpeedRun rn
   	JOIN tbl_SpeedRun_System rs ON rs.SpeedRunID = rn.ID
    JOIN tbl_SpeedRun_Player rp ON rp.SpeedRunID = rn.ID
    JOIN tbl_Category c ON c.ID = rn.CategoryID
    LEFT JOIN tbl_Level l ON l.ID = rn.LevelID    
   	LEFT JOIN tbl_SpeedRun_Comment rc ON rc.SpeedRunID = rn.ID
   	LEFT JOIN tbl_Platform p ON p.ID = rs.PlatformID
   	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(rv.VariableValueID,CHAR) SEPARATOR ',') Value
        FROM tbl_SpeedRun_VariableValue rv
        JOIN tbl_Variable v ON v.ID=rv.VariableID AND v.IsSubCategory = 1
        WHERE rv.SpeedRunID = rn.ID     
	) SubCategoryVariableValueIDs ON TRUE      	
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONCAT(CONVERT(rv.VariableID,CHAR), '|', CONVERT(rv.VariableValueID,CHAR)) SEPARATOR ',') Value
	    FROM tbl_SpeedRun_VariableValue rv
	    WHERE rv.SpeedRunID = rn.ID   
	) VariableValues ON TRUE     
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
	
