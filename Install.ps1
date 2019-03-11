Write-Host 'Online Media Butler'
Write-Host 'By Alfred Osorio 2019'
Write-Host

# Suppress all error messages
$ErrorActionPreference = "SilentlyContinue"

# Allow PowerShell Execution
Set-ExecutionPolicy RemoteSigned

Write-Host "Setting environment variables and creating shortcut . . ."

# Set ffmpeg environment variables
$path = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", $path + ";$((Get-Item -Path '.\').FullName)\ffmpeg\bin", "User")

$path = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", $path + ";$((Get-Item -Path '.\').FullName)", "User")

# Build shortcut object
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$((Get-Item -Path '.\').FullName)\Online Media Butler.lnk")
$startPath = $(Get-Item -Path '.\').FullName
$psPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$ytPath = '-ExecutionPolicy Bypass -File' + " " + """$((Get-Item -Path '.\').FullName)\resources\YouTube-DL Helper.ps1"""
$Shortcut.TargetPath = $psPath
$Shortcut.WorkingDirectory = $startPath
$Shortcut.Arguments = $ytPath
$Shortcut.IconLocation = "$((Get-Item -Path '.\').FullName)\resources\icon.ico"
$Shortcut.Save()



# Add Custom Icon
# Add Regex for matching URLs in Helper PS1 File
# Add option to manually select download location