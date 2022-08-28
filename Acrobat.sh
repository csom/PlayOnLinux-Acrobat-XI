#!/bin/bash

# Date : (2022-08-28)
# Last revision : (2022-08-28)
# Wine version used : cx-6.0
# Distribution used to test : Ubuntu 22.04 LTS
# Author : csoM
# PlayOnLinux : 4.3.4
# Script licence : csoM
# Program licence : Test

# Initialization!
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
   
TITLE="Adobe Acrobat XI"
PREFIX="Adobe"
WINEVERSION="cxx"
ARCH="x86"
   
POL_SetupWindow_Init
POL_SetupWindow_SetID 3067

POL_SetupWindow_message "$(eval_gettext 'Please make sure to have CodeWeavers Wine version 21.2.0 installed in location ".PlayOnLinux/wine/linux-x86/cxx" before you continue with your installation.\n\nThanks!\nBy csoM')" "$TITLE"
   
POL_SetupWindow_presentation "$TITLE" "Adobe" "http://www.adobe.com" "csoM" "$PREFIX"
   
POL_Debug_Init
POL_System_TmpCreate "$PREFIX" 
# ---------------------------------------------------------------------------------------------------------
# Perform some validations!
POL_RequiredVersion 4.3.4 || POL_Debug_Fatal "$TITLE won't work with $APPLICATION_TITLE $VERSION!nPlease update!"
   
#Linux
if [ "$POL_OS" = "Linux" ]; then
    wbinfo -V || POL_Debug_Fatal "Please install winbind before installing $TITLE!"
else
    POL_Debug_Fatal "$(eval_gettext "Only Linux OS is supported! Sorry!")";
    POL_SetupWindow_Close
    exit 1
fi

 
#Validation of 32Bits
if [ ! "$(file $SetupIs | grep 'x86-64')" = "" ]; then
    POL_Debug_Fatal "$(eval_gettext "The 64bits version is not compatible! Sorry!")";
fi
   
# ---------------------------------------------------------------------------------------------------------
# Prepare resources for installation!

# Prepare the Wine Prefix
POL_System_SetArch "$ARCH"  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Download Wine Mono 7.0.0
DOWNLOAD_URL="https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.msi"
cd "$POL_System_TmpDir"
POL_Download "$DOWNLOAD_URL"
DOWNLOAD_FILE="$(basename "$DOWNLOAD_URL")"
SetupMonoIs="$POL_System_TmpDir/$DOWNLOAD_FILE"
https://dl.winehq.org/wine/wine-mono/7.0.0/wine-mono-7.0.0-x86.msi

# Choose installer file
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to install.')" "$TITLE"
SetupIs="$APP_ANSWER"

# Install Dependencies   
POL_Call POL_Install_corefonts
POL_AutoWine "$SetupMonoIs"


# Prepare the Registry with necessary overrides 
cd "$POL_System_TmpDir"
echo -e 'REGEDIT4

[HKEY_CURRENT_USER\Software\Wine]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\MCC-Win64-Shipping.exe]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\MCC-Win64-Shipping.exe\DllOverrides]
"concrt140"="native, builtin"

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\outlook.exe]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\outlook.exe\DllOverrides]
"activeds"="native,builtin"
"riched20"="native"

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\vc_redist.x64.exe]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\vc_redist.x64.exe\DllOverrides]
"msxml2"="builtin, native"
"msxml3"="builtin, native"

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\winemenubuilder.exe]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\winemenubuilder.exe\\Explorer]
"Desktop"="root"

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\winewrapper.exe]

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\winewrapper.exe\DllOverrides]
"crypt32"="builtin"
"rsabase"="builtin"
"rsaenh"="builtin"

[HKEY_CURRENT_USER\Software\Wine\AppDefaults\winewrapper.exe\\Explorer]
"Desktop"="root"

[HKEY_CURRENT_USER\Software\Wine\DllOverrides]
"*msxml6"=-
"*riched20"=-
"*autorun.exe"="native,builtin"
"*ctfmon.exe"="builtin"
"*ddhelp.exe"="builtin"
"*docbox.api"=""
"*findfast.exe"="builtin"
"*ieinfo5.ocx"="builtin"
"*maildoff.exe"="builtin"
"*mdm.exe"="builtin"
"*mosearch.exe"="builtin"
"*msiexec.exe"="builtin"
"*pstores.exe"="builtin"
"*user.exe"="native,builtin"
"amstream"="native, builtin"
"atl"="native, builtin"
"crypt32"="native, builtin"
"d3dxof"="native, builtin"
"dciman32"="native"
"devenum"="native, builtin"
"dplay"="native, builtin"
"dplaysvr.exe"="native, builtin"
"dplayx"="native, builtin"
"dpnaddr"="native, builtin"
"dpnet"="native, builtin"
"dpnhpast"="native, builtin"
"dpnhupnp"="native, builtin"
"dpnlobby"="native, builtin"
"dpnsvr.exe"="native, builtin"
"dpnwsock"="native, builtin"
"dxdiagn"="native, builtin"
"hhctrl.ocx"="native, builtin"
"hlink"="native, builtin"
"iernonce"="native, builtin"
"itss"="native, builtin"
"jscript"="native, builtin"
"mlang"="native, builtin"
"mshtml"="native, builtin"
"msi"="builtin"
"msvcirt"="native, builtin"
"msvcrt40"="native, builtin"
"msvcrtd"="native, builtin"
"msxml6"="native, builtin"
"odbc32"="native, builtin"
"odbccp32"="native, builtin"
"ole32"="builtin"
"oleaut32"="builtin"
"olepro32"="builtin"
"quartz"="native, builtin"
"riched20"="native,builtin"
"riched32"="native, builtin"
"rpcrt4"="builtin"
"rsabase"="native, builtin"
"secur32"="native, builtin"
"shdoclc"="native, builtin"
"shdocvw"="native, builtin"
"softpub"="native, builtin"
"urlmon"="native, builtin"
"wininet"="builtin"
"wintrust"="native, builtin"
"wscript.exe"="native, builtin"

[HKEY_CURRENT_USER\Software\Wine\Fonts\Replacements]
"Arial"="FreeSans"
"Lucida Console"="FreeSerif"
"Segoe UI"="Tahoma"

[HKEY_CURRENT_USER\Software\Wine\X11 Driver]
"ScreenDepth"="32"' > winesetup.reg

POL_Wine regedit winesetup.reg
   
# ---------------------------------------------------------------------------------------------------------
# Install!
if [[ "$SetupIs" = *"exe"* ]]
then
	POL_Wine "$SetupIs"

	# ---------------------------------------------------------------------------------------------------------
	# Create shortcuts, entries to extensions and finalize!
	   
	# NOTE: Create shortcuts! 
	POL_Shortcut "Acrobat.exe" "Adobe Acrobat" "" "" "Office;WordProcessor;"

	
	POL_SetupWindow_message "$(eval_gettext '$TITLE has been installed successfully!\n\nThanks!\nBy csoM')" "$TITLE"
	
fi

# Delete the temporary files and exit
POL_System_TmpDelete
POL_SetupWindow_Close
   

exit 0
