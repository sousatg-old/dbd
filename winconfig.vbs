On Error Resume Next
 
Set WshShell = WScript.CreateObject("WScript.Shell")
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
 
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapter Where NetConnectionStatus=2")
 
For Each objItem in colItems
    Wscript.Echo objItem.NetConnectionID
    cmdString = "netsh interface ip set dns name=""" & objItem.NetConnectionID & """ static 8.8.8.8 primary"
    WshShell.Run cmdString
Next
set WshShell = nothing
