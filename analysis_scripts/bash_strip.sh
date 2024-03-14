#!/bin/bash
# Note: For this script, the input use case of the trajectory should be 
# up until the index count I.e. '-x step7_'
# Also this script as is does not work for just aligning a single 
# input traj.

show_help() {
    echo "Usage: $(basename "$0") [options]"
    echo "Options:"
    echo "  -h, --help       Show this help message and exit"
    echo "The follwing flags are expected:"
    echo "    -i topology file (parm7)"
    echo "    -t trajectory file (excluding integer counter and extension)"
    echo "    -l last trajectory index" 
    echo "Optional: -f (first index), -s (stride)"


    # Add other options description here
}




# Setting Defaults for stride and file type

stride=1
first_index=1
filetype=.nc
echo $filetype

while getopts :i:f:l:s:ft:x:o:temp: flag
do
    case "${flag}" in
        i) input_parm=${OPTARG};;   
        f) first_index=${OPTARG};;
        l) last_index=${OPTARG};;
        s) stride=${OPTARG};;
        ft) filetype=${OPTARG};;
        x) trajectory=${OPTARG};;
        o) output=${OPTARG};;
        temp) temp=${OPTARG};;


    esac
done

# Check to make sure all the variables are set. 
missing_variables=()
if [ -z "$input_parm" ]; then
    missing_variables+=("input_parm")
fi
if [ -z "$trajectory" ]; then
    missing_variables+=("trajectory")
fi
if [ -z "$first_index" ]; then
    missing_variables+=("first_index")
fi
if [ -z "$last_index" ]; then
    missing_variables+=("last_index")
fi
if [ -z "$stride" ]; then
    missing_variables+=("stride")
fi
if [ -z "$filetype" ]; then
    missing_variables+=("filetype")
fi
if [ -z "$output" ]; then
    missing_variables+=("output")
fi
if [ ${#missing_variables[@]} -ne 0 ]; then
    echo "The following variables are not set: ${missing_variables[*]}"
    exit 1
fi

echo "All variables are set."
# Continue 

echo "Input Parm: $input_parm";
echo "Input Traj: $trajectory";
echo "First index: $first_index";
echo "Last Index: $last_index";
echo "Stride: $stride"; 
echo "Filetype: $filetype";
echo "Output file: $output";


cp /home/marcus/Documents/SERCA/serca-atp-datp/analysis_scripts/strip_script.in temp_stripping.in
echo $(realpath temp_stripping.in)

sed -i "s/COMMAND_INPUT_PARM/${input_parm}/g" temp_stripping.in
sed -i "s/COMMAND_INPUT_START/${first_index}/g" temp_stripping.in
sed -i "s/COMMAND_INPUT_STOP/${last_index}/g" temp_stripping.in
sed -i "s/COMMAND_INPUT_FILE_TYPE/${filetype}/g" temp_stripping.in
sed -i "s/COMMAND_INPUTP_TRAJ/${trajectory}/g" temp_stripping.in
sed -i "s/COMMAND_INPUT_STRIDE/${stride}/g" temp_stripping.in
sed -i "s/COMMAND_INPUT_OUT/${output}/g" temp_stripping.in


/home/marcus/anaconda3/envs/ambertools/bin/cpptraj temp_stripping.in

if [ -z "$temp" ]; then 
    echo Cleaning up and removing temp_stripping.in
    realpath temp_stripping.in

    rm temp_stripping.in
fi 

echo Done