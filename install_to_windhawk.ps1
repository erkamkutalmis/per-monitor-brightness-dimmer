# Installs local@per-monitor-brightness (with Reduce White Point & Contrast icon fix)
# into Windhawk, copies existing settings, and hot-reloads it.

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSCommandPath
$srcCpp = Join-Path $root "per-monitor-brightness\per-monitor-brightness.wh.cpp"
$srcDll = Join-Path $root "build\local@per-monitor-brightness.dll"

if (-not (Test-Path $srcCpp) -or -not (Test-Path $srcDll)) {
    throw "Missing build artifacts: $srcCpp or $srcDll"
}

$stamp = Get-Date -Format "9HHmmss"
$dllName = "local@per-monitor-brightness_3.0_$stamp.dll"
$dstCpp = "C:\ProgramData\Windhawk\ModsSource\local@per-monitor-brightness.wh.cpp"
$dstDll = "C:\ProgramData\Windhawk\Engine\Mods\64\$dllName"

Copy-Item -Force $srcCpp $dstCpp
Copy-Item -Force $srcDll $dstDll

$oldReg = "HKLM:\SOFTWARE\Windhawk\Engine\Mods\per-monitor-brightness"
$newReg = "HKLM:\SOFTWARE\Windhawk\Engine\Mods\local@per-monitor-brightness"
$epoch = [int][double]::Parse((Get-Date -UFormat %s))

# Disable original mod to avoid double injection
if (Test-Path $oldReg) {
    Set-ItemProperty -Path $oldReg -Name "Disabled" -Value 1 -Type DWord
}

# Register & enable local mod
if (-not (Test-Path $newReg)) {
    New-Item -Path $newReg -Force | Out-Null
}
Set-ItemProperty -Path $newReg -Name "LibraryFileName" -Value $dllName -Type String
Set-ItemProperty -Path $newReg -Name "Disabled" -Value 0 -Type DWord
Set-ItemProperty -Path $newReg -Name "Include" -Value "ShellHost.exe" -Type String
Set-ItemProperty -Path $newReg -Name "Exclude" -Value "" -Type String
Set-ItemProperty -Path $newReg -Name "Architecture" -Value "x86-64" -Type String
Set-ItemProperty -Path $newReg -Name "Version" -Value "3.0" -Type String

# Copy existing Settings from per-monitor-brightness so all sliders/toggles stay intact
$oldSettings = "$oldReg\Settings"
$newSettings = "$newReg\Settings"
if (Test-Path $oldSettings) {
    Copy-Item -Path $oldSettings -Destination $newReg -Recurse -Force
} elseif (-not (Test-Path $newSettings)) {
    New-Item -Path $newSettings -Force | Out-Null
    Set-ItemProperty -Path $newSettings -Name "hideStockBrightness" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showPerMonitor" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showMasterBrightness" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showContrast" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showMasterContrast" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showPowerButton" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showVolume" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "showInputSwitcher" -Value 1 -Type DWord
    Set-ItemProperty -Path $newSettings -Name "scrollStep" -Value 5 -Type DWord
}

# Ensure Reduce White Point settings are initialized
Set-ItemProperty -Path $newSettings -Name "whitePointOnIconClick" -Value 1 -Type DWord
Set-ItemProperty -Path $newSettings -Name "whitePointReducePercent" -Value 70 -Type DWord
Set-ItemProperty -Path $newSettings -Name "whitePointMethod" -Value "auto" -Type String

# Trigger Windhawk hot-reload
Set-ItemProperty -Path $newReg -Name "SettingsChangeTime" -Value $epoch -Type DWord

Write-Host "Installed and enabled $dllName with settings!" -ForegroundColor Green
Write-Host "Press any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
