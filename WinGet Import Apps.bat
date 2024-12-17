@echo off
setlocal enabledelayedexpansion

:: List all logical drives and save to drive_list.txt
wmic logicaldisk get name > drive_list.txt

:: Display drive list
echo Available drives:
type drive_list.txt

:: Prompt user to select a drive
set /p drive="Enter the drive letter where the app list is located (e.g., D): "

:: Validate input (only a single letter)
if not "!drive!"=="" (
    set drive=!drive!:\
    if exist !drive! (
        :: Prompt user to enter the file name
        set /p filename="Enter the app list file name (e.g., apps_list.txt): "

        if exist "!drive!!filename!" (
            echo Importing apps from !drive!!filename!...
            for /f "tokens=*" %%A in (!drive!!filename!) do (
                winget install %%A --accept-package-agreements --accept-source-agreements
            )
            echo Import completed successfully!
        ) else (
            echo File does not exist on the selected drive.
        )
    ) else (
        echo Invalid drive selected.
    )
) else (
    echo No drive selected.
)

pause
