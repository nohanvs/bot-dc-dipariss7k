# Apito longo de 1 segundo para você SABER que a versão nova baixou
[System.Console]::Beep(800, 1000)

Start-Sleep -Seconds 3

# Usando um comando mais moderno e agressivo (Get-PnpDevice)
while ($true) {
    # Ele procura especificamente nos teclados e exige que o Status esteja 'OK'
    $usb = Get-PnpDevice -Class Keyboard -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -match '1C4F' -and $_.Status -eq 'OK' }

    if (-not $usb) {
        # Sumiu ou o status mudou pra Erro? Confirma rápido.
        Start-Sleep -Seconds 1
        $confirm = Get-PnpDevice -Class Keyboard -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -match '1C4F' -and $_.Status -eq 'OK' }
        
        if (-not $confirm) {
            # GATILHO ACIONADO! Abre a Calculadora
            Start-Process calc.exe
            break
        }
    }
    Start-Sleep -Seconds 1
}
