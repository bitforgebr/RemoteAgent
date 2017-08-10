!define PRODUCT_NAME "RemoteAgent"
!define /date MYTIMESTAMP "%Y%m%d-%H%M"
!define PRODUCT_VERSION "1.${MYTIMESTAMP}"
!define PRODUCT_PUBLISHER "BitForge"

!include "x64.nsh"

SetCompressor lzma
SetCompress off

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "..\..\Debug\remoteagent-${PRODUCT_VERSION}.exe"
InstallDir C:\RemoteAgent
InstallDirRegKey HKLM "Software\RemoteAgent\nsis" "Install_Dir"

!include "MUI.nsh"

; MUI Settings
!define MUI_ABOUTWARNING
!define MUI_ICON "RemoteAgentInstaller.ico"

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

UninstPage uninstConfirm
UninstPage instfiles


; Language files 
!insertmacro MUI_LANGUAGE "PortugueseBR"

; MUI End

Section -SETTINGS
	SetOutPath "$INSTDIR"
	SetOverwrite ifnewer
SectionEnd

Section "Cygwin"
    SetOutPath "$TEMP"
	File ..\..\tools\cygwinfiles.exe
    ExecWait "$TEMP\cygwinfiles.exe -y -gm2"
    SetOutPath "$TEMP\cygwinfiles"
    ExecWait "$TEMP\cygwinfiles\setup-x86_64.exe -L . -R  c:\cygwin64 -P openssh -P rsync --no-startmenu --no-shortcuts -q"
SectionEnd

Section "Server"
    ExecWait "\cygwin64\bin\bash.exe --login /bin/ssh-host-config -y -c ntsec -N sshd -u ssh_server -w KLyY0laZDAccwwNmKTu0R9qxRwTuvy"
	ExecWait 'netsh advfirewall firewall add rule name="SSHD" protocol=TCP dir=in localport=22 action=allow'
	ExecWait "net start sshd"

    SetOutPath "$TEMP"
    File UpdateRemoteAgentInstallerFilesClient.bat
    SetOutPath "$INSTDIR"
    ExecWait "$TEMP\UpdateRemoteAgentInstallerFilesClient.bat"
    SetOutPath "$INSTDIR\ssh"
    SetOutPath "$TEMP"
	File GenerateTestClient.bat
    SetOutPath "$INSTDIR\ssh"
	ExecWait "$TEMP\GenerateTestClient.bat $INSTDIR"
    SetOutPath "$INSTDIR\uploads"
	File leiame.txt

    SetOutPath "$INSTDIR"
	File ..\..\tools\psexec.exe
	File ClientLogin.bat
	ExecWait "ClientLogin.bat ssh_client suporte"

    SetOutPath "$INSTDIR"
	File GenerateRemoteAgentClientInstaller.bat
	File RemoteAgentInstallerClient.nsi
	File RemoteAgentInstaller.ico
SectionEnd

Section "NSIS"
    SetOutPath "$TEMP"
	File ..\..\tools\nsis-3.01-setup.exe
	ExecWait nsis-3.01-setup.exe
SectionEnd
