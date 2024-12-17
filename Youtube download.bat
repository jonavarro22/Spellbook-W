@echo off
:: Check for Python
echo Checking if Python is installed...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python before proceeding.
    pause
    exit /b
)

:: Check for pip
echo Checking if pip is available...
pip --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo pip not found. Please install pip before proceeding.
    pause
    exit /b
)

:: Update yt-dlp
echo Updating yt-dlp to the latest version...
pip install --upgrade yt-dlp
echo.

:: Get YouTube link
set /p link="Enter the YouTube link: "
if "%link%"=="" (
    echo No YouTube link provided. Exiting...
    pause
    exit /b
)

:: Get target folder
set /p folder="Enter the folder to save the file in (press Enter to save in Downloads): "
if "%folder%"=="" set folder=%USERPROFILE%\Downloads

:: Create/validate folder
if not exist "%folder%" (
    echo The specified folder does not exist. Creating folder...
    mkdir "%folder%"
)

:: Download video/audio in best quality
echo Downloading...
yt-dlp ^
    -o "%folder%\%%(title)s.%%(ext)s" ^
    -f bestvideo+bestaudio ^
    --merge-output-format mp4 ^
    --add-metadata ^
    --embed-thumbnail ^
    %link%

echo.
echo Download completed!
pause
exit /b
