def analysis_SASA(species, nucleotide, simulation, dat, length, rep):

# species = original, human
# nucleotide = Apo, ATP, dATP
# simulation = MD, GaMD
# dat (write to dat if = 1)
# length = simulation length (100, 100_ext, 200)
# rep = replicate # (rep1, rep1_ext, rep2, rep3)

# Importing Necessary Modules
	import mdtraj as md
	import numpy as np
	import matplotlib.pyplot as plt
	import os
	import csv

	file_path_traj = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.nc'
	file_path_parm = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.parm7'

	# Load in stripped trajectories
	traj = md.load(file_path_traj, top = file_path_parm) 

	# Use selection criteria to find the atom indices of the regions of the domain that we care about
	binding_pocket_inds = traj.top.select('resid 350 to 706')
	Ca_site_I_inds_a = traj.top.select('resid 787 to 802')
	Ca_site_I_inds_b = traj.top.select('resid 763 to 776')
	Ca_site_I_inds_c = traj.top.select('resid 899 to 911')
	Ca_site_I_inds = np.concatenate((Ca_site_I_inds_a,Ca_site_I_inds_b,Ca_site_I_inds_c))

	# Create a copy of the trajectory using only the specified indicies
	binding_pocket = traj.atom_slice(binding_pocket_inds, inplace = False)
	Ca_site_I = traj.atom_slice(Ca_site_I_inds, inplace = False)

	# Compute SASA
	SASA = md.shrake_rupley(binding_pocket, mode='atom')
	SASA_Ca = md.shrake_rupley(Ca_site_I, mode='atom')
	

	# File path for writing out
	file_path_SASA_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/SASA/' + nucleotide + '_SASA_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_SASA_Ca_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/SASA/' + nucleotide + '_SASA_Ca_' + simulation + '_' + species + '_' + rep + '.csv'
	
	# Write as csv
	with open(file_path_SASA_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		for i in range(len(SASA)):
			writer.writerow(SASA[i])	
			
	# Write as csv
	with open(file_path_SASA_Ca_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		for i in range(len(SASA_Ca)):
			writer.writerow(SASA_Ca[i])

