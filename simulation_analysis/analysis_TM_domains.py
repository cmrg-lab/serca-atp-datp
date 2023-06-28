def analysis_TM_domains(species, nucleotide, simulation, dat, length, rep):

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
	#Helix_5_inds = traj.top.select('resid 740 to 781')
	#Helix_6_inds = traj.top.select('resid 789 to 809')    
	#Helix_8_inds = traj.top.select('resid 888 to 916')  

	# Create a copy of the trajectory using only the specified indicies
	#Helix_5 = traj.atom_slice(Helix_5_inds, inplace = False)
	#Helix_6 = traj.atom_slice(Helix_6_inds, inplace = False)
	#Helix_8 = traj.atom_slice(Helix_8_inds, inplace = False)

	# Compute the center of mass of the specified domains and calculate the euclidian distance between the centers of mass.
	#Helix_5_6_dist = np.linalg.norm(md.compute_center_of_mass(Helix_5) - md.compute_center_of_mass(Helix_6), axis  = 1)
	#Helix_5_8_dist = np.linalg.norm(md.compute_center_of_mass(Helix_5) - md.compute_center_of_mass(Helix_8), axis  = 1)
	#Helix_6_8_dist = np.linalg.norm(md.compute_center_of_mass(Helix_6) - md.compute_center_of_mass(Helix_8), axis  = 1)
	
	
	# Compute distances between specific residues
	if species == 'human':
		contact_dist, contacts_list = md.compute_contacts(traj, [[906,797], [906,769], [797,769], [701,350], [48,105], [50,108]], scheme = 'closest')
		contact_dist_907_798, contacts_list = md.compute_contacts(traj, [[906,797]], scheme = 'closest') #TM6-TM8
		contact_dist_907_770, contacts_list = md.compute_contacts(traj, [[906,769]], scheme = 'closest') #TM5-TM8
		contact_dist_798_770, contacts_list = md.compute_contacts(traj, [[797,769]], scheme = 'closest') #TM5-TM6
		contact_dist_49_106, contacts_list = md.compute_contacts(traj, [[48,105]], scheme = 'closest') #TM1-TM2
		contact_dist_51_109, contacts_list = md.compute_contacts(traj, [[50,108]], scheme = 'closest') #TM1-TM2
		contact_dist_703_351, contacts_list = md.compute_contacts(traj, [[701,350]], scheme = 'closest') #TM1-TM2
		contact_dist_351, contacts_list = md.compute_contacts(traj, [[993,350]], scheme = 'closest') #TM1-TM2

	
	else:
		contact_dist, contacts_list = md.compute_contacts(traj, [[907,798], [907,770], [798,770], [702,350], [48,105], [50,108]], scheme = 'closest')
		contact_dist_907_798, contacts_list = md.compute_contacts(traj, [[907,798]], scheme = 'closest') #TM6-TM8
		contact_dist_907_770, contacts_list = md.compute_contacts(traj, [[907,770]], scheme = 'closest') #TM5-TM8
		contact_dist_798_770, contacts_list = md.compute_contacts(traj, [[798,770]], scheme = 'closest') #TM5-TM6
		contact_dist_49_106, contacts_list = md.compute_contacts(traj, [[48,105]], scheme = 'closest') #TM1-TM2
		contact_dist_51_109, contacts_list = md.compute_contacts(traj, [[50,108]], scheme = 'closest') #TM1-TM2
		contact_dist_703_351, contacts_list = md.compute_contacts(traj, [[702,350]], scheme = 'closest') #TM1-TM2
		contact_dist_351, contacts_list = md.compute_contacts(traj, [[995,350]], scheme = 'closest') #TM1-TM2
	

	# File path for writing out
	#file_path_5_6_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/5_6_dist/' + nucleotide + '_5_6_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	#file_path_5_8_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/5_8_dist/' + nucleotide + '_5_8_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	#file_path_6_8_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/6_8_dist/' + nucleotide + '_6_8_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	
	#file_path_5_6_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/5_6_dist/' + nucleotide + '_5_6_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	#file_path_5_8_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/5_8_dist/' + nucleotide + '_5_8_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	#file_path_6_8_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/6_8_dist/' + nucleotide + '_6_8_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	
	file_path_dist_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/residue_dist/' + nucleotide + '_TM_residue_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	
	file_path_dist_dat_907_798 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/907_798_dist/' + nucleotide + '_907_798_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_907_770 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/907_770_dist/' + nucleotide + '_907_770_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_798_770 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/798_770_dist/' + nucleotide + '_798_770_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_49_106 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/49_106_dist/' + nucleotide + '_49_106_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_51_109 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/51_109_dist/' + nucleotide + '_51_109_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_703_351 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/703_351_dist/' + nucleotide + '_703_351_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_dist_dat_351 = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/351_dist/' + nucleotide + '_351_dist_' + simulation + '_' + species + '_' + rep + '.dat'
		
	# Write as csv
	#file = open(file_path_5_6_csv, "w+")
	#for i in Helix_5_6_dist:
	#	content = str(i)
	#	file.write(content + "\n")
	#file.close()

	#file = open(file_path_5_8_csv, "w+")
	#for i in Helix_5_8_dist:
	#	content = str(i)
	#	file.write(content + "\n")
	#file.close()

	#file = open(file_path_6_8_csv, "w+")
	#for i in Helix_6_8_dist:
	#	content = str(i)
	#	file.write(content + "\n")
	#file.close()

	
	with open(file_path_dist_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		for i in range(len(contact_dist)):
			writer.writerow(contact_dist[i])

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

		
		#file = open(file_path_5_6_dat, "w+")
		#for i in Helix_5_6_dist[array_bound_lower:array_bound_upper]:
		#	content = str(i)
		#	file.write(content + "\n")
		#file.close()

		#file = open(file_path_5_8_dat, "w+")
		#for i in Helix_5_8_dist[array_bound_lower:array_bound_upper]:
		#	content = str(i)
		#	file.write(content + "\n")
		#file.close()

		#file = open(file_path_6_8_dat, "w+")
		#for i in Helix_6_8_dist[array_bound_lower:array_bound_upper]:
		#	content = str(i)
		#	file.write(content + "\n")
		#file.close()
		
		with open(file_path_dist_dat_907_798, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_907_798[i])
				
		with open(file_path_dist_dat_907_770, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_907_770[i])
						
		with open(file_path_dist_dat_798_770, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_798_770[i])
		
		with open(file_path_dist_dat_49_106, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_49_106[i])
				
		with open(file_path_dist_dat_51_109, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_51_109[i])
				
				
		with open(file_path_dist_dat_703_351, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_703_351[i])
				
				
		with open(file_path_dist_dat_351, 'w', newline='') as file:
			writer = csv.writer(file)
			for i in range(array_bound_lower,array_bound_upper):
				writer.writerow(contact_dist_351[i])		

