@echo off
echo @echo off > TestClient.bat
echo rem Testa envio de arquivos remotos via rsync. >> TestClient.bat
echo rem Substituir user, ip, SourcePath e DestinyPath. >> TestClient.bat
echo rsync -v -a -e "./ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" /cygdrive/c/RemoteAgent/ssh/TestClient.bat ssh_client@%computername%:/cygdrive/c/RemoteAgent/uploads/%%computername%%/ >> TestClient.bat
