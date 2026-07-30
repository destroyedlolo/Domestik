-- We have to start the fan
--
-->> whenDone=MonitoringLivingStop
-->> when=EndMonitoringLivingStop
-->> need_topic=CmdFan

CmdFan:Publish("off")
