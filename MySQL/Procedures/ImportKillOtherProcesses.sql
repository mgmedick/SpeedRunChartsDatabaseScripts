-- ImportKillOtherProcesses
DROP PROCEDURE IF EXISTS ImportKillOtherProcesses;

DELIMITER $$

CREATE PROCEDURE ImportKillOtherProcesses
(
	IN InfoContains VARCHAR(8000)
)
BEGIN
  DECLARE finished INT DEFAULT 0;
  DECLARE proc_id INT;
  DECLARE proc_id_cursor CURSOR FOR SELECT ID FROM information_schema.processlist WHERE USER = 'root' AND (InfoContains IS NULL OR INFO LIKE CONCAT('%', InfoContains, '%'));
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

  OPEN proc_id_cursor;
  proc_id_cursor_loop: LOOP
    FETCH proc_id_cursor INTO proc_id;

    IF finished = 1 THEN 
      LEAVE proc_id_cursor_loop;
    END IF;

    IF proc_id <> CONNECTION_ID() THEN
      KILL proc_id;
    END IF;

  END LOOP proc_id_cursor_loop;
  CLOSE proc_id_cursor;
END$$

DELIMITER ;

