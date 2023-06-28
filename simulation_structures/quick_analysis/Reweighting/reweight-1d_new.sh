####################################################
# Prepare input file "weights.dat" in the following format: 
# Column 1: dV in units of kbT; column 2: timestep; column 3: dV in units of kcal/mol

# For AMBER14: 
# awk 'NR%1==0' amd.log | awk '{print ($8+$7)/(0.001987*300)" " $2 " " ($8+$7)}' > weights.dat

# also need input file i.e. rmsd or distances from dist.py (as .dat file) --> A_N_dist.dat *needs to have same length as weights

# visualize with xmgrace

#!/bin/bash
dir_codes=./
Emax=$1
cutoff=$2
binx=$3
data=$4
T=$5

echo "Usage: reweight-1d.sh $Emax $cutoff $binx $data $T"
# Emax = 30
# cutoff = 10 (default)
# binx = 6 (default)
# data = A_N_dist.dat
# T = 300 (default)

# Reweighting using cumulant expansion 
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight_CE -weight weights.dat 

python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight -weight weights.dat 

python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight 

python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job histo -weight weights.dat 

python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amd_dV -weight weights.dat 

python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight -weight weights.dat 


