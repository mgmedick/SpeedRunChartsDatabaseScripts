-- vw_UserAccount
DROP VIEW IF EXISTS vw_UserAccount;

CREATE DEFINER=`root`@`localhost` VIEW vw_UserAccount AS

    SELECT ua.ID AS UserAccountID,
	ua.Username,
	ua.Email,
	ue.IsDarkTheme,
	COALESCE(SpeedRunListCategoryIDs.Value, DefaultSpeedRunListCategoryIDs.Value) AS SpeedRunListCategoryIDs
    FROM tbl_UserAccount ua
	LEFT JOIN tbl_UserAccount_Setting ue ON ue.UserAccountID = ua.ID
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(uc.SpeedRunListCategoryID,CHAR) ORDER BY uc.UserAccountID, uc.ID SEPARATOR ',') Value
	    FROM tbl_UserAccount_SpeedRunListCategory uc
	    WHERE uc.UserAccountID = ua.ID   
	) SpeedRunListCategoryIDs ON TRUE
	LEFT JOIN LATERAL (
		SELECT GROUP_CONCAT(CONVERT(sc.ID,CHAR) SEPARATOR ',') Value
	    FROM tbl_SpeedRunListCategory sc
	    WHERE sc.IsDefault = 1 
	) DefaultSpeedRunListCategoryIDs ON TRUE;