# Installation of Python and Mu-Editor inspired on the installation of
# Chocolatey, see https://chocolatey.org/install

# On a Windows system, start PowerShell and run the following command:
# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/HelgeCPH/mu-itu/master/windows/install_win.ps1'))
Write-Output "Downloading Python..."
$pythonURL = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe'
$pythonTMPDest = "$env:TEMP\python-3.7.3-amd64.exe"

# I added the following line as older builds of Windows 10 threw SSL/TSL errors
# https://stackoverflow.com/questions/41618766/powershell-invoke-webrequest-fails-with-ssl-tls-secure-channel
[Net.ServicePointManager]::SecurityProtocol = "Tls12, Tls11, Tls, Ssl3"
Invoke-WebRequest $pythonURL -OutFile $pythonTMPDest
$targetDir = "$env:LOCALAPPDATA\Programs\ITUSummer"

Write-Output "Installing Python..."
# Installation based on:
# https://docs.python.org/3/using/windows.html#installing-without-ui
# Install Python for this user only without tests and without test suite
# I do not think that I need this again:
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression "$pythonTMPDest /quiet InstallAllUsers=0 DefaultJustForMeTargetDir=$targetDir PrependPath=1 Include_test=0"

Write-Output "Downloading Mu-Editor..."
Invoke-Expression "$env:LOCALAPPDATA\Programs\ITUSummer\Python37\Scripts\pip.exe install mu-editor"
Invoke-Expression "$env:LOCALAPPDATA\Programs\ITUSummer\Python37\Scripts\pip.exe install shortcut"
Invoke-Expression "shortcut mu-editor"

Write-Output "Replacing art work..."
$iconURL = 'https://github.com/HelgeCPH/mu-itu/raw/master/mu-editor.iconset/icon_256x256.png'
$splashURL = 'https://github.com/HelgeCPH/mu-itu/raw/master/splash-screen.png'
$imageDest = "$env:LOCALAPPDATA\Programs\ITUSummer\Python37\Lib\site-packages\mu\resources\images\"
Invoke-WebRequest $iconURL -OutFile "$imageDest\icon.png"
Invoke-WebRequest $splashURL -OutFile "$imageDest\splash-screen.png"

Write-Output "Done..."
