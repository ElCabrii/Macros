Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Constants for the API call
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDWININICHANGE = 0x02

# Downloaded image path
$URL = "https://raw.githubusercontent.com/ElCabrii/Macros/main/Screenshot%202025-05-13%20100658.png"
$TARGETDIR = "$env:USERPROFILE\temp"
$imgPath = Join-Path $TARGETDIR "img.png"

# Ensure directory exists
if (!(Test-Path -Path $TARGETDIR)) {
    New-Item -ItemType Directory -Path $TARGETDIR | Out-Null
}

# Download the image
Invoke-WebRequest $URL -OutFile $imgPath

# Set the wallpaper instantly
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $imgPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDWININICHANGE)
