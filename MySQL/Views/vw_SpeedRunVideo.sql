-- vw_SpeedRunVideo
DROP VIEW IF EXISTS vw_SpeedRunVideo;

CREATE DEFINER=`root`@`localhost` VIEW vw_SpeedRunVideo AS

	SELECT dn.ID AS SpeedRunID, dn1.ID AS SpeedRunVideoID, dn1.VideoLinkUrl, dn1.ThumbnailLinkUrl, dn1.EmbeddedVideoLinkUrl, dn.VerifyDate, dn2.ViewCount, dn2.ChannelCode,
	CASE WHEN dn2.SpeedRunVideoID IS NOT NULL THEN 1 ELSE 0 END AS HasDetails
	FROM tbl_speedrun dn
	JOIN tbl_speedrun_video dn1 ON dn1.SpeedRunID = dn.ID
	LEFT JOIN tbl_speedrun_video_detail dn2 ON dn2.SpeedRunVideoID = dn1.ID
	
	