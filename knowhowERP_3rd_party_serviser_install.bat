@echo off
echo ===========================================================================
echo   Ovaj batch file instalira serviserske util lokaciju c:\knowhowERP\util
echo. 
echo.     
echo.      
echo. 


echo Pritisni Ctrl+C za prekid ili bilo koju tipku za nastavak...
pause > nul

set I_VER="0.1.0"
set I_DATE="23.12.2011"

echo "F18 serviser util install ver %I_VER%, %I_DATE%"

rem install
echo kopiram direktorije

xcopy  /Y /i /E util\syntax  c:\knowhowERP\util\syntax
xcopy  /Y /i /E util\lib\win c:\knowhowERP\util\lib\win
xcopy  /Y /i /E util\include c:\knowhowERP\util\include

cd util

wget -N --no-check-certificate https://github.com/knowhow/F18_serviser_3rd_party_install/raw/master/vim/knowhowERP_serviser.vim
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18.sh
wget -N --no-check-certificate https://github.com/knowhow/FMK2F18/raw/master/FMK2F18_prepare.sh
wget -N  http://knowhow-erp.googlecode.com/files/knowhowERP_Windows_package_updater_2.2.4.gz
gzip -dN knowhowERP_Windows_package_updater_2.2.4.gz

cd ..


echo kopiram fajlove

xcopy  /Y /i util\* c:\knowhowERP\util

echo F18 3d_party set uspjesno instaliran
pause
exit
