def analysis_cytosolic_domains(species, nucleotide, simulation, dat, length, rep):

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

	file_path_traj = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.nc'
	file_path_parm = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.parm7'

	# Load in stripped trajectories
	traj = md.load(file_path_traj, top = file_path_parm) 

	# Use selection criteria to find the atom indices of the regions of the domain that we care about
	IM_domain_inds = traj.top.select('resid 40 to 125 or resid 740 to 991 or resid 240 to 340')
	A_domain_inds = traj.top.select('resid 0 to 40 or resid 125 to 240')
	P_domain_inds = traj.top.select('resid 600 to 740 or resid 340 to 355')
	N_domain_inds = traj.top.select('resid 355 to 600')

	# Create a copy of the trajectory using only the specified indicies
	IM_domain = traj.atom_slice(IM_domain_inds, inplace = False)
	A_domain = traj.atom_slice(A_domain_inds, inplace = False)
	P_domain = traj.atom_slice(P_domain_inds, inplace = False)
	N_domain = traj.atom_slice(N_domain_inds, inplace = False)

	# Compute the center of mass of the specified domains and calculate the euclidian distance between the centers of mass.
	A_N_dist = np.linalg.norm(md.compute_center_of_mass(A_domain) - md.compute_center_of_mass(N_domain), axis  = 1)
	A_P_dist = np.linalg.norm(md.compute_center_of_mass(A_domain) - md.compute_center_of_mass(P_domain), axis  = 1)
	N_P_dist = np.linalg.norm(md.compute_center_of_mass(N_domain) - md.compute_center_of_mass(P_domain), axis  = 1)


	# File path for writing out
	file_path_A_N_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/A_N_dist/' + nucleotide + '_A_N_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_A_P_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/A_P_dist/' + nucleotide + '_A_P_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_N_P_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/N_P_dist/' + nucleotide + '_N_P_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	
	file_path_A_N_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/A_N_dist/' + nucleotide + '_A_N_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_A_P_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/A_P_dist/' + nucleotide + '_A_P_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_N_P_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/N_P_dist/' + nucleotide + '_N_P_dist_' + simulation + '_' + species + '_' + rep + '.dat'

	# Write as csv
	file = open(file_path_A_N_csv, "w+")
	for i in A_N_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()

	file = open(file_path_A_P_csv, "w+")
	for i in A_P_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()

	file = open(file_path_N_P_csv, "w+")
	for i in N_P_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()

	# Write as dat for reweighting
	if dat == 1:
		if length == 100: # GaMD rep 1
			if nucleotide == 'Apo': # Apo
				array_bound_lower = 5000
				array_bound_upper = 10560
			else:	# ATP and dATP
				array_bound_lower = 120
				array_bound_upper = 5680
		elif length == 200: # GaMD rep 2 and rep 3
			array_bound_lower = 120
			array_bound_upper = 10680
		else: # GaMD rep 1 ext
			array_bound_lower = 0
			array_bound_upper = 5000

		
		file = open(file_path_A_N_dat, "w+")
		for i in A_N_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()

		file = open(file_path_A_P_dat, "w+")
		for i in A_P_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()

		file = open(file_path_N_P_dat, "w+")
		for i in N_P_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()		

