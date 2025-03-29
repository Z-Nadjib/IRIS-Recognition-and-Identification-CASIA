import cv2
import numpy as np
import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
from tensorflow.keras.models import load_model


import os
import scipy
from scipy import signal
import math
import time



#modulating function as defined in paper
def m(x ,y, f):
    val = np.cos(2*np.pi*f*math.sqrt(x **2 + y**2))
    return val
#spatial filter as defined in paper
def gabor(x, y, dx, dy, f):
    gb = (1/(2*math.pi*dx*dy))*np.exp(-0.5*(x**2 / dx**2 + y**2 / dy**2)) * m(x, y, f)
    return gb

#function to calculate spatial filter over 4x4 blocks
def spatial(f,dx,dy):
    sfilter=np.zeros((4,4))
    for i in range(4):
        for j in range(4):
            sfilter[i,j]=gabor((-2+j),(-2+i),dx,dy,f)
    return sfilter

def get_vec(convolvedtrain1,convolvedtrain2):
    feature_vec=[]
    for i in range(12):
            for j in range(128):
                #Run 4 by 4 filtered block iteratively over the entire image
                start_height = i*4
                end_height = start_height+4
                start_wid = j*4
                end_wid = start_wid+4
                grid1 = convolvedtrain1[start_height:end_height, start_wid:end_wid]
                grid2 = convolvedtrain2[start_height:end_height, start_wid:end_wid]

                # Channel 1
                absolute = np.absolute(grid1)
                # mean
                mean = np.mean(absolute)
                feature_vec.append(mean)
                #deviation
                std = np.mean(np.absolute(absolute-mean))
                feature_vec.append(std)

                # Channel 2
                absolute = np.absolute(grid2)
                # mean
                mean = np.mean(absolute)
                feature_vec.append(mean)
                #deviation
                std = np.mean(np.absolute(absolute-mean))
                feature_vec.append(std)

    return feature_vec

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


def PredictWithGaborNN(image):
    # Charger le modèle entraîné
    model = load_model('Backend\D_GaborF_NN\Model\Gabor_NN.h5')

    img = cv2.imread(image, cv2.IMREAD_GRAYSCALE)
    # Extraire les caractéristiques de l'image
    features = FeatureExtraction([img])
     
    start=time.time()
    prediction = model.predict(np.array(features))
    end=time.time()
    
    time_prediction=end-start
    # Trouver l'index de la classe avec la probabilité maximale
    predicted_class_index = np.argmax(prediction)

    
    return predicted_class_index , time_prediction
    
    
