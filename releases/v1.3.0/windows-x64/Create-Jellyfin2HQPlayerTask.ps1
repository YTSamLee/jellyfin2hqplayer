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
  -Argument "-ExecutionPolicy Bypass -File `"$startScript`""

# Run at startup
$taskTrigger = New-ScheduledTaskTrigger -AtStartup

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
    -Description "Start Jellyfin2HQPlayer on Windows startup" `
    -RunLevel Highest `
    -Force

  Write-Host ""
  Write-Host "Jellyfin2HQPlayer startup task created successfully."
}
catch {
  Write-Host ""
  Write-Host "Failed to create task:"
  Write-Host $_.Exception.Message
}