@echo off
setlocal

rem Define the path to the FFmpeg executable
set ffmpegPath=ffmpeg

rem Define the source drive (adjust as needed)
set sourceDrive=D:

rem Define the destination folder
set destinationFolder=%USERPROFILE%\Downloads

rem Create the destination folder if it doesn't exist
if not exist "%destinationFolder%" mkdir "%destinationFolder%"

rem Define the ISO file name
set isoFileName=disc.iso

rem Command to create ISO using FFmpeg
ffmpeg -f dts -i "D:" "%%USERPROFILE%\Downloads%\disc.iso"

echo ISO file created at: "%destinationFolder%\%isoFileName%"
pause
endlocal
