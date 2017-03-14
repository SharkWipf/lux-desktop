Set WSHShell = WScript.CreateObject("WScript.Shell")

WshShell.AppActivate("Program Manager")
WshShell.SendKeys "^{ESC}"

Set WSHShell = Nothing
