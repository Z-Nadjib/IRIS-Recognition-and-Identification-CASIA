
import numpy as np
import math
import scipy
from scipy import signal
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from E_GaborExtract import spatial, get_vec


def FeatureExtraction(enhanced):
    con1=[]
    con2=[]
    #get spatial filters
    filter1=spatial(0.67,3,1.5)
    filter2=spatial(0.67,4,1.5) 
    
    feature_vector=[] #
    
    for i in range(len(enhanced)):
        img=enhanced[i]
        
        img_roi=img[0:48,:]
        
        filtered1=scipy.signal.convolve2d(img_roi,filter1,mode='same')
        filtered2=scipy.signal.convolve2d(img_roi,filter2,mode='same')
        
        con1.append(filtered1)
        con2.append(filtered2)
        fv=get_vec(filtered1,filtered2)
        feature_vector.append(fv)
    return feature_vector