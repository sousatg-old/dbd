Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "netsh interface ip set dns name=""Local Area Connection"" static 8.8.8.8 primary"
set WshShell = nothing
