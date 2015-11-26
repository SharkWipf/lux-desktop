# lux.nsi
# Used to compile the installer
# the installer downloads the cygwin setup program
# to perform package installation

# use modern gui
!include MUI2.nsh
# do not request admin privs
RequestExecutionLevel user

# name
Name "lux installer"
# output file
SetCompressor lzma
OutFile "lux-install.exe"
# default install directory
InstallDir C:\lux-x86_64
# installer icon
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
# use directory select page, and install page
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

# do the actual setup
Section ""
 Call DoSetup
SectionEnd

Function DoSetup
  # download directory
  StrCpy $2 "$INSTDIR\var\cache\lux"
  CreateDirectory $2
  # executable filename (downloaded)
  StrCpy $0 "$2\setup-x86_64.exe"
  # download cygwin setup executable
  NSISdl::download "https://cygwin.com/setup-x86_64.exe" $0
  # check for successful download
  Pop $1
  StrCmp $1 success success
    # download failed
    SetDetailsView show
    DetailPrint "download failed: $0"
    Abort
  success:
    # download success, execute cygwin setup with parameters (mirrors,
    # lux-desktop package, download & install locations, etc.)
    ExecWait '"$0" -v -g -B -q -l "$2\cache" -P lux-desktop -R "$INSTDIR" \
    -s http://sirius.starlig.ht \
    -s http://cygwin.mirror.constant.com \
    -s http://sourceware.mirrors.tds.net/pub/sourceware.org/cygwinports \
    -K http://sirius.starlig.ht/sirius.gpg \
    -K http://cygwinports.org/ports.gpg'

    # create windows shortcuts on desktop & in start menu
    CreateDirectory "$STARTMENU\Programs\lux"
    SetOutPath "$INSTDIR\bin"
    StrCpy $4 "$INSTDIR\bin\run.exe"
    StrCpy $5 '--quote /bin/bash.exe -l -c "cd; /bin/startx /etc/X11/xinit/Xsession xfce"'
    CreateShortCut "$DESKTOP\lux.lnk" "$4" '$5' "$INSTDIR\bin\Xwin.exe" 0 
    CreateShortCut "$STARTMENU\Programs\lux\lux.lnk" "$4" '$5' "$INSTDIR\bin\XWin.exe" 0 
FunctionEnd

