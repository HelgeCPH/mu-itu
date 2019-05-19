# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$pythonURL = 'https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe'
$pythonTMPDest = "$env:TEMP\python-3.7.3-amd64.exe"
Invoke-WebRequest $pythonURL -OutFile $pythonTMPDest

# Install Python for this user only without tests and without test suite
"$pythonTMPDest /quiet InstallAllUsers=0 PrependPath=1 Include_test=0"
Write-Output "$env:PATH"

pip install mu-editor
pip install shortcut
shortcut mu-editor