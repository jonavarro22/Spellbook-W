@echo off

::--- 1. Check if Python is installed ---------------------
echo Checking if Python is installed...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python before proceeding.
    pause
    exit /b
)

::--- 2. Check if pip is available ------------------------
echo Checking if pip is available...
pip --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo pip not found. Please install pip before proceeding.
    pause
    exit /b
)

::--- 3. Update yt-dlp ------------------------------------
echo Updating yt-dlp to the latest version...
pip install --upgrade yt-dlp
echo.

::--- 4. Prompt for YouTube link --------------------------
set /p link="Enter the YouTube link: "
if "%link%"=="" (
    echo No YouTube link provided. Exiting...
    pause
    exit /b
)

::--- 5. Prompt for download folder (default = Downloads) --
set /p folder="Enter the folder to save the file in (press Enter to save in Downloads): "
if "%folder%"=="" set folder=%USERPROFILE%\Downloads

if not exist "%folder%" (
    echo Folder does not exist. Creating folder...
    mkdir "%folder%"
)

::--- 6. Prompt for Premium usage (default = yes) ---------
echo Do you want to use Premium cookies for better quality? [Y/n]
set defaultChoice=Y
set /p premiumChoice=""
if "%premiumChoice%"=="" set premiumChoice=%defaultChoice%

:: Convert the first character to uppercase
set premiumChoice=%premiumChoice:~0,1%
set premiumChoice=%premiumChoice:"=%
if /I "%premiumChoice%"=="y" set premiumChoice=Y
if /I "%premiumChoice%"=="n" set premiumChoice=N

::--- 7. Download logic -----------------------------------
if /I "%premiumChoice%"=="Y" (
    echo Attempting to use cookies from Firefox...
    yt-dlp --cookies-from-browser firefox ^
        -o "%folder%\%%(title)s.%%(ext)s" ^
        -f bestvideo+bestaudio ^
        --merge-output-format mp4 ^
        %link%

    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo Could not parse cookies from Firefox or an error occurred.
        echo [1] Enter another browser name (edge, chrome, opera, etc.)
        echo [2] Provide a cookies.txt file path
        set /p fallbackChoice="Choice [1/2]? "

        if "%fallbackChoice%"=="1" (
            set /p customBrowser="Enter browser name (edge, chrome, opera, etc.): "
            yt-dlp --cookies-from-browser %customBrowser% ^
                -o "%folder%\%%(title)s.%%(ext)s" ^
                -f bestvideo+bestaudio ^
                --merge-output-format mp4 ^
                %link%
            
            if %ERRORLEVEL% NEQ 0 (
                echo Failed to parse cookies from '%customBrowser%'. Exiting...
                pause
                exit /b
            )
        ) else if "%fallbackChoice%"=="2" (
            set /p cookieFile="Enter the full path to your cookies.txt file: "
            yt-dlp --cookies "%cookieFile%" ^
                -o "%folder%\%%(title)s.%%(ext)s" ^
                -f bestvideo+bestaudio ^
                --merge-output-format mp4 ^
                %link%

            if %ERRORLEVEL% NEQ 0 (
                echo Could not use the specified cookies file. Exiting...
                pause
                exit /b
            )
        ) else (
            echo Invalid choice. Exiting...
            pause
            exit /b
        )
    )
) else (
    :: Non-premium download
    yt-dlp -o "%folder%\%%(title)s.%%(ext)s" ^
           -f bestvideo+bestaudio ^
           --merge-output-format mp4 ^
           %link%
)

echo.
echo Download finished!
pause
exit /b
