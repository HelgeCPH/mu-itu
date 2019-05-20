# Installation of Python and Mu-Editor inspired on the installation of
# Chocolatey, see https://chocolatey.org/install

# On a Windows system, start PowerShell and run the following command:
# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/HelgeCPH/mu-itu/master/windows/install_win.ps1'))
Write-Output "Downloading Python..."
$pythonURL = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe'
$pythonTMPDest = "$env:TEMP\python-3.7.3-amd64.exe"
Invoke-WebRequest $pythonURL -OutFile $pythonTMPDest
$targetDir = "$env:LOCALAPPDATA\Programs\ITUSummer"

Write-Output "Installing Python..."
# Installation based on:
# https://docs.python.org/3/using/windows.html#installing-without-ui
# Install Python for this user only without tests and without test suite
Invoke-Expression "$pythonTMPDest /quiet InstallAllUsers=0 PrependPath=1 DefaultJustForMeTargetDir='$targetDir' Include_test=0 SimpleInstall=1 SimpleInstallDescription='Just for me, no test suite.'"
#Write-Output "$env:PATH"
#Write-Output "$pythonTMPDest"
Write-Output "Downloading Mu-Editor..."
Invoke-Expression "$env:LOCALAPPDATA\Programs\Python\Python37\Scripts\pip.exe install mu-editor"
Invoke-Expression "$env:LOCALAPPDATA\Programs\Python\Python37\Scripts\pip.exe install shortcut"
Invoke-Expression "shortcut mu-editor"
Write-Output "Done..."