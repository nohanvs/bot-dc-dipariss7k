# 1. Toca um som médio para avisar: "O Script começou e estou vigiando!"
[System.Console]::Beep(1000, 500)

# Espera 3 segundos para estabilizar
Start-Sleep -Seconds 3

# Loop Vigilante (O segredo novo é o ConfigManagerErrorCode)
while ($true) {
    # Busca o Digispark (16D0). 
    # ConfigManagerErrorCode -eq 0 significa que ele ignora "fantasmas" e exige que o USB esteja 100% ativo.
    $usb = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '16D0' -and $_.ConfigManagerErrorCode -eq 0 }

    if (-not $usb) {
        # Tirou? Faz a prova real (espera 1 segundo)
        Start-Sleep -Seconds 1
        $confirm = Get-WmiObject Win32_PnPEntity | Where-Object { $_.DeviceID -match '16D0' -and $_.ConfigManagerErrorCode -eq 0 }

        if (-not $confirm) {
            # SUCESSO! O USB sumiu de verdade.
            # Toca um alarme agudo 5 vezes rápido!
            for($i=0; $i -lt 5; $i++){
                [System.Console]::Beep(2500, 200)
                Start-Sleep -Milliseconds 100
            }
            break
        }
    }
    Start-Sleep -Seconds 1
}
