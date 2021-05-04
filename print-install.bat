@echo off
set ip=10.2.1.248
set printername="Ricoh IM C2000 PCL6"
rem 設定印表機IP和使用者會看到的印表機名稱

set _os=
for /f "usebackq skip=1 tokens=3" %%i in (`wmic os get caption ^| findstr /r /v "^$"`) do (
  set "_os=%%i"
  )

if /i "%_os%" == "10" (
goto :Win10
) else (
goto :Other
)

rem Wmic OS Get Caption|Find /i "Windows 10">nul&&echo WIN 10&&goto win10    #Single Version Use

:Other
echo "Not Windows 10"

:Win10
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" goto x64
if "%PROCESSOR_ARCHITECTURE%" == "x86" goto x86
rem 判斷系統是32還64位元

:x86
set drv="%~dp0\IM C2000\disk1\oemsetup.inf"
set drvname="RICOH IM C2000 PCL 6"
rem 設定要安裝的印表機驅動inf檔和inf檔裡的印表機名稱
%windir%\system32\cscript.exe %windir%\system32\Printing_Admin_Scripts\zh-TW\prnport.vbs -a -r %ip% -h %ip% -o lpr -q LP1 > NUL
rem 建立名稱LP1的LPR連接埠
goto last

:x64
set drv="%~dp0\IM C2000\disk1\oemsetup.inf"
set drvname="RICOH IM C2000 PCL 6"
rem 設定要安裝的印表機驅動inf檔和inf檔裡的印表機名稱
%windir%\SysWOW64\cscript.exe %windir%\SysWOW64\Printing_Admin_Scripts\zh-TW\prnport.vbs -a -r %ip% -h %ip% -o lpr -q LP1 > NUL
rem 建立名稱LP1的LPR連接埠
goto last

:last
rundll32 printui.dll,PrintUIEntry /if /b %printername% /f %drv% /r %ip% /m %drvname%
rem 建立印表機裝置
