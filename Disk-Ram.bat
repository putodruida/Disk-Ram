@echo off

REM .bat con permisos de administrador
:-------------------------------------
REM --> Analizando los permisos
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> Si hay error es que no hay permisos de administrador.
if '%errorlevel%' NEQ '0' (

REM no se muestra --> echo Solicitando permisos de administrador... 

REM no se muestra --> echo Requesting administrative privileges... 

REM no se muestra --> echo Anfordern Administratorrechte ...

goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------

REM Disk and Disk Type installed
powershell Get-PhysicalDisk

@echo.
@echo #######################################################################################################################
@echo.

REM RAM installed
powershell "Get-WmiObject win32_physicalmemory | Format-Table Manufacturer,MemoryType,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize"

@echo.
@echo.
pause
exit