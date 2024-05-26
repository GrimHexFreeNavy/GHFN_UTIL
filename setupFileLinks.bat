@echo off
CLS

setlocal enableDelayedExpansion
SET switches=/S /XJD /R:25 /W:4 /E /V /ETA

WHERE robocopy  > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Robocopy not installed exiting!
    pause
    exit
)
net session > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Script requires admin permission, please rerun as admin . . . exiting.
    pause
    exit
)

echo Backing up user folders . . .
IF EXIST "%~dp0..\PTU" (
    robocopy "%~dp0..\PTU\USER" "%~dp0\PTU.USER.BACKUP" %switches% > nul 2>&1
)
IF EXIST "%~dp0..\EPTU" (
    robocopy "%~dp0..\EPTU\USER" "%~dp0\EPTU.USER.BACKUP" %switches% > nul 2>&1
)
IF EXIST "%~dp0..\TECH-PREVIEW" (
    robocopy "%~dp0..\TECH-PREVIEW\USER" "%~dp0\TECH-PREVIEW.USER.BACKUP" %switches% > nul 2>&1
)
IF EXIST "%~dp0..\HOTFIX" (
    robocopy "%~dp0..\HOTFIX\USER" "%~dp0\HOTFIX.USER.BACKUP" %switches% > nul 2>&1
)
IF EXIST "%~dp0..\LIVE" (
    robocopy "%~dp0..\LIVE\USER" "%~dp0\LIVE.USER.BACKUP" %switches% > nul 2>&1
)

echo Removing test Environments . . .
rmdir /s /q "%~dp0..\PTU" > nul 2>&1
rmdir /s /q "%~dp0..\EPTU" > nul 2>&1
rmdir /s /q "%~dp0..\TECH-PREVIEW" > nul 2>&1
rmdir /s /q "%~dp0..\HOTFIX" > nul 2>&1

echo Copying LIVE to ETF . . .
IF EXIST "%~dp0..\LIVE" (
    robocopy "%~dp0..\LIVE" "%~dp0..\ETF" %switches%
)

echo Renaming LIVE to GAME . . .
IF EXIST "%~dp0..\LIVE" (
    ren "%~dp0..\LIVE" GAME
)

echo Create symlinks for GAME . . .
echo This will link the GAME folder to LIVE TECH-PREVIEW and HOTFIX
IF EXIST "%~dp0..\GAME" (
    mklink /D "%~dp0..\LIVE" "%~dp0..\GAME" > nul 2>&1
    mklink /D "%~dp0..\TECH-PREVIEW" "%~dp0..\GAME" > nul 2>&1
    mklink /D "%~dp0..\HOTFIX" "%~dp0..\GAME" > nul 2>&1
)

echo Create symlinks for ETF . . .
echo This will link the ETF folder to PTU and EPTU
IF EXIST "%~dp0..\ETF" (
    mklink /D "%~dp0..\PTU" "%~dp0..\ETF" > nul 2>&1
    mklink /D "%~dp0..\EPTU" "%~dp0..\ETF" > nul 2>&1
)

echo ==================================================================================
echo Open the Star Citizen Launcher and Verify Game Files on all available environments
echo ==================================================================================
pause
exit