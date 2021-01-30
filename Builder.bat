color 0A
setlocal
set workdir=%~dp0
PATH=%PATH%;%workdir%;%USERPROFILE%\.platformio\penv\Scripts;
echo off
set PYTHONHOME=%USERPROFILE%\Python
set PYTHONPATH=%USERPROFILE%\Python
@chcp 1251>nul
mode con: cols=88 lines=40
cls

:m1
Echo  #------------------------------------------#-----------------------------------------# 
Echo  *                  Commands                *  (Russian)      �������                 * 
Echo  #------------------------------------------#-----------------------------------------# 
Echo  *             Install tools                *     ��������� ������������ � �����      * 
Echo  *  Install Python          (step 1) - (0)  *  ���������� Python             (��� 1)  * 
Echo  *  Install Platformio Core (step 2) - (1)  *  ���������� PIO Core           (��� 2)  * 
Echo  *  Install Git for Windows (step 3) - (2)  *  ���������� Git                (��� 3)  * 
Echo  #------------------------------------------#-----------------------------------------# 
Echo  *        Build and upload firmware         *  ������ � �������� ��������             * 
Echo  *  Update DEV branch from GitHub    - (3)  *  �������� �������� ��� �������� � Git   * 
Echo  *                                          *                                         * 
Echo  *  Build - Esp8266@160              - (4)  *  ������� ��� Esp8266 �� 160���          * 
Echo  *  Build - Esp8266@80               - (5)  *  ������� ��� Esp8266 �� 80���           * 
Echo  *  Build - Esp32                    - (6)  *  ������� ��� Esp32                      * 
Echo  *                                          *                                         * 
Echo  *  Build and upload - Esp8266@160   - (7)  *  ������� � ������� - Esp8266 �� 160���  * 
Echo  *  Build and upload - Esp8266@80    - (8)  *  ������� � ������� - Esp8266 �� 80���   * 
Echo  *  Build and upload - Esp32         - (9)  *  ������� � ������� - Esp32              * 
Echo  *                                          *                                         * 
Echo  *  Update FS data from framework    - (u)  *  �������� ����� �� �� ����������        * 
Echo  *  Build File System (FS)           - (b)  *  ������� ��                             * 
Echo  *  Build and upload File System (FS)- (f)  *  ������� � ������� ��                   * 
Echo  *                                          *                                         * 
Echo  *  Erase Flash                      - (e)  *  ������� ���� �����������               * 
Echo  *                                          *                                         * 
Echo  *  Clean TMP files                  - (c)  *  �������� ��������� �����               * 
Echo  *  Update libs and PIO Core         - (g)  *  �������� ���������� � ����� PIO Core   * 
Echo  *------------------------------------------#-----------------------------------------* 
Echo  *  CMD window                       - (m)  *  ������� ���� ���������� ������ CMD     * 
Echo  *------------------------------------------#-----------------------------------------* 
Echo  *  Remove Platformio installation   - (R)  *  ��������� ������� Platformio � ��      * 
Echo  #------------------------------------------#-----------------------------------------#
Echo.
Set /p choice="Your choice (��� �����): "

if not defined choice (
	echo.
	Echo Wrong command!
	goto m1
)

if "%choice%"=="0" (
	if not exist "%systemdrive%\Program Files (x86)" (
		%workdir%\resources\wget https://www.python.org/ftp/python/3.8.7/python-3.8.7.exe -O "%TMP%\python.exe"
	) else (
		%workdir%\resources\wget https://www.python.org/ftp/python/3.8.7/python-3.8.7-amd64.exe -O "%TMP%\python.exe"
	)
	start %TMP%\python.exe /passive InstallAllUsers=0 PrependPath=1 Include_pip=1 Include_launcher=1 AssociateFiles=1 TargetDir=%USERPROFILE%\Python
)

if "%choice%"=="1" (
	%workdir%\resources\wget https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py -O %workdir%\get-platformio.py
	python %workdir%\get-platformio.py
	del %workdir%\get-platformio.py
)
if "%choice%"=="2" (
	if not exist "%systemdrive%\Program Files (x86)" (
		%workdir%\resources\wget https://github.com/git-for-windows/git/releases/download/v2.30.0.windows.2/Git-2.30.0.2-32-bit.exe -O %TMP%\git.exe
	) else (
		%workdir%\resources\wget https://github.com/git-for-windows/git/releases/download/v2.30.0.windows.2/Git-2.30.0.2-64-bit.exe -O %TMP%\git.exe
	)
	%TMP%\git.exe /SILENT
	del %TMP%\git.exe
)

if "%choice%"=="3" (start update-DEV-from-Git.cmd)
if "%choice%"=="4" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --environment esp8266@160)
if "%choice%"=="5" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --environment esp8266)
if "%choice%"=="6" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --environment esp32)
if "%choice%"=="7" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target upload --environment esp8266@160)
if "%choice%"=="8" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target upload --environment esp8266)
if "%choice%"=="9" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target upload --environment esp32)
if "%choice%"=="u" (
	cd %workdir%\resources\
	start respack.cmd
	cd %workdir%
)
if "%choice%"=="b" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target buildfs --environment esp8266@160dev)
if "%choice%"=="f" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target uploadfs --environment esp8266@160)
if "%choice%"=="e" (%USERPROFILE%\.platformio\penv\Scripts\pio.exe run --target erase --environment esp8266@160)
if "%choice%"=="c" (
	pio system prune -f
	rmdir /S /Q %workdir%\.pio
)
if "%choice%"=="g" (
	%USERPROFILE%\.platformio\penv\Scripts\pio.exe upgrade
	%USERPROFILE%\.platformio\penv\Scripts\pio.exe update
)
if "%choice%"=="m" (start cmd)
if "%choice%"=="R" (rmdir /S %USERPROFILE%\.platformio)

Echo.
Echo.
Echo.
pause
del %workdir%\resources\.wget-hsts
cls
goto m1


exit