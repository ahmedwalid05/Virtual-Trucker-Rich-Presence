
#pragma include __INCLUDE__ + ";" + "C:\Program Files (x86)\Inno Download Plugin"
#include <idp.iss>

#define MyAppName "Tango Transport Tracker Rich Presence"
#define MyAppVersion "2.8.5.1"
#define MyAppPublisher "Tango Transport Tracker Rich Presence"
#define MyAppURL "https://vtrpc.live"
#define MyAppExeName "TangoTransportTrackerRichPresence.exe"
#define MyServiceName "TangoTransportTrackerRichPresence"
#define RunHiddenVbs "RunHidden.vbs"
#define RebootVTRPC "RebootVTRPC.bat"

[Setup]
AppId={{9cab465e-eec3-4a65-b284-9f05c3781250}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppMutex={#MyAppExeName}
DefaultDirName={pf64}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=no                                                                                                           
OutputBaseFilename=TangoTransportTrackerRichPresenceSetup
SetupIconFile=..\assets\vtrpc.ico
Compression=lzma2/ultra64
SolidCompression=yes
PrivilegesRequired=admin
DirExistsWarning=no
Uninstallable=yes
InfoBeforeFile=Readme.txt
AllowCancelDuringInstall=no
ShowLanguageDialog=no
UsePreviousGroup=False
ArchitecturesInstallIn64BitMode=x64 ia64
ArchitecturesAllowed=x64 ia64
InternalCompressLevel=ultra64
CompressionThreads=4
WizardImageStretch=False
WizardImageFile=..\assets\vtrpc-banner.bmp
WizardSmallImageFile=..\assets\vtrpc.bmp
DisableWelcomePage=False

[Types]
Name: full; Description: "Full installation";
Name: update; Description: "Update installation"; Flags: iscustom

[Components]
Name: app; Description: "Tango Transport Tracker Rich Presence v{#MyAppVersion}"; Types: full update; Flags: fixed disablenouninstallwarning
Name: etcars; Description: "ETCARS 0.15.386 (Required)"; Types: full; Flags: disablenouninstallwarning

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[InstallDelete]
Type: filesandordirs; Name: "{pf64}\{#MyAppName}"
Type: filesandordirs; Name: "{pf}\{#MyAppName}"

[Files]
Source: "..\release\TangoTransportTrackerRichPresence.exe"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\vbs\RunHidden.vbs"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\bat\RebootVTRPC.bat"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\node_modules\node-notifier\vendor\snoreToast\snoretoast-x64.exe"; DestDir: "{app}\vendor\SnoreToast\"; Flags: ignoreversion;
Source: "..\node_modules\node-notifier\vendor\notifu\notifu64.exe"; DestDir: "{app}\vendor\notifu\"; Flags: ignoreversion;
Source: "..\assets\vtrpc.ico"; DestDir: "{app}\assets"; Flags: ignoreversion;  
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonstartup}\{#MyAppName}"; Filename: "{sys}\cscript.exe"; Parameters: """{app}\{#RunHiddenVbs}"""; Tasks:StartMenuEntry;
Name: "{group}\Reboot VTRPC"; Filename: "{app}\{#RebootVTRPC}";
Name: "{group}\Uninstall VTRPC"; Filename: "{uninstallexe}";

[Tasks]
Name: "StartMenuEntry" ; Description: "Start {#MyAppName} when Windows starts (Recommended)" ; GroupDescription: "Windows Startup"; MinVersion: 4,4;
Name: "InstallETCARS"; Description: "Install ETCARS after installation"; GroupDescription: "Other Tasks"; Components: etcars;
Name: "DistanceUnitConfigurationMi"; Description: "Use Miles & MPH for distance/speed units on ETS2"; GroupDescription: "Configuration"; Flags: unchecked 

[Run]
Filename: "{sys}\cscript.exe"; Parameters: """{app}\{#RunHiddenVbs}"""; Description: "Run {#MyAppName} immediately"; Flags: postinstall runhidden;
Filename: "{localappdata}\Temp\ETCARSx64.exe"; Description: "Install ETCARS"; Components: etcars; Tasks: InstallETCARS; Flags: hidewizard

[UninstallRun]
Filename: "{cmd}"; Parameters: "/C ""taskkill /im {#MyAppExeName} /f /t";

[Code]
procedure InitializeWizard;
begin
    idpDownloadAfter(wpReady);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
    if CurPageID = wpReady then
    begin
        // User can navigate to 'Ready to install' page several times, so we 
        // need to clear file list to ensure that only needed files are added.
        idpClearFiles;

        if IsComponentSelected('etcars') then
            idpAddFile('https://etcars.jammerxd.com/downloads/ETCARSx64.exe', ExpandConstant('{localappdata}\Temp\ETCARSx64.exe'));

        idpDownloadAfter(wpReady);
  end;
end;

procedure PerformAfterInstallActions();
  var 
      clientConfFile : string;
  begin    

    clientConfFile := ExpandConstant('{app}\clientconfiguration.json');
  
    Log('PerformAfterInstallActions');

    if FileExists(clientConfFile) then         
    begin
      DeleteFile(clientConfFile);
    end;

    if IsTaskSelected('DistanceUnitConfigurationMi') then
    begin
        SaveStringToFile(clientConfFile, '{ "configuration": { "distanceUnit": "m" } }', True);
    end
    else
    begin
        SaveStringToFile(clientConfFile, '{ "configuration": { "distanceUnit": "km" } }', True);
    end;
  end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if  CurStep=ssPostInstall then
    begin
         PerformAfterInstallActions();
    end
end;
