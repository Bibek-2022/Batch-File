@echo off
SETLOCAL enabledelayedexpansion
SETLOCAL enableextensions

SET ProAgentPath=C:\Temp\ProagentMVP2
SET File=atmconfig.xml
set result1=false
set /a count = 0

@REM Create a Generic Event
cmd /c ECHO PV Generic Evt.ProagentMVP2Started=1 >> c:\proagent\data\temp\PVGenericMsg.txt


cmd /c C:\ProAgent\bin\HWDETECT.exe C:\ProAgent\data\TIS C:\Temp\ProagentMVP2\atmconfig.xml

REM Time OUT 
:check
cmd /c ping localhost -n 20

REM if the count is 4 (90 sec) then it exits
if %count% == 3 goto atm

REM Check if the file exist -yes then next step if not goto time out again and delay for 15 sec
if not exist %ProAgentPath%\atmconfig.xml (
   set /a count = count + 1;
   goto check
)

REM finds the string in respective file 
cmd /c findstr /C:"MixedAcceptor" %ProAgentPath%\atmconfig.xml 
IF %errorlevel% == 0 (
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Modules\PvXfs" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU:CashInModule1:BunchCheque1" /f
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Provider\PrvDeviceInfo" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU:CashInModule1:BunchCheque1" /f
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Provider\PrvWosa" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU:CashInModule1:BunchCheque1" /f
ECHO CurrencyDispenser1;CashInModule1;IDCardUnit1;BunchCheque1;PinPad1;BarcodeReader1;ReceiptPrinter1;SIU >> c:\proagent\data\pvinvent.ini
goto atm2
)

:atm
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Modules\PvXfs" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU" /f
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Provider\PrvDeviceInfo" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU" /f
cmd /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Wincor Nixdorf\ProAgent\CurrentVersion\Provider\PrvWosa" /v "DeviceList" /d "CurrencyDispenser1:IDCardUnit1:PinPad1:BarcodeReader1:ReceiptPrinter1:SIU" /f
ECHO CurrencyDispenser1;IDCardUnit1;PinPad1;BarcodeReader1;ReceiptPrinter1;SIU >> c:\proagent\data\pvinvent.ini


:atm2
cmd /c reg import %ProAgentPath%\UpdateAfter_install.reg

REM Copy the file to destination
CMD /C xcopy %ProAgentPath%\data\* c:\proagent\data\ /Y /E

cmd /c rd /S /Q %ProAgentPath%

ENDLOCAL

exit /B 0


