' VIRTUAL TRUCKER RICH PRESENCE 2.84
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set shell = CreateObject("Wscript.Shell")
shell.CurrentDirectory = scriptdir
shell.Run """" & scriptdir & "\TangoTransportTrackerRichPresence.exe" & " ""--clientConfiguration=""" & scriptdir & "\clientconfiguration.json""", 0, False