@echo off

%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin

timeout /t 5
echo auto Restarting hMailServer-Service

:stop
sc stop hMailServer

timeout /t 2

:start
sc start hMailServer

echo ~~~Finished~~~
pause