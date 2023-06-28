def analysis_RMSD(species, nucleotide, simulation, dat, length, rep):

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
	
	# Compute RMSF
	RMSF = md.rmsf(traj, traj, frame = 0, atom_indices=traj.top.select('name CA'))
	
	# Compute RMSD
	RMSD = md.rmsd(traj, traj, frame = 0, atom_indices=traj.top.select('protein'))
	
	# Compute RMSD of just nucleotide 
	if nucleotide == 'ATP' or nucleotide == 'dATP':
		if species == 'original':
			RMSD_nucleotide = md.rmsd(traj, traj, frame = 0, atom_indices=traj.top.select('resid 995'))
		
		else:
			RMSD_nucleotide = md.rmsd(traj, traj, frame = 0, atom_indices=traj.top.select('resid 993'))


	# File path for writing out
	file_path_RMSF_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSF/' + nucleotide + '_RMSF_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_RMSD_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSD/' + nucleotide + '_RMSD_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_RMSD_nucleotide_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSD/' + nucleotide + '_RMSD_nucleotide_' + simulation + '_' + species + '_' + rep + '.csv'
	
	file_path_RMSF_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSF/' + nucleotide + '_RMSF_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_RMSD_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSD/' + nucleotide + '_RMSD_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_RMSD_nucleotide_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/RMSD/' + nucleotide + '_RMSD_nucleotide_' + simulation + '_' + species + '_' + rep + '.dat'

	# Write as csv
	file = open(file_path_RMSF_csv, "w+")
	for i in RMSF:
		content = str(i)
		file.write(content + "\n")
	file.close()

	file = open(file_path_RMSD_csv, "w+")
	for i in RMSD:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_RMSD_nucleotide_csv, "w+")
	for i in RMSD_nucleotide:
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

		
		file = open(file_path_RMSF_dat, "w+")
		for i in RMSF[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()

		file = open(file_path_RMSD_dat, "w+")
		for i in RMSD[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()
		
		file = open(file_path_RMSD_nucleotide_dat, "w+")
		for i in RMSD_nucleotide[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()
