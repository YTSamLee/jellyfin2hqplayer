$TaskName = "Jellyfin2HQPlayer"
$ProcessName = "jellyfin2hqplayer-win-x64"

Write-Host "Uninstalling Jellyfin2HQPlayer..."

# 1. 停止计划任务
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Stop-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Host "Scheduled task removed."
} else {
    Write-Host "Scheduled task not found."
}

# 2. 结束运行中的进程
$procs = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
if ($procs) {
    Write-Host "Stopping running Jellyfin2HQPlayer process..."
    $procs | Stop-Process -Force
    Write-Host "Process stopped."
} else {
    Write-Host "No running process found."
}

Write-Host ""
Write-Host "Jellyfin2HQPlayer has been uninstalled."
Write-Host "You may manually delete the application folder if needed."