# Guia de Instalação e Execução do WRF

## Compilação C e Fortran

### 1. Torne executáveis os arquivos `.sh` na pasta `install_wrf`:
```bash
chmod +x *.sh
```

### 2. Execute-os na ordem como usuário `sudo`:
```bash
su -
(password)
```

### 3. Instale os compiladores Intel OneAPI:
```bash
./l_dpcpp-cpp-compiler_p_2023.2.1.8.sh
```

**Passos da instalação:**
- Next >> Accept & customize >> Next
- Altere o diretório de instalação para: `/usr/local/intel/oneapi`
- Next >> Install >> Next
- Marque a opção "I do not consent to the collection of my information"
- Begin installation >> Close

Repita os mesmos passos para:
```bash
./l_fortran-compiler_p_2023.2.1.8.sh
```

### 4. Configure o ambiente:
```bash
source /usr/local/intel/oneapi/setvars.sh
```

### 5. Verifique a instalação:
```bash
icc  # Verifica compilador C
ifort  # Verifica compilador Fortran
```

### 6. Edite o script `instala_libs_intel.sh` na pasta `install_wrf`:
```bash
nano instala_libs_intel.sh
```
Confirme que o caminho do `source` está correto:
```bash
source /usr/local/intel/oneapi/setvars.sh
```
Ative as flags desejadas:
```bash
ZLIB_FLAG=1
NETCDF_F_FLAG=1
```
Salve (`Ctrl+O`) e saia (`Ctrl+X`).

### 7. Execute o script:
```bash
./instala_libs_intel.sh
```

## Baixando o WRF, WPS e Geog

### 1. Crie e entre na pasta de instalação:
```bash
mkdir WRFv4.6.1 && cd WRFv4.6.1
```

### 2. Clone os repositórios:
```bash
git clone https://github.com/wrf-model/WRF.git
git clone https://github.com/wrf-model/WPS.git
```

### 3. Baixe e extraia os arquivos geográficos:
```bash
wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz
tar zxvf geog_low_res_mandatory.tar.gz
```

### 4. Organize os diretórios:
```bash
mkdir DOMAINS && cd DOMAINS
mkdir GRADE PREPROC RUN POSPROC
```

## Compilação do WRF

### 1. Configure o ambiente:
```bash
cd install_wrf
source setenv.sh
```

### 2. Compile o WRF:
```bash
cd ../WRF
./configure
```
Escolha a opção: `16`

Nesting: `1` (ou outra opção conforme necessário)

```bash
./compile em_real
```
Caso haja erro:
```bash
apt install csh
./compile em_real
```

## Compilação do WPS

### 1. Configure e compile:
```bash
cd ../WPS
./configure
```
Escolha a opção: `3`

```bash
./compile
```

## Instalação do GrADS e Ferret

### 1. Baixe e descompacte os arquivos:
```bash
tar zxfv opengrads.tar.gz
wget https://sourceforge.net/projects/opengrads/files/OpenGrADS%20-%20Binary/2.2.1.oga.1/opengrads-2.2.1.oga.1-bin.tar.gz/download -O opengrads.tar.gz

wget https://github.com/NOAA-PMEL/Ferret/releases/download/v7.6.0/ferret-7.6.0-RHEL7-64.tar.gz
tar zxfv ferret7.6.0.tar.gz
```

### 2. Mova para `/usr/local/`:
```bash
su -
(password)
mv ferret /usr/local
mv opengrads /usr/local
```

## Instalação do Anaconda3

### 1. Execute como `sudo`:
```bash
su -
(password)
```

### 2. Baixe e execute:
```bash
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
./anaconda3-2023.09-0-Linux-x86_64.sh
```

**Passos:**
- Aceite os termos: `yes`
- Instale em: `/usr/local/anaconda3`
- Finalize: `yes`

### 3. Configure o ambiente:
```bash
nano ~/.bashrc
```
Copie o bloco **`conda initialize`** e cole no final do arquivo `/etc/bash.bashrc`:
```bash
export PATH=/usr/local/opengrads:$PATH
source /usr/local/ferret/bin/ferret_paths_template.sh
```
Salve (`Ctrl+O`) e saia (`Ctrl+X`).

### 4. Teste o GrADS e Ferret:
```bash
grads
ferret
go tutorial
```

## Execução do WRF

### 1. Inicialização
Na pasta  ../WRFv.4.6.1/DOMAINS: 
```bash
source ~/.bashrc
mkdir GRADE_TEST
cd ../WRFv4.6.1/DOMAINS/GRADE_TEST
```

Crie uma pasta nova a cada experimento: 

../WRFv4.6.1/DOMAINS# mkdir GRADE_TEST 

 cd ../WRFv4.6.1/DOMAINS/GRADE_TEST#  

Crie os domínios de grade no site: https://jiririchter.github.io/WRFDomainWizard/ 

Copie e cole as informações de grade nos arquivos namelist.input e namelist.wps 

Alguns modelos de namelists: 
namelist.input: Best Practices 
https://www2.mmm.ucar.edu/wrf/users/namelist_best_prac_wrf.html 

namelist.wps: Best Practices 
https://www2.mmm.ucar.edu/wrf/users/namelist_best_prac_wps.html	 

Utilize o **WRF Domain Wizard** para definir os domínios e configure os arquivos `namelist.input` e `namelist.wps`.

após configurar os namelists copie-os para GRADE_TEST: 
mv namelist.wps namelist.input ../WRFv4.6.1/DOMAINS/GRADE_TEST 

### 2. Criando links simbólicos:
na pasta ../GRADE_TEST/#
```bash
ln -sf ../WRFv4.6.1/WPS/geogrid/geogrid.exe .
ln -sf ../WRFv4.6.1/WPS/geogrid/GEOGRID.TBL .
ln -sf ../WRFv4.6.1/WPS/ungrib.exe .
ln -sf ../WRFv4.6.1/WPS/metgrid.exe .
ln -sf ../WRFv4.6.1/WPS/ungrib/Variable_Tables/Vtable.GFS Vtable
ln -sf ../WRFv4.6.1/WPS /metgrid/METGRID.TBL.ARW METGRID.TBL
ln -sf ../WRFv4.6.1/WRF/run/CAMtr_volume_mixing_ratio .
ln -sf ../WRFv4.6.1/WRF/run/*DATA* .
ln -sf ../WRFv4.6.1/WRF/run/*.TBL .
ln -sf ../WRFv4.6.1/WRF/run/tr* .
ln -sf ../WRFv4.6.1/WRF/run/*.bin .
ln -sf ../WRFv4.6.1/WRF/run/ozone* .
ln -sf ../WRFv4.6.1/WRF/run/real.exe .
ln -sf ../WRFv4.6.1/WRF/run/wrf.exe . 
```

### 3. Executando os programas:
Em ordem
```bash
./geogrid.exe
./ungrib.exe
./metgrid.exe
```

### 4. Processamento com `real.exe` e `wrf.exe`
```bash
./real.exe
mpiexec -np 4 ./wrf.exe
```

Este guia cobre todas as etapas para instalação e execução do WRF. Para dúvidas adicionais, consulte a [documentação oficial](https://www2.mmm.ucar.edu/wrf/users/).

