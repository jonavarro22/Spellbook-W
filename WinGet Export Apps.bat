@echo off
setlocal enabledelayedexpansion

:: List all logical drives and save to drive_list.txt
wmic logicaldisk get name > drive_list.txt

:: Display drive list
echo Available drives:
type drive_list.txt

:: Prompt user to select a drive
set /p drive="Enter the drive letter to export the app list (e.g., D): "

:: Validate input (only a single letter)
if not "!drive!"=="" (
    set drive=!drive!:\
    if exist !drive! (
        echo Exporting installed apps list to !drive!apps_list.txt...
        winget list > "!drive!apps_list.txt"
        echo Export completed successfully!
    ) else (
        echo Invalid drive selected.
    )
) else (
    echo No drive selected.
)

pause
