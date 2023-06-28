def analysis_H_bond(species, nucleotide, simulation, dat, length, rep):

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
	binding_pocket_inds = traj.top.select('resid 400 to 993')

	# Create a copy of the trajectory using only the specified indicies
	binding_pocket = traj.atom_slice(binding_pocket_inds, inplace = False)
	
	# Find H bonds
	hbonds = md.baker_hubbard(binding_pocket, periodic=False)
	label = lambda hbond : '%s -- %s' % (binding_pocket.top.atom(hbond[0]), binding_pocket.top.atom(hbond[2]))
	for hbond in hbonds:
    		print(label(hbond))
