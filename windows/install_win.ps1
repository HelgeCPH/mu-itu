# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$pythonURL = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe'
$pythonTMPDest = "$env:TEMP\python-3.7.3-amd64.exe"
Invoke-WebRequest $pythonURL -OutFile $pythonTMPDest

# Install Python for this user only without tests and without test suite
Invoke-Expression "$pythonTMPDest /quiet InstallAllUsers=0 PrependPath=1 Include_test=0"
Write-Output "$env:PATH"
Write-Output "$pythonTMPDest"
Invoke-Expression "$env:LOCALAPPDATA\Programs\Python\Python37\Scripts\pip.exe install mu-editor"
Invoke-Expression "$env:LOCALAPPDATA\Programs\Python\Python37\Scripts\pip.exe install shortcut"
Invoke-Expression "shortcut mu-editor"
