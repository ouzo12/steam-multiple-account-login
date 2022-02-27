@echo off
setlocal enabledelayedexpansion
set count=0
set usernames=username1 username2 username3 username4
cls
echo Created by AnkerAnd (Thomas Adams) in 2022.
for /f "tokens=3" %%a in ('reg query "HKCU\Software\Valve\Steam" /v "AutoLoginUser" ^| findstr /ri "REG_SZ"') do echo Current login: '%%a' && echo If chosing the same user steam will just shutdown. You will have to start steam manually.
for %%0 in (%usernames%) do (
    set /a count=count+1
    set choice[!count!]=%%0
)

echo.
echo What username to use?
echo *** Warning *** when selecting username your steam will shutdown and try to access steam with the selecte user.
echo Press CTRL+C to terminat this job.
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
timeout 7 /NOBREAK
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
start steam://open/main
