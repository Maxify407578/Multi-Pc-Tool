@echo off
title Multitool - Utilities
:menu
cls
echo ===============================
echo        Willkommen zum Multitool
echo ===============================
echo Wählen Sie eine Option:
echo [1] Systeminformationen anzeigen
echo [2] Netzwerkeinstellungen überprüfen
echo [3] Temporäre Dateien löschen
echo [4] Laufwerke auflisten
echo [5] Aktive Prozesse anzeigen
echo [6] Firewall-Status prüfen
echo [7] Computer herunterfahren oder neu starten
echo [8] Ereignisanzeige öffnen
echo [9] Verzeichnisgröße berechnen
echo [10] Programm starten
echo [11] Speicherdiagnose starten
echo [12] Windows Update Status anzeigen
echo [13] Benutzerkonten anzeigen
echo [14] Lokalen Host (localhost) pingen
echo [15] Umgebungsvariablen anzeigen
echo [16] Angeschlossene Maus anzeigen
echo [17] Angeschlossene Tastatur anzeigen
echo [18] Angeschlossene Monitore anzeigen
echo [19] Beenden
echo ===============================
set /p choice=Bitte geben Sie eine Zahl ein: 

if "%choice%"=="1" goto systeminfo
if "%choice%"=="2" goto networkinfo
if "%choice%"=="3" goto cleantemp
if "%choice%"=="4" goto listdrives
if "%choice%"=="5" goto listprocesses
if "%choice%"=="6" goto firewallstatus
if "%choice%"=="7" goto shutdownrestart
if "%choice%"=="8" goto eventviewer
if "%choice%"=="9" goto dirsize
if "%choice%"=="10" goto openprogram
if "%choice%"=="11" goto memorydiagnostics
if "%choice%"=="12" goto windowsupdate
if "%choice%"=="13" goto useraccounts
if "%choice%"=="14" goto pinglocalhost
if "%choice%"=="15" goto envvariables
if "%choice%"=="16" goto showmouse
if "%choice%"=="17" goto showkeyboard
if "%choice%"=="18" goto showmonitors
if "%choice%"=="19" goto exit
echo Ungültige Eingabe, bitte versuchen Sie es erneut.
pause
goto menu

:systeminfo
cls
echo Systeminformationen:
systeminfo | more
goto back

:networkinfo
cls
echo Netzwerkeinstellungen:
ipconfig /all | more
goto back

:cleantemp
cls
echo Temporäre Dateien werden gelöscht...
del /q /f "%TEMP%\*" >nul 2>&1
echo Temporäre Dateien wurden gelöscht!
goto back

:listdrives
cls
echo Verfügbare Laufwerke:
wmic logicaldisk get name
goto back

:listprocesses
cls
echo Aktive Prozesse:
tasklist | more
goto back

:firewallstatus
cls
echo Firewall-Status:
netsh advfirewall show allprofiles
goto back

:shutdownrestart
cls
echo ===============================
echo Möchten Sie den Computer herunterfahren oder neu starten?
echo [1] Herunterfahren
echo [2] Neu starten
echo [3] Abbrechen
echo ===============================
set /p action=Bitte geben Sie eine Zahl ein: 

if "%action%"=="1" shutdown /s /t 0
if "%action%"=="2" shutdown /r /t 0
if "%action%"=="3" goto menu
goto back

:eventviewer
cls
echo Ereignisanzeige wird geöffnet...
start eventvwr.msc
goto back

:dirsize
cls
set /p dir=Geben Sie den Pfad des Verzeichnisses ein: 
echo Die Größe des Verzeichnisses wird berechnet...
for /f "usebackq tokens=*" %%a in (`dir "%dir%" /s /a /-c ^| find "Bytes"`) do echo %%a
goto back

:openprogram
cls
echo ===============================
echo Programme starten:
echo Geben Sie den vollständigen Pfad zur Programmdatei ein (z. B. C:\Windows\notepad.exe).
echo Alternativ geben Sie den Programmnamen ein, falls er im Systempfad ist (z. B. notepad).
echo ===============================
set /p program=Pfad oder Name des Programms: 
start "" "%program%"
if errorlevel 1 echo Fehler beim Starten des Programms.
goto back

:memorydiagnostics
cls
echo Speicherdiagnose wird gestartet...
mdsched.exe
goto back

:windowsupdate
cls
echo Windows Update Status:
wmic qfe list | more
goto back

:useraccounts
cls
echo Lokale Benutzerkonten:
net user
goto back

:pinglocalhost
cls
echo Lokalen Host (localhost) wird gepingt...
ping 127.0.0.1
goto back

:envvariables
cls
echo Umgebungsvariablen:
set
goto back

:showmouse
cls
echo Angeschlossene Mäuse:
wmic path Win32_PointingDevice get Name,Description
goto back

:showkeyboard
cls
echo Angeschlossene Tastaturen:
wmic path Win32_Keyboard get Name,Description
goto back

:showmonitors
cls
echo Angeschlossene Monitore:
wmic path Win32_DesktopMonitor get Name,Status
goto back

:back
pause
goto menu

:exit
cls
echo Vielen Dank, dass Sie das Multitool verwendet haben!
pause
exit
