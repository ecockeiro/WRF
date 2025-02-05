# Compila e Instala WRF



>> Verificar se todas as dependências foram instaladas:
(base) root@debian: /usr/local/intel/lib
Out: Vai aparecer as libs dos pacotes compilados

>> Ativar o setenv.sh
(base) root@debian:/work1/install# source setenv.sh 
 
:: initializing oneAPI environment ...
   -bash: BASH_VERSION = 5.2.15(1)-release
   args: Using "$@" for setvars.sh arguments: 
:: compiler -- latest
:: debugger -- latest
:: dev-utilities -- latest
:: mpi -- latest
:: tbb -- latest
:: oneAPI environment initialized ::
 
>> ./configure WRF
(base) root@debian:/work1/WRFv4.6.1/WRF# ./configure
checking for perl5... no
checking for perl... found /usr/bin/perl (perl)
Will use NETCDF in dir: /usr/local/intel/
ADIOS2 not set in environment. Will configure WRF for use without.
HDF5 not set in environment. Will configure WRF for use without.
PHDF5 not set in environment. Will configure WRF for use without.


If you REALLY want Grib2 output from WRF, modify the arch/Config.pl script.
Right now you are not getting the Jasper lib, from the environment, compiled into WRF.

------------------------------------------------------------------------
Please select from among the following Linux x86_64 options:

  1. (serial)   2. (smpar)   3. (dmpar)   4. (dm+sm)   PGI (pgf90/gcc)
  5. (serial)   6. (smpar)   7. (dmpar)   8. (dm+sm)   PGI (pgf90/pgcc): SGI MPT
  9. (serial)  10. (smpar)  11. (dmpar)  12. (dm+sm)   PGI (pgf90/gcc): PGI accelerator
 13. (serial)  14. (smpar)  15. (dmpar)  16. (dm+sm)   INTEL (ifort/icc)
                                         17. (dm+sm)   INTEL (ifort/icc): Xeon Phi (MIC architecture)
 18. (serial)  19. (smpar)  20. (dmpar)  21. (dm+sm)   INTEL (ifort/icc): Xeon (SNB with AVX mods)
 22. (serial)  23. (smpar)  24. (dmpar)  25. (dm+sm)   INTEL (ifort/icc): SGI MPT
 26. (serial)  27. (smpar)  28. (dmpar)  29. (dm+sm)   INTEL (ifort/icc): IBM POE
 30. (serial)               31. (dmpar)                PATHSCALE (pathf90/pathcc)
 32. (serial)  33. (smpar)  34. (dmpar)  35. (dm+sm)   GNU (gfortran/gcc)
 36. (serial)  37. (smpar)  38. (dmpar)  39. (dm+sm)   IBM (xlf90_r/cc_r)
 40. (serial)  41. (smpar)  42. (dmpar)  43. (dm+sm)   PGI (ftn/gcc): Cray XC CLE
 44. (serial)  45. (smpar)  46. (dmpar)  47. (dm+sm)   CRAY CCE (ftn $(NOOMP)/cc): Cray XE and XC
 48. (serial)  49. (smpar)  50. (dmpar)  51. (dm+sm)   INTEL (ftn/icc): Cray XC
 52. (serial)  53. (smpar)  54. (dmpar)  55. (dm+sm)   PGI (pgf90/pgcc)
 56. (serial)  57. (smpar)  58. (dmpar)  59. (dm+sm)   PGI (pgf90/gcc): -f90=pgf90
 60. (serial)  61. (smpar)  62. (dmpar)  63. (dm+sm)   PGI (pgf90/pgcc): -f90=pgf90
 64. (serial)  65. (smpar)  66. (dmpar)  67. (dm+sm)   INTEL (ifort/icc): HSW/BDW
 68. (serial)  69. (smpar)  70. (dmpar)  71. (dm+sm)   INTEL (ifort/icc): KNL MIC
 72. (serial)  73. (smpar)  74. (dmpar)  75. (dm+sm)   AMD (flang/clang) :  AMD ZEN1/ ZEN2/ ZEN3 Architectures
 76. (serial)  77. (smpar)  78. (dmpar)  79. (dm+sm)   INTEL (ifx/icx) : oneAPI LLVM
 80. (serial)  81. (smpar)  82. (dmpar)  83. (dm+sm)   FUJITSU (frtpx/fccpx): FX10/FX100 SPARC64 IXfx/Xlfx

Enter selection [1-83] : 16
------------------------------------------------------------------------
Compile for nesting? (1=basic, 2=preset moves, 3=vortex following) [default 1]: (enter)

Configuration successful! 
------------------------------------------------------------------------
testing for fseeko and fseeko64
fseeko64 is supported
------------------------------------------------------------------------

######################
------------------------------------------------------------------------
Settings listed above are written to configure.wrf.
If you wish to change settings, please edit that file.
If you wish to change the default options, edit the file:
     arch/configure.defaults
NetCDF users note:
 This installation of NetCDF supports large file support.  To DISABLE large file
 support in NetCDF, set the environment variable WRFIO_NCD_NO_LARGE_FILE_SUPPORT
 to 1 and run configure again. Set to any other value to avoid this message.
  

Testing for NetCDF, C and Fortran compiler

This installation of NetCDF is 64-bit
                 C compiler is 64-bit
           Fortran compiler is 64-bit
              It will build in 64-bit
 
NetCDF version: 4.7.4
Enabled NetCDF-4/HDF-5: yes
NetCDF built with PnetCDF: no
 

************************** W A R N I N G ************************************
 
The moving nest option is not available due to missing rpc/types.h file.
Copy landread.c.dist to landread.c in share directory to bypass compile error.
 
*****************************************************************************
*****************************************************************************
This build of WRF will use NETCDF4 with HDF5 compression
*****************************************************************************


>> ./compile em_real WRF
(base) root@debian:/work1/WRFv4.6.1/WRF# ./compile em_real
-bash: ./compile: cannot execute: required file not found
(base) root@debian:/work1/WRFv4.6.1/WRF# apt install csh
Lendo listas de pacotes... Pronto
Construindo árvore de dependências... Pronto
Lendo informação de estado... Pronto        
Os NOVOS pacotes a seguir serão instalados:
  csh
0 pacotes atualizados, 1 pacotes novos instalados, 0 a serem removidos e 2 não atualizados.
É preciso baixar 243 kB de arquivos.
Depois desta operação, 348 kB adicionais de espaço em disco serão usados.
Obter:1 http://ftp.br.debian.org/debian bookworm/main amd64 csh amd64 20110502-7+b1 [243 kB]
Baixados 243 kB em 0s (2.194 kB/s)
A seleccionar pacote anteriormente não seleccionado csh.
(Lendo banco de dados ... 176651 ficheiros e diretórios atualmente instalados.)
A preparar para desempacotar .../csh_20110502-7+b1_amd64.deb ...
A descompactar csh (20110502-7+b1) ...
Configurando csh (20110502-7+b1) ...
update-alternatives: a usar /bin/bsd-csh para disponibilizar /bin/csh (csh) em modo auto
A processar 'triggers' para man-db (2.11.2-2) ...

(base) root@debian:/work1/WRFv4.6.1/WRF# ./compile em_real
out: 
build started:   qua 05 fev 2025 17:12:38 -03
build completed: qua 05 fev 2025 18:13:55 -03
 
--->                  Executables successfully built                  <---
 
-rwxr-xr-x 1 root root 47202184 fev  5 18:13 main/ndown.exe
-rwxr-xr-x 1 root root 42171200 fev  5 18:13 main/real.exe
-rwxr-xr-x 1 root root 41434584 fev  5 18:13 main/tc.exe
-rwxr-xr-x 1 root root 53808200 fev  5 18:11 main/wrf.exe


 
