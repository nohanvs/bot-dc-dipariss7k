# Apito para confirmar a versão Nova!
[System.Console]::Beep(800, 1000)

Start-Sleep -Seconds 3

while ($true) {
    # -PresentOnly ignora fantasmas e checa apenas a conexão FÍSICA real
    $usb = Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -match 'VID_1C4F&PID_0084' }

    if (-not $usb) {
        # Prova Real
        Start-Sleep -Seconds 1
        $confirm = Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -match 'VID_1C4F&PID_0084' }
        
        if (-not $confirm) {
            # GATILHO ACIONADO!
            Start-Process calc.exe
            break
        }
    }
    Start-Sleep -Seconds 1
}
