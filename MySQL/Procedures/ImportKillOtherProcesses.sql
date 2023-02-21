-- ImportKillOtherProcesses
DROP PROCEDURE IF EXISTS ImportKillOtherProcesses;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportKillOtherProcesses()
BEGIN
	SET @currentprocessid = (SELECT connection_id());
	SET @kill_processes = (SELECT GROUP_CONCAT(stat SEPARATOR ' ') FROM (SELECT CONCAT('KILL ', ID ,';') AS stat FROM information_schema.processlist WHERE USER = 'root' AND ID <> @currentprocessid) AS stats);

	PREPARE `sql` FROM @kill_processes;
	EXECUTE `sql`;
	DEALLOCATE PREPARE `sql`;
	
	SET @optimize := concat('ANALYZE TABLE ', @optimize);
	PREPARE `sql` FROM @optimize;
	EXECUTE `sql`;
	DEALLOCATE PREPARE `sql`;
	
	SET @kill_processes = NULL;
END $$
DELIMITER ;





