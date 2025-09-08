@echo off
title DigiLocker
color 0a

if not exist password.txt (
    echo password>password.txt
)

:MENU
cls
echo =============================
echo         DIGILOCKER
echo =============================
echo 1. Lock Folder
echo 2. Unlock Folder
echo 3. Change Password
echo 4. Recovery (show saved password)
echo 5. Exit
echo =============================
set /p choice=Choose an option: 

if "%choice%"=="1" goto LOCK
if "%choice%"=="2" goto UNLOCK
if "%choice%"=="3" goto CHANGEPASS
if "%choice%"=="4" goto RECOVERY
if "%choice%"=="5" exit
goto MENU

:LOCK
color 0c
if not exist Locker (
    echo Folder does not exist. Creating Locker folder...
    mkdir Locker
)
if exist "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
    echo Folder is already locked!
    pause
    goto MENU
)
ren Locker "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder Locked 🔒
pause
goto MENU

:UNLOCK
color 0b
if not exist "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
    echo Folder is already unlocked or missing.
    pause
    goto MENU
)

set /p pass=Enter password: 
set /p savedpass=<password.txt

if "%pass%"=="%savedpass%" (
    attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
    ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Locker
    echo Folder Unlocked
) else (
    echo Incorrect Password!
)
pause
goto MENU

:CHANGEPASS
color 0e
set /p oldpass=Enter old password: 
set /p savedpass=<password.txt
if not "%oldpass%"=="%savedpass%" (
    echo Wrong password!
    pause
    goto MENU
)
set /p newpass=Enter new password: 
echo %newpass%>password.txt
echo Password changed successfully!
pause
goto MENU

:RECOVERY
color 0d
echo ===== RECOVERY =====
echo Current saved password is:
type password.txt
echo =====================
pause
goto MENU
