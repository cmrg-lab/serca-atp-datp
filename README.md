# serca-atp-datp
MD and GaMD simulations of SERCA with and without ATP or dATP
Analysis scripts and structures from "Multiscale Computational Modeling of the Effects of 2'-deoxy-ATP on Cardiac Muscle Calcium Handling", Marcus T. Hock, Abigail E. Teitgen, Kimberly J. McCabe, Sophia P. Hirakis, Gary A. Huber, Michael Regnier, J. Andrew McCammon, and Andrew D. McCulloch

structure_prep: Contains starting structures for MD/GaMD simulations. Simulations were carried out for original rabbit skeletal SERCA structure (PDB: 3W5A) and human cardiac homology model (using sequence PDB: 7BT2).

simulation analysis: contains scripts for all analysis in paper
	Calcium_transient_analysis: contains Himeno ECC model script
	Hydrogen_bond_analysis: contains cpptraj script for assessing hydrogen bonds between ATP and binding pocket
	Nucleotide_clustering: contains cpptraj scripts for clustering nucleotide structures from GaMD simulations
	Preprocessing: contains cpptraj script (strip_script.in) for stripping waters from MD/GaMD trajectories and script for writing out weights from GaMD simulations
	Reweighting: contains scripts for performing reweighting analysis of GaMD simulations from Miao et al. reweight-1d_new.sh runs PyReweighting_1D.py
	master_analysis.py: calls analysis_cytosolic_domains, analysis_nucleotide_residues, analysis_RMSD, analysis_SASA, analysis_TM_domains, PyReweighting-1D, writes out csv files of results
	mdout_plot.py: used for quick analysis of results
	Trajectory_domain_analysis.ipynb: reads in csv files, plots results

