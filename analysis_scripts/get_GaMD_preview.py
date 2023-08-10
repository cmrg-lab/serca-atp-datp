# Used to quickly look at the GaMD intervals

import matplotlib.pyplot as plt
import matplotlib as mpl
mpl.use('Qt5Agg')

import sys

import re


def extract_numbers(input_string):
    # Search for the first occurrence of a number (integer or decimal) using regex
    match = re.search(r'\d+(\.\d+)?', input_string)

    if match:
        return float(match.group())
    else:
        return None

def main():
    # Get command line arguments excluding the script name
    arguments = sys.argv[1:]

    print("Command line arguments:", arguments)
    for a in arguments:
        print(a)
        try:
            f = open(a)
            lines = f.readlines()
            f.close()
        except:
            print('Error loading or reading file {}. \nExiting...'.format(a))
            return -1
        for line in lines:
            if "ntcmdprep" in line:
                ntcmdprep = extract_numbers(line)
            if "ntcmd" in line:
                ntcmd = extract_numbers(line)
            if "ntebprep" in line:
                ntebprep = extract_numbers(line)
            if "nteb" in line:
                nteb = extract_numbers(line)
            if "ntave" in line:
                ntave = extract_numbers(line)
            if "nstlim" in line:
                nstlim = extract_numbers(line)
            if "dt" in line:
                dt = extract_numbers(line)


        plt.figure(figsize = (16,3))
        plt.title(a)
        total_simulation_time = nstlim * dt/1e3
        print(nstlim)
        plt.axvspan(0,total_simulation_time, color = 'gray', alpha = 0.1, label = 'Total Simulation Time = {} ns'.format(total_simulation_time))
        print('Total Simulation Time = {}'.format(total_simulation_time))


        #plt.text(total_simulation_time,-.1,'{0:.1f} Total'.format(total_simulation_time))
        gamd_production_time = (nstlim - (ntcmd + nteb))*1e-3*dt
        plt.axvspan(total_simulation_time- gamd_production_time, total_simulation_time, alpha = 0.1, label = 'GaMD Production Time = {} ns'.format(gamd_production_time))
        print('GaMD Production Time = {}'.format(gamd_production_time))
        #plt.text(((total_simulation_time-gamd_production_time)+total_simulation_time)/2,0.5,'{0:.1f} Total'.format((gamd_production_time)))

        md_prep = ntcmdprep/1e3*dt
        plt.axvspan(0, md_prep, color = 'blue', alpha = 0.2, label = 'MD Prep/Equil Time = {} ns'.format(md_prep))

        md_total = ntcmd/1e3*dt
        plt.axvspan(0, md_total, color = 'green', alpha = 0.2,label = 'Total MD Time (inc. prep)= {} ns'.format(md_total))

        GaMD_pre_equil = ntebprep/1e3*dt
        plt.axvspan(md_total, md_total + GaMD_pre_equil , color = 'purple', alpha = 0.2, label = 'GaMD Pre-equil Time = {} ns'.format(GaMD_pre_equil))

        GaMD_equil = (nteb - ntebprep) * dt / 1e3
        plt.axvspan(md_total+GaMD_pre_equil,md_total+GaMD_pre_equil + GaMD_equil ,  color = 'C5', alpha = 0.2, label = 'GaMD Equil Time = {} ns'.format(GaMD_equil))

        plt.text(ntcmd/1e3*dt,-.1,'{0:.1f} MD'.format(ntcmd/1e3*dt))
        plt.legend()
        plt.show()


if __name__ == "__main__":
    main()

