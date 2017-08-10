@echo off
rem Cria usuario client, faz login na conta desse usuario e copia pasta do cygwin.
net user %1 %2 /add
net user %1 %2
psexec.exe -accepteula -u %1 -p %2 \cygwin64\bin\bash.exe --login /bin/ssh-user-config -y -p ""
psexec.exe -accepteula -u %1 -p %2 cmd /c mkdir %cd%\home\SYSTEM
psexec.exe -accepteula -u %1 -p %2 cmd /c mkdir %cd%\home\SYSTEM\.ssh
psexec.exe -accepteula -u %1 -p %2 cmd /c copy /y \cygwin64\home\%1\.ssh\id_rsa %cd%\home\SYSTEM\.ssh
