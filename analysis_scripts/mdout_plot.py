#!/usr/bin/env python

### Created by Marcus Hock
# Used for a quick plot of all of the default outputs from the MDOUT files from the CHARMM-GUI settings for AMBER
# The script will look for .mdout files in the current directory where the script is ran from

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from time import time
import re



def count_files():
    i = 1
    while True:
        try:
            f = open('step7_{}.mdout'.format(i))
            i+=1
            f.close()
        except:
            print('Unable to open step7_{}.mdout'.format(i))
            return i-1


def step_info(file_name):
    f = open(file_name)
    lines = f.readlines()
    for line in lines:
        if 'ntpr' in line:
            step_size = int(re.search('=(.*),', line).group(1))
            print(step_size)
            break
        if 'nstlim' in line:
            simulation_length = int(re.search('=(.*),', line).group(1))

    n_steps = simulation_length // step_size
    f.close()

    return step_size, n_steps



def read_all_files(n_files, n_steps, n_columns):
    mdout_array = np.zeros((n_steps * n_files, n_columns))
    row_counter = 0
    for i in range(1,n_files+1):
        f = open('step7_{}.mdout'.format(i))
        print('Opened ','step7_{}.mdout'.format(i))
        for line in f.readlines():
            if 'NSTEP' in line:
                NSTEP = (line.split()[2])
                if int(NSTEP) == 0:
                    mdout_array = np.zeros((n_steps * n_files+1, n_columns))
                TIME = (line.split()[5])
                TEMP = (line.split()[8])
                PRES = (line.split()[11])
            elif 'Etot' in line:
                Etot = (line.split()[2])
                EKtot = (line.split()[5])
                EPtot = (line.split()[8])
            elif ' BOND' in line:
                BOND = (line.split()[2])
                ANGLE = (line.split()[5])
                DIHED = (line.split()[8])
            elif ' UB' in line:
                UB = (line.split()[2])
                IMP = (line.split()[5])
                CMAP = (line.split()[8])
            elif '1-4 NB' in line:
                ONE_FOUR_NB = (line.split()[3])
                ONE_FOUR_EEL = (line.split()[7])
                VDWAALS = (line.split()[10])
            elif 'EELEC' in line:
                EELEC = (line.split()[2])
                EHBOND = (line.split()[5])
                RESTRAINT = (line.split()[8])
            elif 'EKCMT' in line:
                EKCMT = (line.split()[2])
                VIRIAL = (line.split()[5])
                VOLUME = (line.split()[8])
            elif 'SURFTEN' in line:
                SURFTEN = (line.split()[2])
            elif 'Density' in line:
                Density = (line.split()[2])
                mdout_array[row_counter] = (NSTEP,TIME,TEMP,PRES,Etot,EKtot,EPtot,BOND,ANGLE,DIHED,UB,UB,IMP,CMAP,ONE_FOUR_NB,ONE_FOUR_EEL,VDWAALS,EELEC,EHBOND,RESTRAINT,EKCMT,VIRIAL,VOLUME,SURFTEN,Density)
                row_counter += 1
            if 'A V E R A G E S' in line:
                break


    return mdout_array

n_files = count_files()
step_size, n_steps = step_info('step7_1.mdout')
if n_steps != step_info('step7_{}.mdout'.format(n_files))[1]:
    print('First file does not match last file number of steps')
    print('Exiting')
    exit()
print('There are {} files.'.format(n_files))

column_names = ['NSTEP','TIME','TEMP','PRES','Etot','EKtot','EPtot','BOND','ANGLE','DIHED','UB','UB','IMP','CMAP','ONE_FOUR_NB','ONE_FOUR_EEL','VDWAALS','EELEC','EHBOND','RESTRAINT','EKCMT','VIRIAL','VOLUME','SURFTEN','Density']
n_columns = len(column_names)

mdout = read_all_files(n_files, n_steps, n_columns)

df = pd.DataFrame(mdout, columns = column_names)

df.reset_index(drop = True, inplace = True)


# In[87]:


fig, ax = plt.subplots(5,5, figsize =(15,15))
for i in range(5):
    for j in range(5):
        #print(i,j,)
        count = i*5+j
        # Plot against time (index 1)
        ax[i,j].plot(df.iloc[:,1], df.iloc[:,count], color = 'C0', alpha = 0.1)
        ax[i,j].plot(df.iloc[0::100,1], df.iloc[0::100,count], color = 'C0')
        ax[i,j].set_title(df.columns[count])
plt.tight_layout()

plt.show()
