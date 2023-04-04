-- RecreateSpeedRunIndexes
DROP PROCEDURE IF EXISTS RecreateSpeedRunIndexes;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE RecreateSpeedRunIndexes()
BEGIN
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_VerifyDate;

	CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate ON tbl_SpeedRun (GameID, CategoryID, LevelID, `Rank`, VerifyDate);
	CREATE INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank ON tbl_SpeedRun (IsExcludeFromSpeedRunList, `Rank`);	
	CREATE INDEX IDX_tbl_SpeedRun_VerifyDate ON tbl_SpeedRun (VerifyDate);
END
