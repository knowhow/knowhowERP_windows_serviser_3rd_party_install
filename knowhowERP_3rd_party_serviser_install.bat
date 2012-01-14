@echo off
echo ===========================================================================
echo   Ovaj batch file instalira serviserske util lokaciju c:\knowhowERP\util
echo. 
echo.     
echo.      
echo. 

set I_VER="0.7.0"

set I_DATE="14.01.2012"


mkdir c:\tmp
mkdir c:\github
mkdir c:\knowhowERP

echo Pritisni Ctrl+C za prekid ili bilo koju tipku za nastavak...
pause > nul


echo "F18 serviser util install ver %I_VER%, %I_DATE%"

rem install
echo kopiram MinGW

xcopy  /Y /i /s MinGW c:\MinGW
xcopy  /Y /i /s Git c:\knowhowERP\Git

echo kupim util pakete ...

cd util

wget -N --no-check-certificate https://github.com/knowhow/knowhowERP_windows_serviser_3rd_party_install/raw/master/vim/knowhowERP_serviser.vim
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18.sh
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18_prepare.sh
wget -N  http://knowhow-erp.googlecode.com/files/knowhowERP_Windows_package_updater_2.2.4.gz
gzip -fdN  knowhowERP_Windows_package_updater_2.2.4.gz

cd ..


echo kopiram fajlove

xcopy  /Y /i /s  util\* c:\knowhowERP\util
xcopy  /Y /i  /s hbout\* c:\knowhowERP\hbout

xcopy  /Y /i /s Qt\* c:\knowhowERP\Qt

xcopy  /Y /i lib\* c:\knowhowERP\lib

copy "*.lnk" "%USERPROFILE%/Desktop"

copy ".bashrc" "%USERPROFILE%"


echo F18 3d_party set uspjesno instaliran
pause
exit
