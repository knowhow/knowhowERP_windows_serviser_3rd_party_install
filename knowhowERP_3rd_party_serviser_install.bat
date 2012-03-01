@echo off
echo ===========================================================================
echo  knowhowERP serviser/developer alati za Windows 32bit platformu 
echo.
echo.
echo.
echo.

set ROOT_GCODE_URL=http://knowhow-erp.googlecode.com/files
set ROOT_GCODE_URL=http://localhost:9292/files
set I_VER=1.0.9

set I_DATE=29.02.2012

set KH_UPDATER_VER=2.2.4
set HBOUT_VER=3.1
set MINGW_VER=4.6.1
set MINGW_MSYS_VER=1.0
set QT_VER=4.7.4
set GIT_VER=1.0

set F_CUR_DIR=%CD%
set CUR_DIR=%F_CUR_DIR:~2%
set CUR_DRIVE=%F_CUR_DIR:~0,1%


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

mkdir c:\tmp
mkdir c:\github
mkdir c:\knowhowERP

echo " "
echo "pocetak ...."


:mingw1

echo 1) MinGW -> c:/MinGW


del  /Q c:\MinGW

cd "%CUR_DIR%"

set TAR_F_NAME=MinGW_knowhow_%MINGW_VER%.tar
set BZ2_F_NAME=%TAR_F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo bunzip2 %BZ2_F_NAME%
bunzip2 %BZ2_F_NAME%
echo untar %TAR_F_NAME%

cd \
tar -x -v -f "%CUR_DIR%\%TAR_F_NAME%"


cd "%CUR_DIR%"
echo rm tar %TAR_F_NAME%
del %TAR_F_NAME%



if %opcija% == M goto :mingw2 
if %opcija% == m goto :mingw2

:msys

cd "%CUR_DIR%"


del  /Q c:\MinGW\mys

echo 1.b) MinGW/msys -> c:/MinGW/msys

set TAR_F_NAME=MinGW_msys_knowhow_%MINGW_MSYS_VER%.tar
set BZ2_F_NAME=%TAR_F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo bunzip2 %BZ2_F_NAME%
bunzip2 %BZ2_F_NAME%

echo untar %TAR_F_NAME%

cd c:\MinGW
tar -x -v -f "%CUR_DIR%\%TAR_F_NAME%"

cd "%CUR_DIR%"

echo rm tar %TAR_F_NAME%
del %TAR_F_NAME%

cd "%CUR_DIR%"


:mingw2

rem xcopy  /Y /i /s MinGW c:\MinGW\

:util

echo .
echo .
echo ----------------------------------------------
echo kupim util pakete ...

cd "%CUR_DIR%"

cd util

wget -N --no-check-certificate https://github.com/knowhow/knowhowERP_windows_serviser_3rd_party_install/raw/master/vim/knowhowERP_serviser.vim
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18.sh
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18_prepare.sh

wget -N %ROOT_GCODE_URL%/knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz

gzip -fdN  knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz
cd ..

echo.
echo.
echo.
echo ------------------------------------------------------------
echo util => c:/knowhowERP/util

xcopy  /Y /i /s  util\* c:\knowhowERP\util

:hbout
echo.
echo.
echo.
echo ------------------------------------------------------------
echo 2) harbour ver %HBOUT_VER% hbout -> c:/knowhowERP/hbout

cd "%CUR_DIR%"

set TAR_F_NAME=hbout_%HBOUT_VER%.tar
set BZ2_F_NAME=%TAR_F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%

echo bunzip2 %BZ2_F_NAME%
bunzip2 %BZ2_F_NAME%

echo untar %TAR_F_NAME%

cd c:\knowhowERP\
tar -x -v -f "%CUR_DIR%\%TAR_F_NAME%"

cd "%CUR_DIR%"


cd ""%CUR_DIR%""
echo rm tar %TAR_F_NAME%
del %TAR_F_NAME%

xcopy  /Y /i  /s hbout\* c:\knowhowERP\hbout

:qt

echo 3) Qt developer %QT_VER% -> c:/knowhowERP/Qt


del  /Q c:\knowhowERP\Qt

cd "%CUR_DIR%"

set TAR_F_NAME=Qt_dev_windows_%QT_VER%.tar
set BZ2_F_NAME=%TAR_F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo bunzip2 %BZ2_F_NAME%
bunzip2 %BZ2_F_NAME%
echo untar %TAR_F_NAME%

cd c:\knowhowERP
tar -x -v -f "%CUR_DIR%\%TAR_F_NAME%"


cd "%CUR_DIR%"
echo rm tar %TAR_F_NAME%
del %TAR_F_NAME%

:git

echo 4) Git windows %GIT_VER% -> c:/knowhowERP/Git


del  /Q c:\knowhowERP\Git

cd "%CUR_DIR%"

set TAR_F_NAME=Git_windows_%GIT_VER%.tar
set BZ2_F_NAME=%TAR_F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo bunzip2 %BZ2_F_NAME%
bunzip2 %BZ2_F_NAME%
echo untar %TAR_F_NAME%

cd c:\knowhowERP
tar -x -v -f "%CUR_DIR%\%TAR_F_NAME%"


cd "%CUR_DIR%"
echo rm tar %TAR_F_NAME%
del %TAR_F_NAME%



:lib

echo "c:/knowhowERP/lib"
 
xcopy  /Y /i lib\* c:\knowhowERP\lib\

echo "Desktop links"
echo.

copy "*.lnk" "%USERPROFILE%/Desktop"

copy ".bashrc" "%USERPROFILE%"


echo knowhowERP serviser/developer Windows 32bit set uspjesno instaliran
echo.
echo "bye bye ..."
pause
exit

:c_drive

echo Arhiva se mora nalaziti na C disku ! 
echo Vi se nalazite na disku %CUR_DRIVE% 
echo.
echo lokacija %CD%
echo.

:nista

echo instalacija nije izvrsena. bye bye ...
pause
