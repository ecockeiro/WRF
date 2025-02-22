
source /usr/local/intel/oneapi/setvars.sh
export PATH=/usr/local/intel/bin:$PATH
ulimit -s unlimited


export LIBS="/usr/local/intel"
export CC=icc
export CXX=icpc
export FC=ifort
export F77=ifort
export FFLAGS="-m64"
export CPPFLAGS="-I$LIBS/include"
export CFLAGS="-L$LIBS/lib -I$LIBS/include -L/usr/local/intel/oneapi/lib/intel64/"
export LDFLAGS="-L$LIBS/lib -I$LIBS/include -L/usr/local/intel/oneapi/lib/intel64/ -liomp5"
export FCFLAGS="-L$LIBS/lib -m64 -liomp5"
export DIR=$LIBS
export JASPERINC=$LIBS/include/
export JASPERLIB=$LIBS/lib/
export NETCDF=$LIBS
#export HDF5=$LIBS
export WRF_DIR=/work1/WRFv4.6.1/WRF
export PATH=$LIBS/bin:$PATH
export LD_LIBRARY_PATH=$LIBS/lib:$LD_LIBRARY_PATH

export PATH=/usr/local/intel/bin:$PATH
export NETCDF=/usr/local/intel/




#mkdir WRFV4.6.1
#cd WRFV4.6.1

#git clone https://github.com/wrf-model/WRF.git
#cd WRF
#./configure
#nohup ./compile em_real &


#cd WRFV4.6.1
#git clone https://github.com/wrf-model/WPS.git
#cd WPS
#./configure
#nohup ./compile &


#WPS error
#configure.wps                     -L$(NETCDF)/lib -lnetcdff -lnetcdf -liomp5 -lpthread -lgomp

