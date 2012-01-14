export BASE_DIR=~/Desktop/knowhowERP_windows_serviser_3rd_party_install

echo base dir = $BASE_DIR


if ! [ -f browse_dbf/browse_dbf.exe ]
then
    echo "buildaj browse_dbf.exe !"
    exit 1
else
    cp -av browse_dbf/browse_dbf.exe "$BASE_DIR"/util
fi

cp -av Git_knowhowERP.lnk "$BASE_DIR"/Git_knowhowERP.lnk
cp -av "knowhowERP package updater.lnk" "$BASE_DIR"/

cp -av  *.md *.bat util hbout "$BASE_DIR"

cp .bashrc "$BASE_DIR/.bashrc"
