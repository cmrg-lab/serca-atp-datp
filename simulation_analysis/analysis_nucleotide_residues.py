def analysis_nucleotide_residues(species, nucleotide, simulation, dat, length, rep):

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
	import itertools
	import csv

	file_path_traj = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.nc'
	file_path_parm = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/Stripped_Trajectories/' + '3W5A_' + nucleotide + '_' + species + '_' + simulation + '_' + rep + '_strip_' + length + '.parm7'
	# Load in stripped trajectories
	traj = md.load(file_path_traj, top = file_path_parm) 
	
	
	# Use selection criteria to find the atom indices of the regions of the domain that we care about
	#binding_site_inds = traj.top.select('resid 339 to 751')

	# Create a copy of the trajectory using only the specified indicies
	#binding_site = traj.atom_slice(binding_site_inds, inplace = False)
	
	# Compute distances between nucleotide and associated residues
	# Original

	if species == 'original':
		contacts_list = list(itertools.product([995], np.arange(0,994)))
	
	else:
		contacts_list = list(itertools.product([993], np.arange(0,992)))

	contact_dist, contacts_list = md.compute_contacts(traj, contacts_list, scheme = 'closest')
	
	#print(len(contact_dist))
		
	file_path_residue_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/residue_dist/' + nucleotide + '_residue_dist_' + simulation + '_' + species + '_' + rep + '.csv'	
	#file = open(file_path_residue_csv, "w+")
	#for i in range(1500):
#		for j in range(994):
#			content = str(contact_dist[i][j])
			#file.write(content + "\n")
#			file.write(content, delimiter = ',')
#	file.close()
	
	
	#ind = start-340
	#print(ind)
	
	#with open(file_path_residue_csv, 'w', newline='') as file:
	#	writer = csv.writer(file)
#		for i in range(len(contact_dist)):
#		writer.writerow(contact_dist[i])
			
	with open(file_path_residue_csv, 'w', newline='') as file:
		writer = csv.writer(file)
		for i in range(len(contact_dist)):
			writer.writerow(contact_dist[i])
			
	#with open(file_path_residue_csv, 'w', newline='') as file:
	#	writer = csv.writer(file)
	#	for i in range(len(contact_dist)):
	#		writer.writerow(contact_dist[i])
			
	#with open(file_path_residue_csv, 'w', newline='') as file:
	#	writer = csv.writer(file)
	#	for i in range(len(contact_dist)):
	#		writer.writerow(contact_dist[i])
			
	#with open(file_path_residue_csv, 'w', newline='') as file:
	#	writer = csv.writer(file)
	#	for i in range(len(contact_dist)):
	#		writer.writerow(contact_dist[i])		

"""
	# File path for writing out
	file_path_515_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/515_dist/' + nucleotide + '_515_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_487_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/487_dist' + nucleotide + '_487_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_626_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/626_dist/' + nucleotide + '_626_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_353_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/353_dist/' + nucleotide + '_353_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_494_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/494_dist/' + nucleotide + '_494_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_489_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/489_dist/' + nucleotide + '_489_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	file_path_678_csv = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/678_dist/' + nucleotide + '_678_dist_' + simulation + '_' + species + '_' + rep + '.csv'
	
	file_path_515_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/515_dist/' + nucleotide + '_515_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_487_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/487_dist/' + nucleotide + '_487_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_560_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/560_dist/' + nucleotide + '_560_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_626_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/626_dist/' + nucleotide + '_626_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_353_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/353_dist/' + nucleotide + '_353_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_494_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/494_dist/' + nucleotide + '_494_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_489_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/489_dist/' + nucleotide + '_489_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	file_path_678_dat = '/home/abby/Dropbox/Lab/SERCA/3W5A/ATP_dATP_comparison_GaMD_3_reps/678_dist/' + nucleotide + '_678_dist_' + simulation + '_' + species + '_' + rep + '.dat'
	# Write as csv
	file = open(file_path_515_csv, "w+")
	for i in contact_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()


	file = open(file_path_487_csv, "w+")
	for i in Residue_487_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()

	file = open(file_path_560_csv, "w+")
	for i in Residue_560_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_626_csv, "w+")
	for i in Residue_626_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_353_csv, "w+")
	for i in Residue_353_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_494_csv, "w+")
	for i in Residue_494_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_489_csv, "w+")
	for i in Residue_489_dist:
		content = str(i)
		file.write(content + "\n")
	file.close()
	
	file = open(file_path_678_csv, "w+")
	for i in Residue_678_dist:
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

		
		file = open(file_path_515_dat, "w+")
		for i in Residue_515_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()

		file = open(file_path_487_dat, "w+")
		for i in Residue_487_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()

		file = open(file_path_560_dat, "w+")
		for i in Residue_560_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		file = open(file_path_626_dat, "w+")
		for i in Residue_626_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		file = open(file_path_353_dat, "w+")
		for i in Residue_353_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		file = open(file_path_494_dat, "w+")
		for i in Residue_494_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		file = open(file_path_489_dat, "w+")
		for i in Residue_489_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		file = open(file_path_678_dat, "w+")
		for i in Residue_678_dist[array_bound_lower:array_bound_upper]:
			content = str(i)
			file.write(content + "\n")
		file.close()	
		
		
		
	
	
	
		Residue_515_dist = md.compute_contacts(traj, [[995,514],[995,486],[995,559],[995,625],[995,352],[995,493],[995,488],[995,677]], scheme='closest')
		#Residue_487_dist = md.compute_contacts(traj, [996,487], scheme='closest')
		#Residue_560_dist = md.compute_contacts(traj, [996,560], scheme='closest')
		#Residue_626_dist = md.compute_contacts(traj, [996,626], scheme='closest')
		#Residue_353_dist = md.compute_contacts(traj, [996,353], scheme='closest')
		#Residue_494_dist = md.compute_contacts(traj, [996,494], scheme='closest')
		#Residue_489_dist = md.compute_contacts(traj, [996,489], scheme='closest')
		#Residue_678_dist = md.compute_contacts(traj, [996,678], scheme='closest')
	
	# Human
	else:
		Residue_515_dist = md.compute_contacts(traj, [994,514], scheme='closest')
		Residue_487_dist = md.compute_contacts(traj, [994,487], scheme='closest')
		Residue_560_dist = md.compute_contacts(traj, [994,559], scheme='closest')
		Residue_626_dist = md.compute_contacts(traj, [994,625], scheme='closest')
		Residue_353_dist = md.compute_contacts(traj, [994,353], scheme='closest')
		Residue_494_dist = md.compute_contacts(traj, [994,494], scheme='closest')
		Residue_489_dist = md.compute_contacts(traj, [994,489], scheme='closest')
		Residue_678_dist = md.compute_contacts(traj, [994,678], scheme='closest')
"""
