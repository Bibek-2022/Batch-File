@echo off

SETLOCAL
SETLOCAL enabledelayedexpansion
SETLOCAL enableextensions

set yyyy=

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

REM Get current date
set /A cur_dd=1%dd% - 100
set /A cur_mm=1%mm% - 100
set cur_yyyy=%yyyy%

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
set Cur_DT=%cur_dd%/%cur_mm%/%cur_yyyy%

REM Get total count for Deposit Bin Counter
setlocal
SET line = ""
SET /A output = -1
cmd /c pvprvuse -c > c:\proagent\data\temp\CassetteCount.txt

REM Search for deposit counters which are of "Type 5"
FOR /F "delims=" %%a IN ('findstr /C:"Type 5" "c:\\proagent\\data\\temp\\CassetteCount.txt"') DO (
	SET line=%%a
	SET /A posCounter = 0
	SET /A posGoal = -1
	
	FOR %%a IN (!line!) DO ( REM Look for 'Total count' and add up counter
		IF !posCounter! == !posGoal! (
			IF !output!==-1 (SET /A output = 0)
			SET /A output += %%a
		)
	
		IF %%a==Total (SET /A posGoal = !posCounter! + 2)
		SET /A posCounter += 1
	)
)
REM Save final output to PVGenericMsg
ECHO PV Generic Evt.DepositCount=!output! >> c:\proagent\data\temp\PVGenericMsg.txt
endlocal


