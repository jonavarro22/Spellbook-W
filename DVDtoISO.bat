@echo off
setlocal enabledelayedexpansion

rem -------------------------------------------------
rem STEP 1: Check if FFmpeg is installed
rem -------------------------------------------------
where ffmpeg >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] FFmpeg is not installed or not found in PATH.
    echo Please install FFmpeg and make sure it's added to your system PATH.
    echo Download from: https://ffmpeg.org/download.html
    pause
    exit /b 1
)

rem -------------------------------------------------
rem Define the path to the FFmpeg executable (if needed)
rem If FFmpeg is in PATH, simply "ffmpeg" will work.
rem -------------------------------------------------
set ffmpegPath=ffmpeg

rem -------------------------------------------------
rem Define the source DVD drive (adjust as needed)
rem -------------------------------------------------
set sourceDrive=D:

rem -------------------------------------------------
rem Define the destination folder
rem -------------------------------------------------
set destinationFolder=%USERPROFILE%\Downloads

rem Create the destination folder if it doesn't exist
if not exist "%destinationFolder%" mkdir "%destinationFolder%"

rem -------------------------------------------------
rem Extract the DVD volume label from drive D:
rem -------------------------------------------------
set dvdLabel=
for /f "tokens=3,* delims= " %%A in ('vol %sourceDrive% 2^>nul') do (
    if not defined dvdLabel (
        rem %%A should be the volume label after the words "Volume in drive D is"
        set dvdLabel=%%A %%B
    )
)

rem If for some reason the volume label wasn't found, default to "disc"
if not defined dvdLabel (
    set dvdLabel=disc
)

rem -------------------------------------------------
rem Remove characters that are invalid in filenames
rem ( \ / : * ? " < > | ) or that might cause problems
rem -------------------------------------------------
set "safeLabel=%dvdLabel%"
set "safeLabel=!safeLabel:\=!"
set "safeLabel=!safeLabel:/=!"
set "safeLabel=!safeLabel::=!"
set "safeLabel=!safeLabel:*=!"
set "safeLabel=!safeLabel:?=!"
set "safeLabel=!safeLabel:\"=!"
set "safeLabel=!safeLabel:<=!"
set "safeLabel=!safeLabel:>=!"
set "safeLabel=!safeLabel:|=!"

rem Trim leading/trailing spaces just in case
set "safeLabel=!safeLabel:~0,64!"
for /f "tokens=* delims= " %%i in ("!safeLabel!") do set "safeLabel=%%~i"

rem -------------------------------------------------
rem Construct the final ISO filename
rem -------------------------------------------------
set "isoFileName=%safeLabel%.iso"

rem -------------------------------------------------
rem Use FFmpeg to read from DVD drive and create ISO
rem (Depending on the DVD content, your FFmpeg parameters may differ.)
rem -------------------------------------------------
echo.
echo Creating ISO file. Please wait...
"%ffmpegPath%" -f dts -i "%sourceDrive%" "%destinationFolder%\%isoFileName%"

echo.
echo ISO file created at: "%destinationFolder%\%isoFileName%"
pause
endlocal
