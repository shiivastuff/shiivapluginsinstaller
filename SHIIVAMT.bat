@echo off
call :setESC

:: Check for administrator rights
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Running with administrator rights...
    goto UACPrompt
) else (
    goto AdminCheck
)

:UACPrompt
    echo Requesting admin rights...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /B

:AdminCheck
title SHIIVA - Plug-in installer
chcp 65001

:menu
cls
echo.
echo.
echo.
echo    %ESC%[38;2;3;98;128m	               ▄████████    ▄█    █▄     ▄█   ▄█   ▄█    █▄     ▄████████ 
echo    %ESC%[38;2;3;98;128m	              ███    ███   ███    ███   ███  ███  ███    ███   ███    ███ 
echo    %ESC%[38;2;55;139;164m	              ███    █▀    ███    ███   ███▌ ███▌ ███    ███   ███    ███ 
echo    %ESC%[38;2;55;139;164m	              ███         ▄███▄▄▄▄███▄▄ ███▌ ███▌ ███    ███   ███    ███ 
echo    %ESC%[38;2;129;190;206m	            ▀███████████ ▀▀███▀▀▀▀███▀  ███▌ ███▌ ███    ███ ▀███████████ 
echo    %ESC%[38;2;129;190;206m	                     ███   ███    ███   ███  ███  ███    ███   ███    ███ 
echo    %ESC%[38;2;232;237;231m	               ▄█    ███   ███    ███   ███  ███  ███    ███   ███    ███ 
echo    %ESC%[38;2;232;237;231m	             ▄████████▀    ███    █▀    █▀   █▀    ▀██████▀    ███    █▀  
echo.
echo                        			https://shiivastuff.github.io/
echo.
echo.

cd /d "%~dp0files"

:: Display menu options
echo %ESC%[38;2;232;237;231m 1. Install Plug-ins
echo %ESC%[38;2;232;237;231m 2. View List of Plugins
echo %ESC%[38;2;232;237;231m 3. Leave
echo.
set /p choice="    Choose an option: "

:: Handle user choice
if "%choice%"=="" (
    set "choice="
    goto menu
) else if "%choice%"=="1" (
    echo.
    echo Installing plug-ins...
    start /B Python\python.exe pySHV.py
    echo %ESC%[32mPlugins installed! %ESC%[0m
    echo.
    pause
    set "choice="
    goto menu
) else if "%choice%"=="2" (
    cls  
    echo.
    echo Listing plugins...
    echo.
    setlocal enabledelayedexpansion
    set "pluginsFile=%~dp0plugins.txt" 

    if exist "!pluginsFile!" (
        for /F "usebackq delims=" %%a in ("!pluginsFile!") do (
            echo %%a
        )
    ) else (
        echo Plugins file not found: "!pluginsFile!"
    )

    echo.
    echo Press Enter to return to the menu...
    set /p dummy=" "
    set "choice="
    goto menu
) else if "%choice%"=="3" (
    echo.
    echo Exiting...
    exit
) else (
    set "choice="
    goto menu
)

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0

pause
