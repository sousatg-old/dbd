On Error Resume Next

' run as admin
If Not WScript.Arguments.Named.Exists("elevate") Then
	CreateObject("Shell.Application").ShellExecute WScript.FullName, """" & WScript.ScriptFullName & """" & " /elevate", "", "runas", 1
	'Set objShell = CreateObject("Shell.Application")
	'objShell.ShellExecute WScript.FullName, """" & WScript.ScriptFullName & """", "", "runas", 1
	WScript.Quit
End If
 
Set WshShell = WScript.CreateObject("WScript.Shell")
strComputer = "."
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapter Where NetConnectionStatus=2")

' for each active connection 
For Each objItem in colItems
    Wscript.Echo objItem.NetConnectionID
	
	' set primary dns
    cmdString = "netsh interface ip set dns name=""" & objItem.NetConnectionID & """ static 8.8.8.8 index=1"
    WshShell.Run cmdString
	
	' set secondary dns
    cmdString = "netsh interface ip add dns name=""" & objItem.NetConnectionID & """ static 8.8.4.4 index=2"
    WshShell.Run cmdString
Next
set WshShell = nothing
