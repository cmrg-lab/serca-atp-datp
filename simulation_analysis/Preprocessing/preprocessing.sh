cpptraj strip_script.in

awk 'NR>3' gamd.log | awk '{print ($8+$7)/(0.001987*300)" " $2 " " ($8+$7)}' > weights_ATP_original_GaMD_rep3.dat

cp weights_ATP_original_GaMD_rep3.dat /home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Weights
cp 3W5A_ATP_original_GaMD_rep3_strip_200.nc /home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories
cp 3W5A_ATP_original_GaMD_rep3_strip_200.parm7 /home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories

