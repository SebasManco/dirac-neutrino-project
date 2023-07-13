#!/usr/bin/env python

import numpy as np
# import sys
# import time
import scipy as sp
import scipy.integrate as integrate
import pandas as pd
# import scipy.optimize
import random


h = []
BB = 0
v = 2.46218458E+02
# v = 2.46218458E+11
mh = 125.0

def random_number():
    return random.uniform(1e-4,3)

#----------------------------------------------------------------------------#
#-------------------------------DEFINITIONS----------------------------------#
#----------------------------------------------------------------------------#
def A0(mk):
    y = (np.arcsin( np.sqrt(mh**2/(4*mk**2)) )**2 - mh**2/(4*mk**2))*(mh**2/(4*mk**2))**(-2)
    return y #scalar loop function

def Rgg(l3,l6,mk1,mk2):
    rgg=np.abs( 1.0  + (l3*v**2/(-6.5*2*mk1**2))*A0(mk1) + (l6*v**2/(-6.5*2*mk2**2))*A0(mk2))**2
    return rgg #h to gamma gamma calculation 
#--CMS 2103.06956v2 R=1.12 +-0.09

data = pd.read_csv("/home/sebastian/thesis/codes/julia/thesis/couplings.csv")
data1 = (data.mk1).to_numpy() / 1e9
data2 = (data.mk2).to_numpy() / 1e9

l3 = np.random.uniform(np.log10(1e-4),np.log10(3),data1.size)
l6 = np.random.uniform(np.log10(1e-4),np.log10(3),data2.size)
l3f = 10**l3
l6f = 10**l6

rgg = Rgg(l3f,l6f,data1,data2)
rggf = np.array(rgg)
data = pd.DataFrame(rggf).to_csv('datoshgg.csv')

# print(rgg)
# print(rgg)
# mn1 = (data.mn1).to_numpy()
# print(rgg.type)


# import matplotlib.pyplot as plt 

# # fig, ax = plt.subplots()
# plt.scatter(data1,rgg,s=1)
# # plt.ylim((-1.5,1.5))
# # plt.yscale("log")
# plt.show()

# print(Rgg(1.1,0.02,240,210))



#----------------------------------------------------------------------------#
#----------------------------------------------------------------------------#
#----------------------------------------------------------------------------#

# x = np.loadtxt('/home/amalia/Documentos/T11G/Scan/DM/Rggscan/Total_inferior2.txt')
# start_time = time.time()
# MDinput = x[:,0]
# MTinput = x[:,1]
# pi1input = x[:,18]
# Omegainput = x[:,48]
# Sigmainput=x[:,54]
# l1 = mh**2/v**2
# xx = np.arange(len(MDinput))
# yy=np.arange(100)
# for t in yy:
#     for j in  xx:
#         BB = BB + 1
#         module = np.fmod(BB,1)
#         if module ==0:
#             print BB
#             MD = MDinput[j]
#             MT = MTinput[j]
#             pi1= pi1input[j]
#             Omega= Omegainput[j]
#             sigma=Sigmainput[j]
#             MH = np.random.uniform(1.2,2.)*MD
#             MA = MH
#             MHp = np.random.uniform(1.2,2.)*MD
#             MDelta = np.random.uniform(1.2,2.)*MD
    
    
#             l3 = np.random.uniform(-1.87,4*np.pi)#-np.exp(np.random.uniform(np.log(1E-1),np.log(1.)))#
#             l2 = 4*np.pi#acople cuartico del doblete a higgs
#             l6 = 4*np.pi# cuartico del triplete
#             l7 = np.random.uniform(-1.87,4*np.pi)#acople triplete higss
#             lS = 4*np.pi # acople triplete doblete inerte

#             mu =0.0
#             pi2=pi1
#             mu2 = MHp**2 - l3*v**2/2. 
#             muD = MDelta**2 - l7*v**2/2.
#             l5 = (MH**2-MA**2)/v**2
#             l4 = (MH**2 + MA**2 - 2*MHp**2)/v**2
#             lL = (l3+l4+l5)/2.
        
#             eta1=0.
#             eta2=0.
#             eta3=0.
#             f1=0.
#             f2=0.
#             f3=0.
#             ro1=0.
#             ro2=ro1
#             ro3=ro1
#             R=Rgg(MD,MT,pi1,l3,l7,MHp,MDelta)  
    
    
#             h.append([MD,MT,MA,MH,MHp,MDelta,lL,l2,l6,l7,lS,mu,mu2,muD,l1,l3,l4,l5,pi1,pi2,R,Omega,sigma])
                        

# h = np.asarray(h)
# np.savetxt('datos_inferior.txt',h) 
# print '''Time in seconds is:=''', (time.time() - start_time)

