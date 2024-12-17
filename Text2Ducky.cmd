@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM ------------------------------------------
REM 1) List .txt files (excluding OutputFile.txt)
REM ------------------------------------------
echo Listing available text files in the current folder (excluding OutputFile.txt)...
SET /A index=1
SET /A fileCount=0

FOR /F "delims=" %%F IN ('dir /b *.txt 2^>nul') DO (
    REM Extract the base filename (no extension)
    SET "baseName=%%~nF"
    REM Check if "_ducky" substring is present
    echo !baseName! | find /I "_ducky" >nul
    IF ERRORLEVEL 1 (
        REM If not found, list it
        echo  !index!: %%F
        SET "file[!index!]=%%F"
        SET /A index+=1
        SET /A fileCount+=1
    )
)

REM If no .txt files found, inform and exit
IF %fileCount% EQU 0 (
    echo.
    echo No valid .txt files found in the current directory.
    GOTO :EOF
)

echo.

REM ------------------------------------------
REM 2) Prompt the user to pick from the list
REM ------------------------------------------
:chooseFile
set /P choice="Type the number of the file you want to ingest (1-%fileCount%): "

REM Validate choice is within range
IF "%choice%"=="" GOTO chooseFile
IF %choice% GEQ 1 IF %choice% LEQ %fileCount% (
    SET "FILEIN=!file[%choice%]!"
) ELSE (
    echo Invalid choice. Try again.
    GOTO chooseFile
)

echo.
echo You selected "%FILEIN%".
echo.

REM ------------------------------
REM 3) Build the default output name
REM ------------------------------
REM Example: If input is MyFile.txt, default becomes MyFile_ducky.txt
SET "baseName=%FILEIN:~0,-4%"  REM Drop the last 4 characters (.txt)
SET "outputName=%baseName%_ducky"  REM Save base output name
SET "extension=.txt"                REM Save extension

REM Prompt user for custom output. If none provided, use default
SET /P "FILEOUT=Enter output filename [Default: %outputName%%extension%]: "
IF "%FILEOUT%"=="" (
    SET "FILEOUT=%outputName%%extension%"
)

REM -------------------------------------------------------------
REM 4) If that output file exists, add a counter dynamically
REM -------------------------------------------------------------
SET /A counter=0

:checkFileExists
IF EXIST "%FILEOUT%" (
    SET /A counter+=1
    SET "FILEOUT=%outputName%%counter%%extension%"
    GOTO checkFileExists
)

echo Final output filename: "%FILEOUT%"
echo.

REM ------------------------------
REM 5) Convert the chosen file into Ducky Script
REM ------------------------------
IF EXIST "%FILEOUT%" del "%FILEOUT%"

echo Processing "%FILEIN%" ...
FOR /F "usebackq delims=" %%I IN ("%FILEIN%") DO (
    echo STRING %%I>> "%FILEOUT%"
    echo ENTER>> "%FILEOUT%"
)

echo Conversion complete!
echo Ducky Script file generated: "%FILEOUT%"

ENDLOCAL
GOTO :EOF