# Spellbook-W

# Batch Scripts Collection

This repository contains a set of Windows batch scripts designed to automate various tasks, including package management with **WinGet**, YouTube video downloads, and DVD/ISO processing. These scripts streamline software updates, backups, and media handling, saving time and effort.

---

## Table of Contents
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Scripts Details](#scripts-details)
- [Contributing](#contributing)
- [License](#license)

---

## Scripts Overview
This repository includes the following batch scripts:

| Script Name                  | Description                                             |
|------------------------------|---------------------------------------------------------|
| `WinGet Export Apps.bat`     | Exports installed apps to a JSON file using WinGet.     |
| `WinGet Import Apps.bat`     | Installs apps from a JSON list using WinGet.            |
| `WinGet Update.bat`          | Updates installed apps using WinGet.                    |
| `ffmpegToISO.bat`            | Converts media files to ISO format using FFmpeg.        |
| `DVDtoISO.bat`               | Converts DVDs into ISO images.                          |
| `Youtube download.bat`       | Downloads YouTube videos using `yt-dlp`.                |
| `Youtube download premium.bat` | Downloads premium YouTube videos via `yt-dlp`.        |

---

## Prerequisites
Ensure you have the following tools installed and available in your system PATH:

1. **WinGet**: Microsoft Windows Package Manager - [Install WinGet](https://aka.ms/getwinget)
2. **FFmpeg**: For media conversions - [Download FFmpeg](https://ffmpeg.org/download.html)
3. **yt-dlp**: Advanced YouTube downloader - [Install yt-dlp](https://github.com/yt-dlp/yt-dlp)

**Optional:**
- DVD handling tools (if using `DVDtoISO.bat`)

---

## Installation
To use these scripts:
1. Clone this repository:
   ```bash
   git clone https://github.com/<your_username>/<repository_name>.git
   cd <repository_name>
   ```
2. Place the required tools (WinGet, FFmpeg, yt-dlp) in your system PATH.
3. Run the desired script by double-clicking it or executing it via the command line.

---

## Usage
Here are examples for using each script:

### 1. WinGet Scripts
- **Export installed apps:**
   ```cmd
   WinGet Export Apps.bat
   ```
   Outputs a JSON file with all installed apps.

- **Import and install apps:**
   ```cmd
   WinGet Import Apps.bat
   ```
   Reads from the exported JSON file and installs missing apps.

- **Update all apps:**
   ```cmd
   WinGet Update.bat
   ```
   Updates all applications installed via WinGet.

### 2. Media Conversion Scripts
- **Convert media to ISO:**
   ```cmd
   ffmpegToISO.bat
   ```
   Converts supported media formats into ISO files.

- **Convert DVDs to ISO:**
   ```cmd
   DVDtoISO.bat
   ```
   Creates an ISO image from a DVD.

### 3. YouTube Download Scripts
- **Download standard YouTube videos:**
   ```cmd
   Youtube download.bat
   ```

- **Download premium YouTube content:**
   ```cmd
   Youtube download premium.bat
   ```

---

## Scripts Details
### WinGet Export and Import
These scripts rely on WinGet's ability to export and import app lists via JSON files, I just made .bat files because I forget the commands as I don't use this very often.

### FFmpeg Conversion
The `ffmpegToISO.bat` script automates ISO creation from various media formats.
- **Input:** Any media format supported by FFmpeg
- **Output:** ISO image

### YouTube Download
Scripts utilize **yt-dlp**, a robust tool for downloading YouTube content, including premium videos where applicable.

---

## Contributing
Contributions are welcome! Feel free to:
- Submit issues for bugs or feature requests
- Fork the repository and make pull requests

**Steps to Contribute:**
1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature`.
3. Commit your changes: `git commit -m "Add feature"`.
4. Push to the branch: `git push origin feature/your-feature`.
5. Open a pull request.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Author
Joaquin and friends  
https://www.joaquinlab.com/

---

Enjoy automating your workflows with these scripts! 🚀

