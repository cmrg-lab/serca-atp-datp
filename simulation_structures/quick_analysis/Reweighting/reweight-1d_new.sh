####################################################
# Prepare input file "weights.dat" in the following format: 
# Column 1: dV in units of kbT; column 2: timestep; column 3: dV in units of kcal/mol

# For AMBER14: 
# awk 'NR%1==0' amd.log | awk '{print ($8+$7)/(0.001987*300)" " $2 " " ($8+$7)}' > weights.dat

# also need input file i.e. rmsd or distances from dist.py (as .dat file)

# visualize with xmgrace

#!/bin/bash
dir_codes=./
Emax=$1
cutoff=$2
binx=$3
data=$4
T=$5

echo "Usage: reweight-1d.sh $Emax $cutoff $binx $data $T"

# Reweighting using cumulant expansion 
echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight_CE -weight weights.dat | tee -a reweight_variable.log"
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight_CE -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-c1-$data.xvg pmf-c1-$data-reweight-disc$binx.dat.xvg
mv -v pmf-c2-$data.xvg pmf-c2-$data-reweight-disc$binx.dat.xvg
mv -v pmf-c3-$data.xvg pmf-c3-$data-reweight-disc$binx.dat.xvg

echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight -weight weights.dat" | tee -a reweight_variable.log
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-$data.xvg pmf-$data-noweight-disc$binx.dat.xvg

echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight" | tee -a reweight_variable.log
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job noweight | tee -a reweight_variable.log
mv -v pmf-$data.xvg pmf-$data-noweight-disc$binx.dat.xvg

echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job histo -weight weights.dat" | tee -a reweight_variable.log
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job histo -weight weights.dat | tee -a reweight_variable.log
mv -v histo-$data.xvg histo-$data-disc$binx.dat.xvg

echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amd_dV -weight weights.dat" | tee -a reweight_variable.log
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amd_dV -weight weights.dat | tee -a reweight_variable.log

echo "python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight -weight weights.dat" | tee -a reweight_variable.log
python3 $dir_codes/PyReweighting-1D.py -input $data -T $T -disc $binx -Emax $Emax -cutoff $cutoff -job amdweight -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-$data.xvg pmf-$data-amdweight-disc$binx.dat.xvg


