@echo off
:MENU
cmd /c cls 
echo User: %USERNAME% &echo.
echo 1) RDP to ATS
echo 2) RDP to CBA
echo 3) RDP to NAB
echo 4) Vynamic View &echo.

set /p type= Choose one: &echo.

IF %type% == 1 GOTO RDP_ATS
IF %type% == 2 GOTO RDP_CBA
IF %type% == 3 GOTO RDP_NAB
IF %type% == 4 GOTO VV

GOTO:end

:RDP_ATS
echo This is ATS:&echo.
echo 11) CERT Server 1
echo 12) CERT Server 2
echo 13) CERT Database
echo 14) CERT IM Server
echo 15) CERT Integration Server&echo.
echo 21) PROD Server 1
echo 22) PROD Server 2
echo 23) PROD IM Server
echo 24) PROD VV Database
echo 25) PROD IM Database 
echo 26) PROD Integration Server
echo 27) PROD Business Server
echo 28) PROD Commander Agent 1
echo 29) PROD Commander Agent 2
echo 30) PROD Commander DB Server &echo.

echo 0) Back to the Future &echo.

set /p server1= Choose one: &echo.

IF %server1% == 11 cmd /c mstsc /V:10.22.8.105
IF %server1% == 12 cmd /c mstsc /V:10.22.8.109
IF %server1% == 13 cmd /c mstsc /V:10.22.8.106
IF %server1% == 14 cmd /c mstsc /V:10.22.8.111
IF %server1% == 15 cmd /c mstsc /V:10.22.8.112

IF %server1% == 21 cmd /c mstsc /V:10.22.8.69
IF %server1% == 22 cmd /c mstsc /V:10.22.8.70
IF %server1% == 23 cmd /c mstsc /V:10.22.8.73
IF %server1% == 24 cmd /c mstsc /V:10.22.8.74
IF %server1% == 25 cmd /c mstsc /V:10.22.8.75

IF %server1% == 26 cmd /c mstsc /V:10.22.8.87
IF %server1% == 27 cmd /c mstsc /V:10.22.10.57
IF %server1% == 28 cmd /c mstsc /V:172.16.1.60
IF %server1% == 29 cmd /c mstsc /V:172.16.1.61
IF %server1% == 30 cmd /c mstsc /V:172.16.1.62

IF %server1% == 0 GOTO MENU

GOTO:end

:RDP_CBA
echo 11) DEV Server
echo 12) DEV Database
echo 13) DEV Gateway &echo.
echo 21) CERT Server 1
echo 22) CERT Server 2
echo 23) CERT Server 3
echo 24) CERT Server 4
echo 25) CERT IM Server
echo 26) CERT VV Database
echo 27) CERT IM Database 
echo 28) CERT Integration &echo.
echo 31) PROD Server 1
echo 32) PROD Server 2
echo 33) PROD Server 3
echo 34) PROD Server 4
echo 35) PROD IM Server
echo 36) PROD VV Database
echo 37) PROD IM Database 
echo 38) PROD Integration &echo.

echo 0) Back to the Future &echo.

set /p server2= Choose one: &echo.

IF %server2% == 11 cmd /c mstsc /V:172.16.3.37
IF %server2% == 12 cmd /c mstsc /V:172.16.3.38
IF %server2% == 13 cmd /c mstsc /V:172.16.3.39

IF %server2% == 21 cmd /c mstsc /V:172.16.101.9
IF %server2% == 22 cmd /c mstsc /V:172.16.101.10
IF %server2% == 23 cmd /c mstsc /V:172.16.101.45
IF %server2% == 24 cmd /c mstsc /V:172.16.101.46
IF %server2% == 25 cmd /c mstsc /V:172.16.101.11
IF %server2% == 26 cmd /c mstsc /V:172.16.101.12
IF %server2% == 27 cmd /c mstsc /V:172.16.101.29
IF %server2% == 28 cmd /c mstsc /V:172.16.101.28

IF %server2% == 31 cmd /c mstsc /V:172.16.100.5
IF %server2% == 32 cmd /c mstsc /V:172.16.100.6
IF %server2% == 33 cmd /c mstsc /V:172.16.100.21
IF %server2% == 34 cmd /c mstsc /V:172.16.100.22
IF %server2% == 35 cmd /c mstsc /V:172.16.100.7
IF %server2% == 36 cmd /c mstsc /V:172.16.100.8
IF %server2% == 37 cmd /c mstsc /V:172.16.100.16
IF %server2% == 38 cmd /c mstsc /V:172.16.100.15

IF %server2% == 0 GOTO MENU

GOTO:end

:RDP_NAB
echo This is NAB:&echo.
echo 11) CERT Server 1
echo 12) CERT Server 2
echo 13) CERT Database
echo 14) CERT IM Server
echo 15) CERT Integration Server&echo.
echo 21) PROD Server 1
echo 22) PROD Server 2
echo 23) PROD VV Database
echo 24) PROD IM Server
echo 25) PROD IM DB Server
echo 26) PROD Integration Server&echo.

echo 0) Back to the Future &echo.

set /p server3= Choose one: &echo.

IF %server3% == 11 cmd /c mstsc /V:10.22.8.133
IF %server3% == 12 cmd /c mstsc /V:10.22.8.136
IF %server3% == 13 cmd /c mstsc /V:10.22.8.134
IF %server3% == 14 cmd /c mstsc /V:10.22.8.137
IF %server3% == 15 cmd /c mstsc /V:10.22.8.138

IF %server3% == 21 cmd /c mstsc /V:10.250.55.5
IF %server3% == 22 cmd /c mstsc /V:10.250.55.6
IF %server3% == 23 cmd /c mstsc /V:10.250.55.7
IF %server3% == 24 cmd /c mstsc /V:10.250.55.9
IF %server3% == 25 cmd /c mstsc /V:10.250.55.10
IF %server3% == 26 cmd /c mstsc /V:10.250.55.11

IF %server3% == 0 GOTO MENU

GOTO:end

:VV
echo This is Vynamic View:&echo.
echo 1) ATS CERT IM Server
echo 2) ATS PROD IM Server
echo 3) CBA DEV Server
echo 4) CBA CERT IM Server
echo 5) CBA PROD IM Server
echo 6) NAB CERT IM SERVER &echo.

echo 0) Back to the Future &echo.

set /p choice= Choose one: &echo.

IF %choice% == 0 GOTO MENU
rmdir /q /s %UserProfile%\.vvconsole

IF %choice% == 1 start "" "C:\Users\%username%\Desktop\VVHub\VV_ATSCERT"
IF %choice% == 2 start "" "C:\Users\%username%\Desktop\VVHub\VV_ATSPROD"
IF %choice% == 3 start "" "C:\Users\%username%\Desktop\VVHub\VV_CBADEV"
IF %choice% == 4 start "" "C:\Users\%username%\Desktop\VVHub\VV_CBACERT"
IF %choice% == 5 start "" "C:\Users\%username%\Desktop\VVHub\VV_CBAPROD"
IF %choice% == 6 start "" "C:\Users\%username%\Desktop\VVHub\VV_NABCERT"

GOTO:end

:end
exit 0