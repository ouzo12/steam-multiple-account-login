@echo off
setlocal enabledelayedexpansion
set count=0
set usernames=username1 username2 username3 username4
for %%0 in (%usernames%) do (
    set /a count=count+1
    set choice[!count!]=%%0
)

echo.
echo What username to use?
echo *** Warning *** when selecting username your steam will shutdown and try to access with the selecte user.
echo Press CTRL-C to terminat this job.
echo.
for /l %%x in (1,1,!count!) do (
    echo [%%x] !choice[%%x]!
)
echo.
set /p chose=?
echo.
echo You chose !choice[%chose%]!
set username=!choice[%chose%]!

c:
cd C:\Program Files (x86)\Steam\
start steam.exe -shutdown
timeout 5
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
start steam://open/main
