wsl.exe --shutdown && net stop WslService && net stop LxssManager
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

$wslOutput = wsl.exe -l -v
$distroInfoLine = $wslOutput -split "`r`n" | Select-Object -Skip 2
$distroInfo = $distroInfoLine -split '\s+' | Where-Object { $_ -ne '' }
$distroName = $distroInfo[1]
$distroVersion = $distroInfo[-1]

wsl.exe --update

if ($distroVersion -eq "1") {
    wsl.exe --set-version $distroName 2
}
