@echo off
echo ===========================================================================
echo   Ovaj batch file instalira serviserske util lokaciju c:\knowhowERP\util
echo. 
echo.     
echo.      
echo. 

set ROOT_GCODE_URL="http://knowhow-erp.googlecode.com/files"
set I_VER="0.1.0"

set I_DATE="29.02.2012"

set KH_UPDATER_VER="2.2.4"
set HBOUT_VER="1.0"
set MINGW_VER="1.0"
set MINGW_MSYS_VER="1.0"

mkdir c:\tmp
mkdir c:\github
mkdir c:\knowhowERP

echo Pritisni Ctrl+C za prekid ili bilo koju tipku za nastavak...
pause > nul


echo "F18 serviser util install ver %I_VER%, %I_DATE%"

rem install

echo MinGW -> c:/MinGW

mkdir MinGW

TAR_F_NAME=MinGW_knohowhow_package_%MINGW_VER%.tar
BZ2_FNAME=%F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo "bunzip %BZ2_F_NAME%"
bunzip2 %BZ2_F_NAME%
echo "untar %TAR_F_NAME%
tar xfv %TAR_F_NAME%
echo "rm tar %TAR_F_NAME%
rm %TAR_F_NAME%

xcopy  /Y /i /s MinGW c:\MinGW




xcopy  /Y /i /s Git c:\knowhowERP\Git

echo kupim util pakete ...

cd util

wget -N --no-check-certificate https://github.com/knowhow/knowhowERP_windows_serviser_3rd_party_install/raw/master/vim/knowhowERP_serviser.vim
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18.sh
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18_prepare.sh

wget -N %ROOT_GCODE_URL%/knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz

gzip -fdN  knowhowERP_Windows_package_updater_%KH_UPDATER_VER%.gz

cd ..


echo kopiram fajlove

xcopy  /Y /i /s  util\* c:\knowhowERP\util



mkdir hbout

TAR_F_NAME=hbout_%MINGW_VER%.tar
BZ2_FNAME=%F_NAME%.bz2

wget -N  %ROOT_GCODE_URL%/%BZ2_F_NAME%
echo "bunzip %BZ2_F_NAME%"
bunzip2 %BZ2_F_NAME%
echo "untar %TAR_F_NAME%
tar xfv %TAR_F_NAME%
echo "rm tar %TAR_F_NAME%
rm %TAR_F_NAME%

xcopy  /Y /i  /s hbout\* c:\knowhowERP\hbout

xcopy  /Y /i /s Qt\* c:\knowhowERP\Qt

xcopy  /Y /i lib\* c:\knowhowERP\lib

copy "*.lnk" "%USERPROFILE%/Desktop"

copy ".bashrc" "%USERPROFILE%"


echo F18 3d_party set uspjesno instaliran
pause
exit
