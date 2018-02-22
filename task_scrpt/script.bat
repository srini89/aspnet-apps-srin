rem This batch script invokes powershell script script.ps1

rem #################################################################################
set scriptFileName=script
set scriptFolderPath=%~dp0
set powershellScriptFileName=%scriptFileName%.ps1
set localdrive=X
set share=\\Imgnas1\vol1\HOMEDIRS\BarrySmith\2017-11-07\
set giturl=https://github.com/git-for-windows/git/releases/download/v2.16.1.windows.4/Git-2.16.1.4-64-bit.exe
set noteplusurl=https://notepad-plus-plus.org/repository/7.x/7.5.4/npp.7.5.4.Installer.x64.exe
set cloneUrl=https://github.com/srini89/MVC.git
set gitpath=C:\Temp\GitTemp
rem #################################################################################

powershell -Command "Start-Process powershell \"-ExecutionPolicy Bypass -NoProfile -NoExit -Command `\"cd \`\"%scriptFolderPath%`\"; & \`\".\%powershellScriptFileName%\`\" %localdrive% %share% %giturl% %noteplusurl% %cloneUrl% %gitpath% > %scriptFolderPath%output.log`\"\" -Verb RunAs"

TIMEOUT /T 1

type %scriptFolderPath%output.log