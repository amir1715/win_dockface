@echo off
:opth
color 4f
cls
echo DEPARTMENT OF MEDICINAL CHEMISTRY, FACULTY OF PHARMACY, SHIRAZ, IRAN && echo.
echo An easy to use interface to autodock 4 and autodock vina modules
echo  ---  -    - -----  ----  ----    ----   ----  -  --
echo -   - -    -   -   -    - -   -  -    - -      - -
echo -   - -    -   -   -    - -    - -    - -      --
echo ----- -    -   -   -    - -    - -    - -      --
echo -   - -    -   -   -    - -   -  -    - -      - --
echo -   -  ----    -    ----  ----    ----   ----  -  -- && echo.
echo It is highly recommended to do all preparation procedures using this interfaces
echo mgltools 1.5.6 must be installed
echo For any help and support please send an email to :asakhteman@sums.ac.ir && echo.
pause
set number=1
set fl= -x flexible.pdbqt
cls
color 0f
reg query HKLM\SOFTWARE\dockface /v rec_prep
if %ERRORLEVEL%==1 (
goto pat
) else (
cls
goto set
)
reg query HKLM\SOFTWARE\dockface /v lig_prep
if %ERRORLEVEL%==1 (
goto pat
) else (
cls
goto set
)
reg query HKLM\SOFTWARE\dockface /v gpf_prep
if %ERRORLEVEL%==1 (
goto pat
) else (
cls
goto set
)
reg query HKLM\SOFTWARE\dockface /v dpf_prep
if %ERRORLEVEL%==1 (
goto pat
) else (
cls
goto set
)

:set
set KEY=HKEY_LOCAL_MACHINE\Software\dockface
for /f "tokens=2,*" %%a in ('reg query %KEY% /v rec_prep ^| findstr rec_prep') do (
set rec_prep=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v flex_rec_prep ^| findstr flex_rec_prep') do (
set flex_rec_prep=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v lig_prep ^| findstr lig_prep') do (
set lig_prep=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v gpf_prep ^| findstr gpf_prep') do (
set gpf_prep=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v dpf_prep ^| findstr dpf_prep') do (
set dpf_prep=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v pyth ^| findstr pyth') do (
set pyth=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v gridpat ^| findstr gridpat') do (
set gridpat=%%b
)
for /f "tokens=2,*" %%a in ('reg query %KEY% /v babelpat ^| findstr babelpat') do (
set babelpat=%%b
)
set PATH=%pyth%;%gridpat%;%babelpat%
cls
goto opt0

:pat
echo ### MGLTOOLS PARAMETERS ### && echo.
set /p passw=Please Enter the password:
if not %passw%==shirazpharmacy (
echo the password is wrong
echo please send an email to asakhteman@razi.tums.ac.ir for the password
pause
exit
)

:pyth
set pyth=C:\Program Files\MGLTools-1.5.6
echo %pyth%
set /p pyth=please write the path to mgltool:
if not exist "%pyth%\python.exe" (
cls
goto pyth
)

:gridpat
set gridpat=C:\windows\system32
echo %gridpat%
set /p gridpat=please write the path to autogrid,autodock and vina if other than above:
if not exist "%gridpat%\autogrid*" (
cls
echo autogrid was not found
echo you can not run autogrid
pause
)
if not exist "%gridpat%\autodock*" (
cls
echo autodock was not found
echo you can not run autodock
pause
)
if not exist "%gridpat%\vina*" (
cls
echo vina was not found
echo you can not run vina
pause
)
:babelpat
set babelpat=C:\Program Files\OpenBabel-2.3.1
echo %babelpat%
set /p babelpat=please write the path to open babel:
if not exist "%babelpat%\babel.exe" (
cls
echo babel was not found
echo you can not run babel 
pause
)

reg add HKLM\Software\dockface /v babelpat /t REG_SZ /d "%babelpat%"
reg add HKLM\Software\dockface /v gridpat /t REG_SZ /d "%gridpat%"
reg add HKLM\Software\dockface /v pyth /t REG_SZ /d "%pyth%"
set rec_prep=%pyth%\Lib\site-packages\AutoDockTools\Utilities24\prepare_receptor4.py
reg add HKLM\Software\dockface /v rec_prep /t REG_SZ /d "%rec_prep%"
set flex_rec_prep=%pyth%\Lib\site-packages\AutoDockTools\Utilities24\prepare_flexreceptor4.py
reg add HKLM\Software\dockface /v flex_rec_prep /t REG_SZ /d "%flex_rec_prep%"
set gpf_prep=%pyth%\Lib\site-packages\AutoDockTools\Utilities24\prepare_gpf4.py
reg add HKLM\Software\dockface /v gpf_prep /t REG_SZ /d "%gpf_prep%"
set lig_prep=%pyth%\Lib\site-packages\AutoDockTools\Utilities24\prepare_ligand4.py
reg add HKLM\Software\dockface /v lig_prep /t REG_SZ /d "%lig_prep%"
set dpf_prep=%pyth%\Lib\site-packages\AutoDockTools\Utilities24\prepare_dpf42.py
reg add HKLM\Software\dockface /v dpf_prep /t REG_SZ /d "%dpf_prep%"
cls

:opt0
color 0f
echo ######## TASKS MENU ######## && echo.
echo press [1] FOR LIGANDs  PREPARATION
echo press [2] FOR RECEPTOR PREPARATION 
echo press [3] For VIRTUAL SCREENING USING AUTODOCK 4 
echo press [4] For VIRTUAL SCREENING USING AUTODOCK VINA  
echo press [h] For Help and support
echo press [d] To  Reinstall dockface
echo press [e] To  Exit
set task=1
set /p task=select one of the above operations:
goto opt%task%
:optd
reg delete HKLM\SOFTWARE\dockface /f
cls
goto pat


:opt2
cls
echo Press [1] FOR CONVERSION OF PDB TO PDBQT
echo press [2] FOR PREPARATION OF flexible.pdbqt and rigid.pdbqt
echo press [3] FOR GOING TO MAIN MENU
set /p number=select one of the above operations:
goto docktype%number%

:docktype3
cls
goto opt0
:docktype1
set /p  name=insert the complete receptor name for examplpe rec.pdb?
if not exist %name% goto docktype1
"%pyth%\python.exe" "%rec_prep%" -r %name% -A hydrogens

pause
cls
goto opt0

:docktype2
set /p name=insert the receptor pdbqt name for example rec.pdbqt?
if not exist %name% goto docktype2
set /p flexpart=Define flexible residues for example (TYR121_TRP118)?
"%pyth%\python.exe" "%flex_rec_prep%" -r %name% -s %flexpart% -g rigid.pdbqt -x flexible.pdbqt
set number=2
echo the two files rigid.pdbqt and flexible.pdbqt must have been generated
pause
cls
goto opt0

:opt1
cls
echo ######## LIGAND PREPARATION ######## && echo.
echo press [1] FOR 2D cdx to 3D mol2 conversions
echo press [2] For EMBL 1D smiles to 3D mol2 conversions
echo press [3] FOR USING MGLTOOLS in preparation of pdbqts
echo press [4] FOR GOING TO MAIN MENU
set proceed=1
set /p proceed=select one of the above operations:
goto ligp%proceed%

:ligp1
echo Please wait for file conversions
echo the ligands are being converted from %inp% to %kh%
   for %%A IN (*.cdx) do (
   babel  --gen3d  -i cdx %%A -o mol2 %%~nA.mol2
   )
cls
goto opt1

:ligp2
color 4f
cls
echo The structure mol2 files will be generated from the input.txt file
echo open babel should be installed
echo The input text file should include at least two columns
echo with the below format && echo.
echo compoundname  SMILES_code   --  -- -- && echo.
pause
:namenon
cls
set /p name=insert the input file name for example input.txt?
if not exist %name% (
echo %name% does not exist
pause
goto namenon
) 
for /f "tokens=1,2" %%a in (%name%) do (
echo %%a
echo %%b >%%a.smi
babel --join --gen3d -i smi %%a.smi -o mol2 %%a.mol2
del %%a.smi
)
goto opt1



:ligpbab
cls
set m=1
set babel=1
echo ####### USING BABEL FOR CONVERSION ######### && echo.
color 4F
set /p inp=Enter the format of your input ligands for example mol2 cdx etc?
set /p kh=Enter the format of your output ligands:
echo Please wait for file conversions
echo the ligands are being converted from %inp% to %kh%
   for %%A IN (*.%inp%) do (
   babel  --gen3d  -i %inp% %%A -o %kh% %%~nA.%kh%
   )
cls
goto opt1

:ligp3
cls
set prref=lig
set /p inp=Enter the format of your input ligands for example mol2 pdb?
set /p prref=Enter the prefix before ligand name default is lig:
   for %%A IN (*.%inp%) do (
   "%pyth%\python.exe" "%lig_prep%" -l %%A -o %prref%%%~nA.pdbqt
   )
cls
goto opt0

:ligp4
cls
goto opt0

:opt4
cls
color 2F
echo VIRTUAL LIGAND SCREENING using vina
pause
if not exist *.pdbqt (
cls
echo no pdbqts were found && echo.
color 0f
goto opt0
)
cls
set cnf=1
echo #######2) PREAPARING conf.txt FOR RUNNING VINA VLS ######### && echo.
set /p cnf= By defult we Use an existing conf.txt? press 2 to make a new one:
if %cnf%==2 echo ########REQUIRED PARAMETERS########### && echo.
set exh=8
set boxx=50
set boxy=50
set boxz=50
set nummode=0
set energy=0
set cpu=0
set flex=0
if %number%==2 (
set flex=flexible.pdbqt
set receptor=rigid.pdbqt
echo FLEXIBLE DOCKING IS TO BE PERFORMED
goto jumpasking
)
if %cnf%==2 echo. && set /p  receptor= Enter the receptor pdbqt full name or rigid.pdbqt (REQUIRED*):
if %cnf%==2 set /p  flex= Enter the flexible pdbqt name (press ENTER for rigid docking):
:jumpasking
if %cnf%==2 echo. && set /p  boxx= Enter the box size in x dimension (press ENTER for Default value=50):
if %cnf%==2 set /p  boxy= Enter the box size in y dimension (press ENTER for Default value=50):
if %cnf%==2 set /p  boxz= Enter the box size in z dimension (press ENTER for Default value=50):
if %cnf%==2 echo. && set /p  centerx= Enter the center of box in x dimension (REQUIRED*):
if %cnf%==2 set /p  centery= Enter the center of box in y dimension (REQUIRED*):
if %cnf%==2 set /p  centerz= Enter the center of box in z dimension (REQUIRED*):
if %cnf%==2 cls
if %cnf%==2 echo ########OPTIONAL PARAMETERS########### && echo.
if %cnf%==2 set /p  exh= Enter Exhaustiveness (press ENTER for Default value=8):
if %cnf%==2 set /p  nummode= Enter Number of modes (press ENTER for default value=9):
if %cnf%==2 set /p  energy= Enter Energy range (press ENTER for default value=3):
if %cnf%==2 set /p  cpu= Enter Number of CPUs (press ENTER for default value):
if %cnf%==2 (
echo receptor = %receptor%                        > conf.txt
if not %flex%==0  echo flex = %flex%             >> conf.txt
echo center_x = %centerx%                        >> conf.txt
echo center_y = %centery%                        >> conf.txt
echo center_z = %centerz%                        >> conf.txt
echo size_x = %boxx%                             >> conf.txt
echo size_y = %boxy%                             >> conf.txt
echo size_z = %boxz%                             >> conf.txt
echo exhaustiveness = %exh%                      >> conf.txt
if not %nummode%==0 echo num_modes = %nummode%   >> conf.txt
if not %energy%==0 echo energy_range = %energy%  >> conf.txt
if not %cpu%==0  echo cpu = %cpu%                >> conf.txt
)
cls
set shat=n
set /p shat=To shut down the computer after the job,press S before ENTER?
cls
echo the following parameters will be used: && echo.
type conf.txt && echo.
pause
:://///Runing VINA
cls
color 1f
rd /S /Q results
mkdir results
for %%A IN (*.pdbqt) do (
vina --config conf.txt --ligand %%A --log %%A.txt
echo %%A is finished
if exist *out*.pdbqt (
mkdir results\%%~nA
move *out*.pdbqt results\%%~nA
)
)
if %shat%==s shutdown /s
echo  FINISHED
pause
goto opt0

:opte
Exit

:error
cls
echo no pdbs were found && echo.
color 0f
goto opt0

:opt3
CLS
echo ######## AutoDock4 ######## && echo.
echo press [1] FOR AUTOGRID
echo press [2] FOR AUTODOCK 
echo press [3] FOR GOING TO MAIN MENU
set docking=1
set /p docking=select one of the above operations:
goto dc%docking%

:dc3
cls
goto opt0

:dc1
echo IN CASE OF FLEXIBLE DOCKING THE RECEPTOR SHOULD BE THE RIGID PART
if %number%==2 (
set name=rigid
echo FLEXIBLE DOCKING IS BEING PERFORMED
goto jump2
)
set /p name=insert the receptor name without extension for example rec?
if not exist %name%.pdbqt goto dc1
:jump2
set /p x=insert the grid size in X dimension?
set /p y=insert the grid size in Y dimension?
set /p z=insert the grid size in Z dimension?
cls
set /p xx=insert the grid center in X dimension?
set /p yy=insert the grid center in Y dimension?
set /p zz=insert the grid center in Z dimension?
"%pyth%\python.exe" "%gpf_prep%" -l %name%.pdbqt -r %name%.pdbqt -p npts=%x%,%y%,%z% -p gridcenter="%xx% %yy% %zz%" -p ligand_types="H,HS,HD,A,C,N,NA,NS,OA,F,SA,Cl,C,Br"
autogrid4 -p %name%.gpf -l %name%.glg
"%pyth%\python.exe" "%gpf_prep%" -l %name%.pdbqt -r %name%.pdbqt -p npts=%x%,%y%,%z% -p gridcenter="%xx% %yy% %zz%" -p ligand_types="OS,Mg,MG,P,S,Ca,CA,Mn,MN,Fe,FE,I,Zn,BR"
autogrid4 -p %name%.gpf -l %name%.glg
rd /S /Q mapdir
mkdir mapdir
move *map* mapdir
pause
cls
goto jump3

:dc2
cls
echo IN CASE OF FLEXIBLE DOCKING THE RECEPTOR SHOULD BE THE RIGID PART
if %number%==2 (
set name=rigid
echo FLEXIBLE DOCKING IS BEING PERFORMED
goto jump3
else (
echo Rigid Docking is to be performed
)
set /p name=insert the receptor name without extension for example rec.?
if not exist %name%.pdbqt goto dc2
:jump3
rd /S /Q results
rd /S /Q cpu*
mkdir results
set /p filetype=Please Define your ligands prefix if any?
set /p cpu=How many CPUs do you ask for?
cls
set param=1
echo ######## dpf file PARAMETERS ######## && echo.
echo press [1] FOR GENETIC ALGORITHM ^(DEFAULT^)
echo press [2] FOR ADVANCED USERS
set /p param=Choose one of the above:
goto method%param%

:method1
set ga_num=10
set /p ga_num=insert the the number of Runs default=10?
set num_energy=2500000
set /p num_energy=insert the number of energy evaluations default=2500000?
set num_pop=150
set /p num_pop=insert the number of initial population size default=150?
set dpf_param=-p ga_num_evals=%num_energy% -p  ga_pop_size=%num_pop% -p ga_run=%ga_num%
if %number%==2 set dpf_param=%dpf_param%%fl%
goto dpfrun

:method2
echo for example 
echo -S   for simulated annealing
echo -L   for local search
echo -p ga_pop_size=150 -p ga_run=10 -p ga_num_evals=2500000 -P YOUR OPTIONS
if %number%==1 echo -x flexible.pdbqt   FOR FLEXIBLE DOCKING
set /p dpf_param=write your own docking parametrs as above examples:
if %number%==2 set dpf_param=%dpf_param%%fl%
goto dpfrun

:dpfrun
::echo %dpf_param% | FINDSTR "-x" 
::if %errorlevel%==0 (
::set number=2
::echo Flexible Docking is to be performed
::)
 for %%A IN (%filetype%*.pdbqt) do (
 "%pyth%\python.exe" "%dpf_prep%" -l %%~nA.pdbqt -r %name%.pdbqt %dpf_param%
  echo %%A dpf was prepared
  )
setlocal enabledelayedexpansion
del main_run.bat
:: MAKING  BATCH FILES FOR EACH CPU 

for /L %%o IN (1,1,%cpu%) Do (
    mkdir cpu%%o
    
    if exist flexible.pdbqt  ( 
       if %number%==2 (
       copy flexible.pdbqt cpu%%o
       )
       ) 
    echo @echo off>cpu%%o.bat
    echo copy mapdir\* cpu%%o>>cpu%%o.bat
    echo echo cpu%%o is running>>cpu%%o.bat
    echo cd cpu%%o>>cpu%%o.bat
    echo for ^%%^%%A IN ^(*.dpf^) do ^(>>cpu%%o.bat
    echo echo ^%%^%%~nA is running>>cpu%%o.bat
    echo autodock4 -p ^%%^%%A -l ^%%^%%~nA.dlg>>cpu%%o.bat
    echo echo ^%%^%%~nA file was finished>>cpu%%o.bat
    echo mkdir ..\results\^%%^%%~nA>>cpu%%o.bat
    echo move ^%%^%%~nA.dlg ..\results\^%%^%%~nA>>cpu%%o.bat
    echo ^)>>cpu%%o.bat
    echo start cmd /c call cpu%%o.bat>>main_run.bat
    echo #replac/bin/bash>cpu%%o.lin
    echo cd cpu%%o>>cpu%%o.lin
    echo for i in ^*.dpf>>cpu%%o.lin
    echo do>>cpu%%o.lin
    echo autodock4 -p ^$i -l ^$i.dlg>>cpu%%o.lin
    echo done>>cpu%%o.lin
    
 )
set count=1
::SPLITTING THE LIGAND FILES
 for %%j IN (%filetype%*.pdbqt) DO (
 copy %%j cpu!count!
 copy %%~nj_%name%.dpf cpu!count!
 set /A count=!count!+1
   if !count! GTR %cpu% (
   set count=1
   )
 )
pause
main_run.bat
pause
cls
goto opt0