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

# Run at user logon
$taskTrigger = New-ScheduledTaskTrigger -AtLogOn -User "$env:USERDOMAIN\$env:USERNAME"

# Task settings
$taskSettings = New-ScheduledTaskSettingsSet `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -StartWhenAvailable `
  -Compatibility Win8

try {
  Register-ScheduledTask `
    -TaskName "Jellyfin2HQPlayer" `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Settings $taskSettings `
    -Description "Start Jellyfin2HQPlayer after user logon" `
    -RunLevel Highest `
    -Force

  Write-Host ""
  Write-Host "Jellyfin2HQPlayer logon startup task created successfully."
}
catch {
  Write-Host ""
  Write-Host "Failed to create task:"
  Write-Host $_.Exception.Message
}