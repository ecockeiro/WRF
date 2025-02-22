#!/bin/bash
#
# INSTALL NETCDF and MPI2 LIBRARY IN DEST.
#
# Requires wget program
#
# CHEK HERE BELOW THE COMPILERS
#
# Working CC Compiler
# Adaptado do script de instalação do do RegCM4
# Ronaldo Palmeira - 2018
source /usr/local/intel/oneapi/setvars.sh 
#
export CC=icc
export CXX=icpc
export CFLAGS='-O3 -xHost -ip -no-prec-div -static-intel -fPIC'
export CXXFLAGS='-O3 -xHost -ip -no-prec-div -static-intel'
export F77=ifort
export FC=ifort
export FFLAGS='-O3 -xHost -ip -no-prec-div -static-intel'
export CPP='icc -E'
export CXXCPP='icpc -E'
# 
export LD_LIBRARY_PATH=/usr/local/intel/lib:$LD_LIBRARY_PATH
#
# Destination directory
DEST=/usr/local/intel
mkdir -p $DEST/src
mkdir -p $DEST/logs

cd $DEST/src
mv *.tar.* $DEST

ZLIB_FLAG=1
SZIP_FLAG=1
PNG_FLAG=1
JASPER_FLAG=1
MPICH_FLAG=1
HDF5_FLAG=1
NETCDF_C_FLAG=1
NETCDF_F_FLAG=1

zlib_ver=1.3.1 
szip_ver=2.1.1 
jasper_ver=1.900.1
png_ver=1.6.36
netcdf_c_ver=4.7.4
netcdf_f_ver=4.6.1
mpich_ver=4.2.3
hdf5_ver=1.13

ZLIB=http://zlib.net
SZIP=https://support.hdfgroup.org/ftp/lib-external/szip/${szip_ver}/src
JASPER=https://ftp2.osuosl.org/pub/blfs/conglomeration/jasper/
PNG=https://ufpr.dl.sourceforge.net/project/libpng/libpng16/${png_ver}


NETCDFC=https://github.com/Unidata/netcdf-c/archive/refs/tags/
NETCDFF=https://github.com/Unidata/netcdf-fortran/archive/refs/tags/


#UNIDATA=https://downloads.unidata.ucar.edu
MPICH=https://www.mpich.org/static/downloads
HDF5=https://support.hdfgroup.org/ftp/HDF5/releases

export LDFLAGS='-L/usr/local/intel/lib'
export CPPFLAGS='-I/usr/local/intel/include'
export LD_LIBRARY_PATH=$DEST/lib:$LD_LIBRARY_PATH

if [ -z "$DEST" ]
then
  echo "SCRIPT TO INSTALL NETCDF V4 and MPICH LIBRARIES."
  echo "EDIT ME TO DEFINE DEST, CC AND FC VARIABLE"
  exit 1
fi

MAKE=`which gmake 2> /dev/null`
if [ -z "$MAKE" ]
then
  echo "Assuming make program is GNU make program"
  MAKE=make
fi

WGET=`which wget 2> /dev/null`
if [ -z "$WGET" ]
then
  echo "wget programs must be installed to download netCDF lib."
  exit 1
fi

WGET="$WGET --no-check-certificate"

echo "This script installs the netCDF/mpi librares in the"
echo
echo -e "\t $DEST"
echo
echo "directory. If something goes wrong, logs are saved in"
echo
echo -e "\t$DEST/logs"
echo
rm -f logs/*.log




if [ $ZLIB_FLAG -eq 1 ]; then
cd $DEST
echo "Downloading ZLIB library..."
$WGET -c $ZLIB/zlib-${zlib_ver}.tar.gz -o $DEST/logs/download_Z.log
if [ $? -ne 0 ]
then
  echo "Error downloading ZLIB library from zlib.net"
  exit 1
fi

echo "Compiling zlib Library."
tar zxvf zlib-${zlib_ver}.tar.gz >> $DEST/logs/extract.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing zlib library"
  exit 1
fi
cd zlib-${zlib_ver}
echo CC="$CC" FC="$FC" ./configure --prefix=$DEST --shared >> \
        $DEST/logs/configure.log
CC="$CC" FC="$FC" ./configure --prefix=$DEST >> \
             $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
  $MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling zlib library"
  exit 1
fi
cd $DEST
rm -fr zlib-${zlib_ver}
echo "Compiled zlib library."
fi


if [ $SZIP_FLAG -eq 1 ]; then
echo "Downloading SZIP library..."
$WGET -c $SZIP/szip-${szip_ver}.tar.gz -o $DEST/logs/download_S.log
if [ $? -ne 0 ]
then
  echo "Error downloading SZIP library from HDFGROUP"
  exit 1
fi
echo "Compiling szip Library."
tar zxvf szip-${szip_ver}.tar.gz >> $DEST/logs/extract.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing szip library"
  exit 1
fi
cd szip-${szip_ver}
echo CC="$CC" FC="$FC" ./configure --prefix=$DEST >> \
        $DEST/logs/configure.log
CC="$CC" FC="$FC" ./configure --prefix=$DEST >> \
             $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
  $MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling szip library"
  exit 1
fi
cd $DEST
rm -fr szip-${szip_ver}
echo "Compiled szip library."
fi



if [ $PNG_FLAG -eq 1 ]; then
echo "Downloading PNG library..."
$WGET --no-check-certificate -c $PNG/libpng-${png_ver}.tar.gz -o $DEST/logs/download_PNG.log
if [ $? -ne 0 ]
then
  echo "Error downloading PNG library from libpng.org"
  exit 1
fi
echo "Compiling png Library."
tar zxvf libpng-${png_ver}.tar.gz > $DEST/logs/extract_PNG.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing libpng library"
  exit 1
fi
cd libpng-${png_ver}
echo CC="$CC" FC="$FC" ./configure --prefix=$DEST > \
        $DEST/logs/configure_PNG.log
CC="$CC" FC="$FC" ./configure --prefix=$DEST >> \
             $DEST/logs/configure_PNG.log 2>&1
$MAKE > $DEST/logs/compile_PNG.log 2>&1 && \
$MAKE install > $DEST/logs/install_PNG.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling libnpng library"
  exit 1
fi
cd $DEST
rm -fr libpng-${png_ver}
echo "Compiled libpng library."
fi


if [ $JASPER_FLAG -eq 1 ]; then
echo "Downloading JASPER library..."
$WGET -c $JASPER/jasper-${jasper_ver}.zip -o $DEST/logs/download_J.log
if [ $? -ne 0 ]
then
  echo "Error downloading JASPER library from JASPER"
  exit 1
fi

echo "Compiling JASPER library."
unzip jasper-${jasper_ver}.zip >> $DEST/logs/extract.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing jasper library"
  exit 1
fi
cd jasper-${jasper_ver}/
export CFLAGS='-std=c99 -Wall' #-Wno-implicit-function-declaration
export CXXFLAGS='-std=c99 -Wall' #-Wno-implicit-function-declaration
CC=gcc FC=gfortran ./configure --prefix=$DEST >> \
             $DEST/logs/configure_JASPER.log 2>&1
$MAKE >> $DEST/logs/compile_JASPER.log 2>&1 && \
  $MAKE install >> $DEST/logs/install_JASPER.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling JASPER library"
  exit 1
fi
cd $DEST

echo "Compiled JASPER library."
export CFLAGS=${OPTIM}
export CXXFLAGS=${OPTIM}
fi


if [ $MPICH_FLAG -eq 1 ]; then
echo "Downloading MPICH Library..."
$WGET -c $MPICH/${mpich_ver}/mpich-${mpich_ver}.tar.gz -o $DEST/logs/download_M.log
if [ $? -ne 0 ]
then
  echo "Error downloading MPICH from MPICH website"
  exit 1
fi
echo "Compiling MPICH library."
tar zxvf mpich-${mpich_ver}.tar.gz >> $DEST/logs/extract.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing mpich library"
  exit 1
fi
cd mpich-${mpich_ver}
echo ./configure CC="$CC" FC="$FC" F77="$FC" CXX="$CXX" \
      --prefix=$DEST --disable-cxx >> $DEST/logs/configure.log
./configure CC="$CC" FC="$FC" F77="$FC" CXX="$CXX" \
        --prefix=$DEST >> $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
  $MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling mpich library"
  exit 1
fi
cd $DEST
rm -fr mpich-${mpich_ver}
echo "Compiled MPICH library."
fi

if [ $HDF5_FLAG -eq 1 ]; then
echo "Downloading HDF5 Library..."
$WGET -c $HDF5/hdf5-${hdf5_ver}/hdf5-${hdf5_ver}.0/src/hdf5-${hdf5_ver}.0.tar.gz -o $DEST/logs/download.log
if [ $? -ne 0 ]
then
  echo "Error downloading HDF5 from HDF website"
  exit 1
fi
echo "Compiling HDF5 library."
tar zxvf hdf5-${hdf5_ver}.0.tar.gz >> $DEST/logs/extract.log
if [ $? -ne 0 ]
then
  echo "Error uncompressing HDF5 library"
  exit 1
fi
cd hdf5-${hdf5_ver}.0
./configure --prefix=$DEST \
           --enable-fortran \
           --enable-cxx \
           --enable-shared--with-zlib=${DEST}/include,${DEST}/lib \
          --with-szlib=${DEST}/lib \
          --enable-hl --enable-fortran >> $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
$MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling HDF5 library"
  exit 1
fi
#rm -fr hdf5-${hdf5_ver}.0
echo "Compiled HDF5 library."
fi

pwd
if [ $NETCDF_C_FLAG -eq 1 ]; then
echo "Downloading netCDF C Library..."
$WGET -c $NETCDFC/v${netcdf_c_ver}.tar.gz -o $DEST/logs/download_C.log

if [ $? -ne 0 ]
then
  echo "Error downloading netCDF C library from www.unidata.ucar.edu"
  exit 1
fi

echo "Compiling netCDF Library."
tar zxvf v${netcdf_c_ver}.tar.gz >> $DEST/logs/extract.log
cd netcdf-c-${netcdf_c_ver}
H5LIBS="-lhdf5_hl -lhdf5 -lz -lsz"
if [ "X$FC" == "Xgfortran" ]
then
  H5LIBS="$H5LIBS -lm -ldl"
fi
echo ./configure CC="$CC" FC="$FC" --prefix=$DEST --enable-netcdf-4 \
  CPPFLAGS=-I$DEST/include LDFLAGS=-L$DEST/lib LIBS="$H5LIBS" \
  --disable-dap --enable-shared >> $DEST/logs/configure.log
./configure CC="$CC" FC="$FC" --prefix=$DEST --enable-netcdf-4 \
  CPPFLAGS=-I$DEST/include LDFLAGS=-L$DEST/lib LIBS="$H5LIBS" \
  --disable-dap --enable-shared >> $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
$MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling netCDF C library"
  exit 1
fi
echo "Compiled netCDF C library."
fi


if [ $NETCDF_F_FLAG -eq 1 ]; then
echo "Downloading netCDF Fortran Library..."
$WGET -c $NETCDFF/v${netcdf_f_ver}.tar.gz -o $DEST/logs/download_F.log
if [ $? -ne 0 ]
then
  echo "Error downloading netCDF Fortran library from www.unidata.ucar.edu"
  exit 1
fi

echo "Compiling netCDF Fortran library."
tar zxvf v${netcdf_f_ver}.tar.gz >> $DEST/logs/extract.log
cd netcdf-fortran-${netcdf_f_ver}
echo ./configure PATH=$DEST/bin:$PATH CC="$CC" FC="$FC" F77="$FC" \
     CPPFLAGS=-I$DEST/include LDFLAGS=-L$DEST/lib --prefix=$DEST \
     --enable-shared >> $DEST/logs/configure.log
./configure PATH=$DEST/bin:$PATH CC="$CC" FC="$FC" F77="$FC" \
     CPPFLAGS=-I$DEST/include LDFLAGS=-L$DEST/lib --prefix=$DEST \
     --enable-shared >> $DEST/logs/configure.log 2>&1
$MAKE >> $DEST/logs/compile.log 2>&1 && \
$MAKE install >> $DEST/logs/install.log 2>&1
if [ $? -ne 0 ]
then
  echo "Error compiling netCDF Fortran library"
  exit 1
fi
echo "Compiled netCDF Fortran library."
fi



# Done
echo
echo                 "Done!"
echo
