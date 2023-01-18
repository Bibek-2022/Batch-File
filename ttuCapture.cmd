

@echo off
setlocal EnableExtensions DisableDelayedExpansion

for /F "delims=" %%A IN ('findstr /C:"MMINV3TTUDevice::OnTECEvent(), Not available (\DEV\TTU)" "C:\Phoenix\SMARTatm\Logs\DEVTTU.LOG"') DO (
ECHO PV Generic Evt.TTUEventCaptured=%%A >> c:\proagent\data\temp\PVGenericMsg.txt
)
	

endlocal
exit /B
	
		