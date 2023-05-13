-- ImportOptimizeTables
DROP PROCEDURE IF EXISTS ImportOptimizeTables;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportOptimizeTables()
BEGIN
	set @tables_like = null;
	set @optimize = null;
	set @show_tables = concat("show tables where", ifnull(concat(" `Tables_in_", database(), "` like '", @tables_like, "' and"), ''), " (@optimize:=concat_ws(',',@optimize,`Tables_in_", database() ,"`))");
	
	Prepare `bd` from @show_tables;
	EXECUTE `bd`;
	DEALLOCATE PREPARE `bd`;
	
	set @optimize := concat('OPTIMIZE TABLE ', @optimize);
	PREPARE `sql` FROM @optimize;
	EXECUTE `sql`;
	DEALLOCATE PREPARE `sql`;
	
	set @show_tables = null, @optimize = null, @tables_like = null;
END $$
DELIMITER ;