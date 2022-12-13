# Compute distances between TM helices and write to text file for reweighting
import mdtraj as md
import numpy as np
import matplotlib.pyplot as plt
import os
import json

# Load in trajectory 
#ATP_3W5A_MD_original = md.load('3W5A_ATP_original_strip_150.nc',top = '3W5A_ATP_original_strip_top.parm7')
ATP_3W5A_original = md.load('3W5A_ATP_original_GaMD_strip_100ns.nc',top = '3W5A_ATP_original_GaMD_strip_top.parm7')

# Combine MD + GaMD
#ATP_3W5A_original = md.join(ATP_3W5A_MD_original,ATP_3W5A_GaMD_original, discard_overlapping_frames=False)

# Use selection criteria to find the atom indices of the regions of the domain that we care about
IM_domain_inds = ATP_3W5A_original.top.select('resid 40 to 125 or resid 740 to 991 or resid 240 to 340')
A_domain_inds = ATP_3W5A_original.top.select('resid 0 to 40 or resid 125 to 240')
P_domain_inds = ATP_3W5A_original.top.select('resid 600 to 740 or resid 340 to 355')
N_domain_inds = ATP_3W5A_original.top.select('resid 355 to 600')

# Create a copy of the trajectory using only the specified indicies
IM_domain = ATP_3W5A_original.atom_slice(IM_domain_inds, inplace = False)
A_domain = ATP_3W5A_original.atom_slice(A_domain_inds, inplace = False)
P_domain = ATP_3W5A_original.atom_slice(P_domain_inds, inplace = False)
N_domain = ATP_3W5A_original.atom_slice(N_domain_inds, inplace = False)

# Compute the center of mass of the specified domains and calculate the euclidian distance between the centers of mass.
ATP_A_N_dist_original = np.linalg.norm(md.compute_center_of_mass(A_domain) - md.compute_center_of_mass(N_domain), axis  = 1)
ATP_A_P_dist_original = np.linalg.norm(md.compute_center_of_mass(A_domain) - md.compute_center_of_mass(P_domain), axis  = 1)
ATP_N_P_dist_original = np.linalg.norm(md.compute_center_of_mass(N_domain) - md.compute_center_of_mass(P_domain), axis  = 1)

file = open("A_N_dist.dat", "w+")
for i in ATP_A_N_dist_original:
	content = str(i)
	file.write(content + "\n")
file.close()

file = open("A_P_dist.dat", "w+")
for i in ATP_A_P_dist_original:
	content = str(i)
	file.write(content + "\n")
file.close()

file = open("N_P_dist.dat", "w+")
for i in ATP_N_P_dist_original:
	content = str(i)
	file.write(content + "\n")
file.close()


