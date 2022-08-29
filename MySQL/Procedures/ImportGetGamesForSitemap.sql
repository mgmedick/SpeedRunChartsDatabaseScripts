-- ImportGetGamesForSitemap
DROP PROCEDURE IF EXISTS ImportGetGamesForSitemap;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportGetGamesForSitemap()
BEGIN
	
    SELECT ID, Abbr, COALESCE(ModifiedDate, ImportedDate) AS LastModifiedDate 
    FROM tbl_Game
    ORDER BY COALESCE(ModifiedDate, ImportedDate) DESC;	
	
END $$
DELIMITER ;
