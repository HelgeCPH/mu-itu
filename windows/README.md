# Installing Python and Mu-Editor on Windows


## With `PowerShell.exe`

On a Windows system:

  * start PowerShell
    - click on magnifying glass in the bottom left
    - type in `PowerShell`
    - run the App `Windows PowerShell` by clicking on it
  * copy and paste following command (the entire line!) to the PowerShell window
  ```
  Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/HelgeCPH/mu-itu/master/windows/install_win.ps1'))
  ```
  * Execute the command by pressing return





## With `cmd.exe`

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/HelgeCPH/mu-itu/master/windows/install_win.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```


