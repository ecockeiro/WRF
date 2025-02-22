# Guia de Instalação do WRF

## Compilação C e Fortran

1. Torne executáveis os arquivos `.sh` na pasta `install_wrf`:
   ```bash
   chmod +x *.sh
   ```
2. Execute-os na ordem como usuário `sudo`:
   ```bash
   su -
   (password)
   ```
3. Instale os compiladores Intel OneAPI:
   ```bash
   ./l_dpcpp-cpp-compiler_p_2023.2.1.8.sh
   ```
   - **Intel OneAPI**:
     - Next >> Accept & customize >> Next
     - Altere o diretório de instalação para: `/usr/local/intel/oneapi`
     - Next >> Install >> Next
     - Marque a opção "I do not consent to the collection of my information"
     - Begin installation >> Close
   ```bash
   ./l_fortran-compiler_p_2023.2.1.8.sh
   ```
   - Repita os mesmos passos acima.
4. Configure o ambiente:
   ```bash
   source /usr/local/intel/oneapi/setvars.sh
   ```
5. Verifique a instalação:
   ```bash
   icc  # Verifica compilador C
   ifort  # Verifica compilador Fortran
   ```
6. Edite o script `instala_libs_intel.sh` na pasta `install_wrf`:
   ```bash
   nano instala_libs_intel.sh
   ```
   - Confirme que o caminho do `source` está correto:
     ```bash
     source /usr/local/intel/oneapi/setvars.sh
     ```
   - Ative as flags desejadas:
     ```bash
     ZLIB_FLAG=1
     NETCDF_F_FLAG=1
     ```
   - Salve (`Ctrl+O`) e saia (`Ctrl+X`).
7. Execute o script:
   ```bash
   ./instala_libs_intel.sh
   ```

## Baixando o WRF, WPS e Geog

1. Crie e entre na pasta de instalação:
   ```bash
   mkdir WRFv4.6.1 && cd WRFv4.6.1
   ```
2. Clone os repositórios:
   ```bash
   git clone https://github.com/wrf-model/WRF.git
   git clone https://github.com/wrf-model/WPS.git
   ```
3. Baixe e extraia os arquivos geográficos:
   ```bash
   wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz
   tar zxvf geog_low_res_mandatory.tar.gz
   ```
4. Organize os diretórios:
   ```bash
   mkdir DOMAINS && cd DOMAINS
   mkdir GRADE PREPROC RUN POSPROC
   ```

## Compilação do WRF

1. Configure o ambiente:
   ```bash
   cd install_wrf
   source setenv.sh
   ```
2. Compile o WRF:
   ```bash
   cd ../WRF
   ./configure
   ```
   - **Escolha a opção**: `16`
   - **Nesting**: `1` (ou outra opção conforme necessário)
   ```bash
   ./compile em_real
   ```
   - Se houver erro:
     ```bash
     apt install csh
     ./compile em_real
     ```

## Compilação do WPS

1. Configure e compile:
   ```bash
   cd ../WPS
   ./configure
   ```
   - **Escolha a opção**: `3`
   ```bash
   ./compile
   ```
## Instalação do GrADS e Ferret

1. Volte para `install_wrf` baixe e descompacte os arquivos:
   ```bash
   tar zxfv opengrads.tar.gz
   wget https://sourceforge.net/projects/opengrads/files/OpenGrADS%20-%20Binary/2.2.1.oga.1/opengrads-2.2.1.oga.1-bin.tar.gz/download -O opengrads.tar.gz
   
   wget https://github.com/NOAA-PMEL/Ferret/releases/download/v7.6.0/ferret-7.6.0-RHEL7-64.tar.gz
   tar zxfv ferret7.6.0.tar.gz
   ```
2. Mova para `/usr/local/`:
   ```bash
   su -
   (password)
   mv ferret /usr/local
   mv opengrads /usr/local
   ```

## Instalação do Anaconda3

1. Execute como `sudo`:
   ```bash
   su -
   (password)
   ```
2. Baixe na pasta `install_wrf` e execute:
   ```bash
   wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
   ./anaconda3-2023.09-0-Linux-x86_64.sh
   ```
   - **Aceite os termos**: `yes`
   - **Instale em**: `/usr/local/anaconda3`
   - **Finalize**: `yes`

4. Configure o ambiente:
   ```bash
   nano ~/.bashrc
   ```
   - Copie o bloco **`conda initialize`**
   ```bash
   nano /etc/bash.bashrc
   ```
   - Cole no final do arquivo e adicione:
     ```bash
     export PATH=/usr/local/opengrads:$PATH
     source /usr/local/ferret/bin/ferret_paths_template.sh
     ```
   - Salve (`Ctrl+O`) e saia (`Ctrl+X`).

5. Teste o GrADS e Ferret:
   ```bash
   grads
   ferret
   go tutorial
   ```



---


