#!/bin/bash

cpptraj -i ~/Documents/SERCA/serca-atp-datp/analysis_scripts/cluster_script1.in

cpptraj -i ~/Documents/SERCA/serca-atp-datp/analysis_scripts/cluster_script2.in

# if [ -e "stripped_cluster.pdb.0" ]; then
#     echo "File stripped_cluster.pdb.0 already exists. Aborting."
#     exit 1
# fi

for num in {1..30}; do
	file="stripped_cluster.pdb.${num}"
        new_name="stripped_cluster.pdb.$((num-1))"
        mv "$file" "$new_name"
        echo "Renamed $file to $new_name"
done
