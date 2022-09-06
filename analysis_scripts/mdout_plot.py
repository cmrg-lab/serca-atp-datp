#!/usr/bin/env python
# coding: utf-8

# In[17]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# In[62]:


i = 1
column_names = ['NSTEP','TIME','TEMP','PRES','Etot','EKtot','EPtot','BOND','ANGLE','DIHED','UB','UB','IMP','CMAP','ONE_FOUR_NB','ONE_FOUR_EEL','VDWAALS','EELEC','EHBOND','RESTRAINT','EKCMT','VIRIAL','VOLUME','SURFTEN','Density']
df = pd.DataFrame(columns = column_names)
    

while True:
    
    try:
        f = open('step7_{}.mdout'.format(i))
    except:
        print('Breaking at i = {}'.format(i))
        break
    

    for line in f.readlines():
        write_flag = False
        if 'NSTEP' in line:
            NSTEP = (line.split()[2])
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
            write_flag = True
            #print(Density)
        if write_flag:
            new_list = np.array((NSTEP,TIME,TEMP,PRES,Etot,EKtot,EPtot,BOND,ANGLE,DIHED,UB,UB,IMP,CMAP,ONE_FOUR_NB,ONE_FOUR_EEL,VDWAALS,EELEC,EHBOND,RESTRAINT,EKCMT,VIRIAL,VOLUME,SURFTEN,Density),dtype = float)
            new_line = pd.DataFrame(data =np.array([new_list]), columns = column_names)
            df = pd.concat((df,new_line))
        if 'A V E R A G E S' in line:
            break
    f.close()
    i+=1
    
df.reset_index(drop = True, inplace = True)


# In[87]:


fig, ax = plt.subplots(5,5, figsize =(15,15))
for i in range(5):
    for j in range(5):
        #print(i,j,)
        count = i*5+j
        ax[i,j].plot(df.iloc[:,count], color = 'C0', alpha = 0.1)
        ax[i,j].plot(df.iloc[0::100,count], color = 'C0')
        ax[i,j].set_title(df.columns[count])
plt.tight_layout()

plt.show()
# In[88]:




