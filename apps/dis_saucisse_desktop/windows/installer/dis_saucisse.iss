; Installateur Windows de Dis Saucisse ! (Inno Setup 6).
; Compilé par .github/workflows/desktop-windows.yml :
;   iscc /DAppVersion=0.1.0 /DSourceDir=<dossier Release> dis_saucisse.iss

#ifndef AppVersion
  #define AppVersion "0.1.0"
#endif
#ifndef SourceDir
  #define SourceDir "..\..\build\windows\x64\runner\Release"
#endif

#define AppName "Dis Saucisse !"
#define AppExe "dis_saucisse_desktop.exe"

[Setup]
AppId={{6E5B0E7C-3D1F-4C42-9A7E-5D1C8B2F7A10}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher=Hugues Leger
DefaultDirName={autopf}\Dis Saucisse
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SetupIconFile=..\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\{#AppExe}
OutputBaseFilename=DisSaucisse-Setup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "Créer un raccourci sur le Bureau"; GroupDescription: "Raccourcis :"
Name: "startup"; Description: "Lancer Dis Saucisse ! au démarrage de Windows (pour recevoir les photos sans y penser)"; GroupDescription: "Démarrage :"

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\Désinstaller {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon
Name: "{userstartup}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: startup

[Run]
; Le téléphone envoie les photos par le Wi-Fi de la maison : on autorise l'app sur les réseaux privés,
; pour éviter la fenêtre du pare-feu au premier lancement.
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Dis Saucisse"" dir=in action=allow program=""{app}\{#AppExe}"" enable=yes profile=private"; Flags: runhidden
Filename: "{app}\{#AppExe}"; Description: "Lancer {#AppName}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Dis Saucisse"""; Flags: runhidden; RunOnceId: "RemoveFirewallRule"
