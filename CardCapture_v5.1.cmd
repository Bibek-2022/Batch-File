@echo off

SETLOCAL
SETLOCAL enabledelayedexpansion
SETLOCAL enableextensions

set yyyy=
set cur_yyyy=

set $tok=1-3
for /f "tokens=1 delims=.:/-, " %%u in ('date /t') do set $d1=%%u
if "%$d1:~0,1%" GTR "9" set $tok=2-4
for /f "tokens=%$tok% delims=.:/-, " %%u in ('date /t') do (
for /f "skip=1 tokens=2-4 delims=/-,()." %%x in ('echo.^|date') do (
set %%x=%%u
set %%y=%%v
set %%z=%%w
set $d1=
set $tok=))

if "%yyyy%"=="" set yyyy=%yy%
if /I %yyyy% LSS 100 set /A yyyy=2000 + 1%yyyy% - 100
SET /A new_YY = %yyyy% - 2000

set dayCnt=1

REM Substract your days here
set /A dd=1%dd% - 100 - %dayCnt%
set /A mm=1%mm% - 100

REM Get current date
set /A cur_dd=%dd% + %dayCnt%
set cur_mm=%mm%
set cur_yyyy=%yyyy%

:CHKDAY
if /I %dd% GTR 0 goto DONE
set /A mm=%mm% - 1
if /I %mm% GTR 0 goto ADJUSTDAY
set /A mm=12
set /A yyyy=%yyyy% - 1

:ADJUSTDAY
if %mm%==1 goto SET31
if %mm%==2 goto LEAPCHK
if %mm%==3 goto SET31
if %mm%==4 goto SET30
if %mm%==5 goto SET31
if %mm%==6 goto SET30
if %mm%==7 goto SET31
if %mm%==8 goto SET31
if %mm%==9 goto SET30
if %mm%==10 goto SET31
if %mm%==11 goto SET30
REM ** Month 12 falls through

:SET31
set /A dd=31 + %dd%
goto CHKDAY

:SET30
set /A dd=30 + %dd%
goto CHKDAY

:LEAPCHK
set /A tt=%yyyy% %% 4
if not %tt%==0 goto SET28
set /A tt=%yyyy% %% 100
if not %tt%==0 goto SET29
set /A tt=%yyyy% %% 400
if %tt%==0 goto SET29

:SET28
set /A dd=28 + %dd%
goto CHKDAY

:SET29
set /A dd=29 + %dd%
goto CHKDAY

:DONE
if /I %mm% LSS 10 set mm=0%mm%
if /I %dd% LSS 10 set dd=0%dd%

:cur_CHKDAY
if /I %cur_dd% GTR 0 goto cur_DONE
set /A cur_mm=%cur_mm% - 1
if /I %cur_mm% GTR 0 goto cur_ADJUSTDAY
set /A cur_mm=12
set /A cur_yyyy=%cur_yyyy% - 1

:cur_ADJUSTDAY
if %cur_mm%==1 goto cur_SET31
if %cur_mm%==2 goto cur_LEAPCHK
if %cur_mm%==3 goto cur_SET31
if %cur_mm%==4 goto cur_SET30
if %cur_mm%==5 goto cur_SET31
if %cur_mm%==6 goto cur_SET30
if %cur_mm%==7 goto cur_SET31
if %cur_mm%==8 goto cur_SET31
if %cur_mm%==9 goto cur_SET30
if %cur_mm%==10 goto cur_SET31
if %cur_mm%==11 goto cur_SET30
REM ** Month 12 falls through

:cur_SET31
set /A cur_dd=31 + %cur_dd%
goto cur_CHKDAY

:cur_SET30
set /A cur_dd=30 + %cur_dd%
goto cur_CHKDAY

:cur_LEAPCHK
set /A cur_tt=%cur_yyyy% %% 4
if not %cur_tt%==0 goto cur_SET28
set /A cur_tt=%cur_yyyy% %% 100
if not %cur_tt%==0 goto cur_SET29
set /A cur_tt=%cur_yyyy% %% 400
if %cur_tt%==0 goto cur_SET29

:cur_SET28
set /A cur_dd=28 + %cur_dd%
goto cur_CHKDAY

:cur_SET29
set /A cur_dd=29 + %cur_dd%
goto cur_CHKDAY

:cur_DONE
if /I %cur_mm% LSS 10 set cur_mm=0%cur_mm%
if /I %cur_dd% LSS 10 set cur_dd=0%cur_dd%

REM Set Date for EMV ERROR DATA
set YDT=%yyyy%%mm%%dd%
set Cur_DT=%cur_dd%/%cur_mm%/%cur_yyyy%
SET new_Date=%cur_dd%/%cur_mm%/%New_YY%

REM Check if any date is provided, else take yesterday
set EMVDT=%1

if "%EMVDT%"=="" set EMVDT=%YDT%

REM Card Retained Count
findstr /C:"%Cur_DT% CARD RETAINED" "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log" | find  /c ":" > c:\proagent\data\temp\result.txt
(SET flist=)
FOR /f "delims=" %%x IN (C:\proagent\data\temp\result.txt) DO (
CALL SET flist=%%flist%%, %%x
)
SET flist=%flist:~2%

REM Card Retained Bin
setlocal
findstr /C:"Card inserted" "C:\journal\%EMVDT%.jrn" | find  /c ":" > c:\proagent\data\temp\result.txt
(SET flist1=cmd /c pvprvuse -n)
FOR /f "delims=" %%x IN ('%flist1%') DO (
CALL SET flist1=%%x
)
SET flist1=%flist1:~6%

REM Card Eject Error
findstr /C:"%Cur_DT% CARD Eject ERROR" "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log" | find  /c ":" > c:\proagent\data\temp\result.txt
(SET flist2=)
FOR /f "delims=" %%x IN (C:\proagent\data\temp\result.txt) DO (
CALL SET flist2=%%flist2%%, %%x
)
SET flist2=%flist2:~2%

REM Output
ECHO PV Generic Evt.CardCaptureDate=%EMVDT%^&CardRetained=%flist%^&CardCapture=%flist1%^&CardEjectError=%flist2%  >> c:\proagent\data\temp\PVGenericMsg.txt

for /F "delims=" %%x IN ('findstr /C:"%Cur_DT% CARD RETAINED" "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log"') DO (
ECHO PV Generic Evt.CardRetainedDate=%Cur_DT%^&CardRetainedEvent=%%x >> c:\proagent\data\temp\PVGenericMsg.txt
)

for /F "delims=" %%x IN ('findstr /C:"%Cur_DT% CARD Eject ERROR" "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log"') DO (
ECHO PV Generic Evt.CardEjectErrorDate=%Cur_DT%^&CardEjectEvent=%%x >> c:\proagent\data\temp\PVGenericMsg.txt
)

REM Response CODE
for /F "tokens=1,2 delims=:" %%a IN ('findstr /N /C:"RESP 04" /C:"RESP 07" /C:"RESP 33" /C:"RESP 34" /C:"RESP 36" /C:"RESP 38" /C:"RESP 41" /C:"RESP 43" /C:"RESP 67" /C:"RESP 75"
						  "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log"') DO (
	SET /A line=%%a
	SET /A line-=7
	SET RESPcode=%%b
	
	for /f "tokens=1*delims=:" %%a in ('findstr /N /R "\/22" "C:\\Phoenix\\SMARTatm\\Activity\\TestLOG.log"') do (
		if %%a==!line! (
			SET dateTime=%%b
			SET _date=!dateTime:~0,8!
			SET _time=!dateTime:~9!
				
			IF !_date! == %new_Date% ECHO PV Generic Evt.ResponseCodeDate=%new_Date%^&CardResponseCode=!_time! !_date! !RESPcode! >> c:\proagent\data\temp\PVGenericMsg.txt
		)
	)
)
endlocal
