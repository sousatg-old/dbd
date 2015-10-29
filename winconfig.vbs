On Error Resume Next

' run as admin
If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , WScript.ScriptFullName & " /elevate", "", "runas", 1
  WScript.Quit
End If
 
Set WshShell = WScript.CreateObject("WScript.Shell")
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
 
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapter Where NetConnectionStatus=2")

' for each active connection 
For Each objItem in colItems
    Wscript.Echo objItem.NetConnectionID
    cmdString = "netsh interface ip set dns name=""" & objItem.NetConnectionID & """ static 8.8.8.8 primary"
    WshShell.Run cmdString
Next
set WshShell = nothing
