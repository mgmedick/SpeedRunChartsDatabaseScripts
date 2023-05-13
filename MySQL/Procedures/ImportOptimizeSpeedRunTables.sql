-- ImportOptimizeSpeedRunTables
DROP PROCEDURE IF EXISTS ImportOptimizeSpeedRunTables;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE ImportOptimizeSpeedRunTables()
BEGIN
	
	OPTIMIZE TABLE tbl_SpeedRun_Link;
	OPTIMIZE TABLE tbl_SpeedRun_System;
	OPTIMIZE TABLE tbl_SpeedRun_Time;
	OPTIMIZE TABLE tbl_SpeedRun_Comment;

	ALTER TABLE tbl_SpeedRun_VariableValue DROP INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableValueID;	
	ALTER TABLE tbl_SpeedRun_VariableValue DROP INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID;
	OPTIMIZE TABLE tbl_SpeedRun_VariableValue;
	CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableValueID ON tbl_SpeedRun_VariableValue (SpeedRunID, VariableValueID, VariableID);
	CREATE INDEX IDX_tbl_SpeedRun_VariableValue_SpeedRunID_VariableID ON tbl_SpeedRun_VariableValue (SpeedRunID, VariableID, VariableValueID);

	ALTER TABLE tbl_SpeedRun_Player DROP INDEX IDX_tbl_SpeedRun_Player_SpeedRunID_UserID;
	ALTER TABLE tbl_SpeedRun_Player DROP INDEX IDX_tbl_SpeedRun_Player_UserID;
	OPTIMIZE TABLE tbl_SpeedRun_Player;
	CREATE INDEX IDX_tbl_SpeedRun_Player_SpeedRunID_UserID ON tbl_SpeedRun_Player (SpeedRunID, UserID);
	CREATE INDEX IDX_tbl_SpeedRun_Player_UserID ON tbl_SpeedRun_Player (UserID);
	
	ALTER TABLE tbl_SpeedRun_Guest DROP INDEX IDX_tbl_SpeedRun_Guest_SpeedRunID_GuestID;
	OPTIMIZE TABLE tbl_SpeedRun_Guest;
	CREATE INDEX IDX_tbl_SpeedRun_Guest_SpeedRunID_GuestID ON tbl_SpeedRun_Guest (SpeedRunID, GuestID);

	ALTER TABLE tbl_SpeedRun_Video DROP INDEX IDX_tbl_SpeedRun_Video_SpeedRunID_PlusInclude;
	OPTIMIZE TABLE tbl_SpeedRun_Video;
	CREATE INDEX IDX_tbl_SpeedRun_Video_SpeedRunID_PlusInclude ON tbl_SpeedRun_Video (SpeedRunID, EmbeddedVideoLinkUrl, ThumbnailLinkUrl);

	ALTER TABLE tbl_SpeedRun_Video_Detail DROP INDEX IDX_tbl_SpeedRun_Video_Detail_SpeedRunID;
	ALTER TABLE tbl_SpeedRun_Video_Detail DROP INDEX IDX_tbl_SpeedRun_Video_Detail_ChannelCode_SpeedRunID;
	OPTIMIZE TABLE tbl_SpeedRun_Video_Detail;
	CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_SpeedRunID ON tbl_SpeedRun_Video_Detail (SpeedRunID);
	CREATE INDEX IDX_tbl_SpeedRun_Video_Detail_ChannelCode_SpeedRunID ON tbl_SpeedRun_Video_Detail (ChannelCode, SpeedRunID);

	ALTER TABLE tbl_SpeedRun_SpeedRunComID DROP INDEX IDX_tbl_SpeedRun_SpeedRunComID_SpeedRunComID;
	OPTIMIZE TABLE tbl_SpeedRun_SpeedRunComID;
	CREATE INDEX IDX_tbl_SpeedRun_SpeedRunComID_SpeedRunComID ON tbl_SpeedRun_SpeedRunComID (SpeedRunComID);

	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank;
	ALTER TABLE tbl_speedrun DROP INDEX IDX_tbl_SpeedRun_VerifyDate;
	OPTIMIZE TABLE tbl_SpeedRun;
	CREATE INDEX IDX_tbl_SpeedRun_GameID_CategoryID_LevelID_Rank_VerifyDate ON tbl_SpeedRun (GameID, CategoryID, LevelID, `Rank`, VerifyDate);
	CREATE INDEX IDX_tbl_SpeedRun_IsExcludeFromSpeedRunList_Rank ON tbl_SpeedRun (IsExcludeFromSpeedRunList, `Rank`);	
	CREATE INDEX IDX_tbl_SpeedRun_VerifyDate ON tbl_SpeedRun (VerifyDate);

END $$
DELIMITER ;



