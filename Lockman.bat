@echo off
title Lockman Folder Locker
color 0a

set "PASSWORD=password"  :: Default password is 'password'

:MENU
cls
echo ================================
echo        LOCKMAN SYSTEM
echo ================================
echo.
echo [1] Lock Folder
echo [2] Unlock Folder
echo [3] Exit
echo.
set /p option=Choose an option (1-3): 

if "%option%"=="1" goto LOCK
if "%option%"=="2" goto UNLOCK
if "%option%"=="3" exit
goto MENU

:LOCK
if not exist "Private" (
    mkdir Private
    echo Folder created: Private
)
attrib +h +s "Private"
echo Folder is now locked
pause
goto MENU

:UNLOCK
set /p pass=Enter password: 
if "%pass%"=="%PASSWORD%" (
    attrib -h -s "Private"
    echo Folder is now unlocked
) else (
    echo Wrong password
)
pause
goto MENU
