$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$startScript = "$scriptDir\start-jellyfin2hqplayer.ps1"

# Stop old process
Stop-Process -Name "jellyfin2hqplayer-win-x64" -Force -ErrorAction SilentlyContinue

# Remove old scheduled task
Unregister-ScheduledTask `
  -TaskName "Jellyfin2HQPlayer" `
  -Confirm:$false `
  -ErrorAction SilentlyContinue

# Create task action
$taskAction = New-ScheduledTaskAction `
  -Execute "powershell.exe" `
  -Argument "-ExecutionPolicy Bypass -NoProfile -File `"$startScript`""

# Run at Windows startup
$taskTrigger = New-ScheduledTaskTrigger -AtStartup

# Task settings
$taskSettings = New-ScheduledTaskSettingsSet `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -StartWhenAvailable `
  -Compatibility Win8

# Run whether user is logged on or not
$user = "$env:USERDOMAIN\$env:USERNAME"

Write-Host ""
Write-Host "Windows account: $user"
Write-Host ""

$password = Read-Host `
  "Enter Windows password" `
  -AsSecureString

$plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
  [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
)

try {

  Register-ScheduledTask `
    -TaskName "Jellyfin2HQPlayer" `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Settings $taskSettings `
    -Description "Start Jellyfin2HQPlayer on Windows startup" `
    -User $user `
    -Password $plainPassword `
    -RunLevel Highest `
    -ErrorAction Stop

  Write-Host ""
  Write-Host "Jellyfin2HQPlayer startup task created successfully."
}
catch {

  Write-Host ""
  Write-Host "Failed to create Jellyfin2HQPlayer startup task."
  Write-Host ""

  Write-Host "Possible reasons:"
  Write-Host "- Incorrect Windows password"
  Write-Host "- Microsoft Account / Local Account password mismatch"
  Write-Host "- PowerShell is not running as Administrator"
  Write-Host ""

  Write-Host $_.Exception.Message

  exit 1
}