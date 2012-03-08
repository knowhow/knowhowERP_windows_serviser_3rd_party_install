@echo off
echo ===========================================================================
echo  knowhowERP serviser/developer alati za Windows 32bit platformu 
echo.
echo.
echo.
echo.

set ROOT_GCODE_URL=http://knowhow-erp.googlecode.com/files
rem set ROOT_GCODE_URL=http://localhost:9292/files

set I_VER=2.2.2

set I_DATE=08.03.2012

set KH_UPDATER_VER=2.2.4
set HBOUT_VER=3.1
set MINGW_VER=4.6.1
set MSYS_VER=4.6.1
set QT_VER=4.7.4
set GIT_VER=1.0

set F_CUR_DIR=%CD%
set CUR_DIR=%F_CUR_DIR:~2%
set CUR_DRIVE=%F_CUR_DIR:~0,1%


set MY_DOC_DIR=%USERPROFILE%\My Documents
set DOWNLOAD_DIR=%USERPROFILE%\My Documents\Downloads

set WGET_CMD_1="%F_CUR_DIR%\wget" -nc 

set TAR_CMD="%F_CUR_DIR%\tar" -x -v -f
set GZIP_CMD="%F_CUR_DIR%\gzip" 

set SEVENZ_CMD="%F_CUR_DIR%\7z" x

echo F18 serviser util install ver %I_VER%, %I_DATE%
echo -------------------------------------------------------
echo.
echo Pritisni 'm' za instalaciju MinGW okruzenja
echo          'f' za instalaciju MinGW + mys full okruzenje
echo.
echo Unesi zeljenu opciju + enter:
set /p opcija=

if NOT %CUR_DRIVE% == C goto :c_drive
if %opcija% == M goto :pocetak 
if %opcija% == m goto :pocetak 
if %opcija% == f goto :pocetak 
if %opcija% == F goto :pocetak 
 
goto :nista

:pocetak

echo Opcija = %opcija%

mkdir c:\tmp
mkdir c:\github
mkdir c:\knowhowERP
mkdir c:\knowhowERP\util
mkdir c:\knowhowERP\lib
mkdir c:\knowhowERP\bin
mkdir "%MY_DOC_DIR%"
mkdir "%DOWNLOAD_DIR%"

echo " "
echo "pocetak ...."

:mingw1


echo 1) MinGW = c:/MinGW

del  /Q c:\MinGW

cd "%CUR_DIR%"

set SEVENZ_F_NAME=MinGW_%MINGW_VER%.7z

cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .
echo 7zip extract %SEVENZ_F_NAME%

cd c:\
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"


cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%


echo "Opcija za msys = %opcija%"

if %opcija% == M goto :util 
if %opcija% == m goto :util

goto :msys




:msys


echo 2) MinGW/msys = c:/MinGW/msys


del  /Q c:\MinGW\msys

cd "%CUR_DIR%"

set SEVENZ_F_NAME=MinGW_msys_%MSYS_VER%.7z


cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .


echo 7zip extract %SEVENZ_F_NAME%


cd c:\MinGW
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"


cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%




:util

echo .
echo .
echo ----------------------------------------------
echo kupim util pakete ...





set WGET_F_NAME=knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz

cd "%DOWNLOAD_DIR%"
%WGET_CMD_1% %ROOT_GCODE_URL%/%WGET_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget_0

cd "%CUR_DIR%
cd util
copy /y "%DOWNLOAD_DIR%\%WGET_F_NAME%" .

%GZIP_CMD% -fdN  knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz

%WGET_CMD_1% --no-check-certificate https://github.com/knowhow/knowhowERP_windows_serviser_3rd_party_install/raw/master/vim/knowhowERP_serviser.vim
%WGET_CMD_1% --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18.sh
%WGET_CMD_1% --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18_prepare.sh


cd ..

echo.
echo.
echo.
echo ------------------------------------------------------------
echo util => c:/knowhowERP/util

xcopy  /Y /i /s  util\* c:\knowhowERP\util\

echo xcopy util zavrsen
echo.

:hbout

echo.
echo.
echo.
echo ------------------------------------------------------------
echo 2. harbour ver %HBOUT_VER% hbout = c:/knowhowERP/hbout

cd "%CUR_DIR%"

del  /Q c:\knowhowERP\hbout

cd "%CUR_DIR%"

set SEVENZ_F_NAME=harbour_windows_%HBOUT_VER%.7z


cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .

echo 7zip extract %SEVENZ_F_NAME%

cd c:\knowhowERP
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"

cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%

xcopy  /Y /i  /s hbout\* c:\knowhowERP\hbout\

:qt

:qt_dev

echo 3. Qt developer %QT_VER% = c:/knowhowERP/Qt

del  /Q c:\knowhowERP\Qt

cd "%CUR_DIR%"

set SEVENZ_F_NAME=Qt_dev_windows_%QT_VER%.7z


cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .

echo 7zip extract %SEVENZ_F_NAME%

cd c:\knowhowERP
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"

cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%

:qt_dlls

echo 3.b. Qt libs %QT_VER% = c:/knowhowERP/lib


cd "%CUR_DIR%"

set SEVENZ_F_NAME=Qt_windows_dlls_%QT_VER%.7z


cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .


echo 7zip extract %SEVENZ_F_NAME%

cd c:\knowhowERP
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"

cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%


:git

echo 4. Git windows %GIT_VER% = c:/knowhowERP/Git

del  /Q c:\knowhowERP\Git

cd "%CUR_DIR%"
set SEVENZ_F_NAME=Git_windows_%GIT_VER%.7z


cd "%DOWNLOAD_DIR%"
%WGET_CMD_1%  %ROOT_GCODE_URL%/%SEVENZ_F_NAME%
if NOT %ERRORLEVEL% == 0 goto :err_wget

cd "%CUR_DIR%"
copy /y "%DOWNLOAD_DIR%\%SEVENZ_F_NAME%" .

echo 7zip extract %SEVENZ_F_NAME%

cd c:\knowhowERP
echo %SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"
%SEVENZ_CMD% "%F_CUR_DIR%\%SEVENZ_F_NAME%"

cd "%CUR_DIR%"
echo rm 7z %SEVENZ_F_NAME%
del %SEVENZ_F_NAME%


:lib

echo "c:/knowhowERP/lib"
 
xcopy  /Y /i lib\* c:\knowhowERP\lib\

echo "Desktop links"
echo.

copy "*.lnk" "%USERPROFILE%/Desktop"

copy ".bashrc" "%USERPROFILE%"


echo knowhowERP serviser/developer Windows 32bit set uspjesno instaliran
echo.
echo bye bye ...
pause
exit

:c_drive

echo Arhiva se mora nalaziti na C disku ! 
echo Vi se nalazite na disku %CUR_DRIVE% 
echo.
echo lokacija %CD%
echo.

goto :nista

:err_wget_0

echo error %ERRORLEVEL% wget %ROOT_GCODE_URL%/%WGET_F_NAME% !
echo .
pause
goto :nista

:err_wget

echo error %ERRORLEVEL% wget %ROOT_GCODE_URL%/%SEVENZ_F_NAME% !
echo .
pause

:nista

echo instalacija nije izvrsena. bye bye ...
pause
