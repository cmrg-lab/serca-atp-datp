from analysis_cytosolic_domains import *
from analysis_TM_domains import *
from analysis_nucleotide_residues import *
from analysis_RMSD import *
from analysis_SASA import *
from PyReweighting_1D import *
from analysis_H_bond import *


########Compute##################
# Compute cytosolic domain distances
#analysis_cytosolic_domains('original', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_cytosolic_domains('human', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_cytosolic_domains('original', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_cytosolic_domains('human', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_cytosolic_domains('original', 'dATP', 'MD', 0, '150', 'rep1')
#analysis_cytosolic_domains('human', 'dATP', 'MD', 0, '150', 'rep1')

#analysis_cytosolic_domains('original', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_cytosolic_domains('human', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_cytosolic_domains('original', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_cytosolic_domains('human', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_cytosolic_domains('original', 'dATP', 'GaMD', 1, '100', 'rep1')
#analysis_cytosolic_domains('human', 'dATP', 'GaMD', 1, '100', 'rep1')

#analysis_cytosolic_domains('original', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_cytosolic_domains('human', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_cytosolic_domains('original', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_cytosolic_domains('human', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_cytosolic_domains('original', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_cytosolic_domains('human', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')

#analysis_cytosolic_domains('original', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_cytosolic_domains('human', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_cytosolic_domains('original', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_cytosolic_domains('human', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_cytosolic_domains('original', 'dATP', 'GaMD', 1, '200', 'rep2')
#analysis_cytosolic_domains('human', 'dATP', 'GaMD', 1, '200', 'rep2')

#analysis_cytosolic_domains('original', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_cytosolic_domains('human', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_cytosolic_domains('original', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_cytosolic_domains('human', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_cytosolic_domains('original', 'dATP', 'GaMD', 1, '200', 'rep3')
#analysis_cytosolic_domains('human', 'dATP', 'GaMD', 1, '200', 'rep3')


# Compute TM helices distances
#analysis_TM_domains('original', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_TM_domains('human', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_TM_domains('original', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_TM_domains('human', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_TM_domains('original', 'dATP', 'MD', 0, '150', 'rep1')
#analysis_TM_domains('human', 'dATP', 'MD', 0, '150', 'rep1')

#analysis_TM_domains('original', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_TM_domains('human', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_TM_domains('original', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_TM_domains('human', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_TM_domains('original', 'dATP', 'GaMD', 1, '100', 'rep1')
#analysis_TM_domains('human', 'dATP', 'GaMD', 1, '100', 'rep1')

#analysis_TM_domains('original', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_TM_domains('human', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_TM_domains('original', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_TM_domains('human', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_TM_domains('original', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_TM_domains('human', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')

#analysis_TM_domains('original', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_TM_domains('human', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_TM_domains('original', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_TM_domains('human', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_TM_domains('original', 'dATP', 'GaMD', 1, '200', 'rep2')
#analysis_TM_domains('human', 'dATP', 'GaMD', 1, '200', 'rep2')

#analysis_TM_domains('original', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_TM_domains('human', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_TM_domains('original', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_TM_domains('human', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_TM_domains('original', 'dATP', 'GaMD', 1, '200', 'rep3')
#analysis_TM_domains('human', 'dATP', 'GaMD', 1, '200', 'rep3')


# Compute nucleotide distances
#analysis_nucleotide_residues('original', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_nucleotide_residues('human', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_nucleotide_residues('original', 'dATP', 'MD', 0, '150', 'rep1')
#analysis_nucleotide_residues('human', 'dATP', 'MD', 0, '150', 'rep1')

#analysis_nucleotide_residues('original', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_nucleotide_residues('human', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_nucleotide_residues('original', 'dATP', 'GaMD', 1, '100', 'rep1')
#analysis_nucleotide_residues('human', 'dATP', 'GaMD', 1, '100', 'rep1')

#analysis_nucleotide_residues('original', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_nucleotide_residues('human', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_nucleotide_residues('original', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_nucleotide_residues('human', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')

#analysis_nucleotide_residues('original', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_nucleotide_residues('human', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_nucleotide_residues('original', 'dATP', 'GaMD', 1, '200', 'rep2')
#analysis_nucleotide_residues('human', 'dATP', 'GaMD', 1, '200', 'rep2')

#analysis_nucleotide_residues('original', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_nucleotide_residues('human', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_nucleotide_residues('original', 'dATP', 'GaMD', 1, '200', 'rep3')
#analysis_nucleotide_residues('human', 'dATP', 'GaMD', 1, '200', 'rep3')


# Compute RMSD
#analysis_RMSD('original', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_RMSD('human', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_RMSD('original', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_RMSD('human', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_RMSD('original', 'dATP', 'MD', 0, '150', 'rep1')
#analysis_RMSD('human', 'dATP', 'MD', 0, '150', 'rep1')

#analysis_RMSD('original', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_RMSD('human', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_RMSD('original', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_RMSD('human', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_RMSD('original', 'dATP', 'GaMD', 1, '100', 'rep1')
#analysis_RMSD('human', 'dATP', 'GaMD', 1, '100', 'rep1')

#analysis_RMSD('original', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_RMSD('human', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_RMSD('original', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_RMSD('human', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_RMSD('original', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_RMSD('human', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')

#analysis_RMSD('original', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_RMSD('human', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_RMSD('original', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_RMSD('human', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_RMSD('original', 'dATP', 'GaMD', 1, '200', 'rep2')
#analysis_RMSD('human', 'dATP', 'GaMD', 1, '200', 'rep2')

#analysis_RMSD('original', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_RMSD('human', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_RMSD('original', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_RMSD('human', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_RMSD('original', 'dATP', 'GaMD', 1, '200', 'rep3')
#analysis_RMSD('human', 'dATP', 'GaMD', 1, '200', 'rep3')


# Compute SASA
#analysis_SASA('original', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_SASA('human', 'Apo', 'MD', 0, '150', 'rep1')
#analysis_SASA('original', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_SASA('human', 'ATP', 'MD', 0, '150', 'rep1')
#analysis_SASA('original', 'dATP', 'MD', 0, '150', 'rep1')
#analysis_SASA('human', 'dATP', 'MD', 0, '150', 'rep1')

#analysis_SASA('original', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_SASA('human', 'Apo', 'GaMD', 1, '100', 'rep1')
#analysis_SASA('original', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_SASA('human', 'ATP', 'GaMD', 1, '100', 'rep1')
#analysis_SASA('original', 'dATP', 'GaMD', 1, '100', 'rep1')
#analysis_SASA('human', 'dATP', 'GaMD', 1, '100', 'rep1')

#analysis_SASA('original', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_SASA('human', 'Apo', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_SASA('original', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_SASA('human', 'ATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_SASA('original', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')
#analysis_SASA('human', 'dATP', 'GaMD', 1, '100_ext', 'rep1_ext')

#analysis_SASA('original', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_SASA('human', 'Apo', 'GaMD', 1, '200', 'rep2')
#analysis_SASA('original', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_SASA('human', 'ATP', 'GaMD', 1, '200', 'rep2')
#analysis_SASA('original', 'dATP', 'GaMD', 1, '200', 'rep2')
#analysis_SASA('human', 'dATP', 'GaMD', 1, '200', 'rep2')

#analysis_SASA('original', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_SASA('human', 'Apo', 'GaMD', 1, '200', 'rep3')
#analysis_SASA('original', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_SASA('human', 'ATP', 'GaMD', 1, '200', 'rep3')
#analysis_SASA('original', 'dATP', 'GaMD', 1, '200', 'rep3')
#analysis_SASA('human', 'dATP', 'GaMD', 1, '200', 'rep3')


"""
########Reweighting##################
###A-N distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', 'A_N_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'A_N_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', 'A_N_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', 'A_N_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', 'A_N_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', 'A_N_dist')


###A-P distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', 'A_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'A_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', 'A_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', 'A_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', 'A_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', 'A_P_dist')


###N-P distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', 'N_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'N_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', 'N_P_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', 'N_P_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', 'N_P_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', 'N_P_dist')


##5-6 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '5_6_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '5_6_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '5_6_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '5_6_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '5_6_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '5_6_dist')


##5-8 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '5_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '5_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '5_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '5_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '5_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '5_8_dist')


##6-8 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '6_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '6_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '6_8_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '6_8_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '6_8_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '6_8_dist')


##5-6 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '798_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '798_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '798_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '798_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '798_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '798_770_dist')


##5-8 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '907_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '907_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '907_770_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '907_770_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '907_770_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '907_770_dist')


##6-8 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '907_798_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '907_798_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '907_798_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '907_798_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '907_798_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '907_798_dist')

"""

##1-2 distance
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', '51_109_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', '51_109_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', '51_109_dist')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', '51_109_dist')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', '51_109_dist')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', '51_109_dist')


"""


###RMSD
PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1', 'RMSD')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep1_ext', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep1_ext', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep1_ext', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep1_ext', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep1_ext', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep1_ext', 'RMSD')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep2', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep2', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep2', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep2', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep2', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep2', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep2', 'RMSD')


PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'Apo', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'Apo', 'GaMD', 'rep3', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'Apo', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'Apo', 'GaMD', 'rep3', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'ATP', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'ATP', 'GaMD', 'rep3', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'ATP', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'ATP', 'GaMD', 'rep3', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'original', 'dATP', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'original', 'dATP', 'GaMD', 'rep3', 'RMSD')

PyReweighting_1D(90, 10, 0.01, 300, "amdweight_CE", 6, 'human', 'dATP', 'GaMD', 'rep3', 'RMSD')
PyReweighting_1D(90, 10, 0.01, 300, "amd_dV", 6, 'human', 'dATP', 'GaMD', 'rep3', 'RMSD')

"""




#analysis_H_bond('human','ATP','GaMD',1,'200','rep2')
