!define PRODUCT_NAME "RemoteAgentClient"
!define /date MYTIMESTAMP "%Y%m%d-%H%M"
!define PRODUCT_VERSION "1.${MYTIMESTAMP}"
!define PRODUCT_PUBLISHER "BitForge"

!include "x64.nsh"

SetCompressor lzma
SetCompress off

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "rsyncfiles-client-${PRODUCT_VERSION}.exe"
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

Section "Client"
    SetOutPath "$INSTDIR\home"
	File /r home\*.*

    SetOutPath "$INSTDIR\ssh"
	File ssh\*.*

    SetOutPath "$INSTDIR"
	WriteUninstaller "uninstall.exe"
SectionEnd

Section "Uninstall"
    RMDir /r $INSTDIR
SectionEnd
