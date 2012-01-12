export TEMP=/c/tmp
export TMP=/c/tmp

export HB_ARCHITECTURE=win
export HB_COMPILER=mingw


HB_ROOT=/c/knowhowERP/hbout

export PATH=$HB_ROOT/bin:/c/PostgreSQL/9.1/bin:$PATH
export HB_INC_INSTALL=$HB_ROOT/include
export HB_LIB_INSTALL=$HB_ROOT/lib/win/mingw

export HB_INSTALL_PREFIX=$HB_ROOT

export HB_WITH_QT=c:\\Qt\\4.7.4\\include
export HB_WITH_PGSQL=c:\\PostgreSQL\\9.1\\include


HB_DBG=/c/github/F18_knowhow

export HB_DBG_PATH=$HB_DBG/common:$HB_DBG/pos:$HB_DBG/kalk:$HB_DBG/fin:$HB_DBG/fakt:$HB_DBG/os:$HB_DBG/ld:/$HB_DBG/epdf:$HB_DBG/rnal

echo HB_DBG_PATH=$HB_DBG_PATH

