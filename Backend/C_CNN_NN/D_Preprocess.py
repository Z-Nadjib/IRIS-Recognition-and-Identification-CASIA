
import numpy as np
import cv2
import os
from Backend.C_CNN_NN.A_Bounderies import locate_iris_boundaries
from Backend.C_CNN_NN.B_Normalization import IrisNormalization
from Backend.C_CNN_NN.C_Enhancement_ROI import ImageEnhancement

                                               #'// This code use all preprocessing algorithms in this project //'
                                         #'// bounderies to locate inner and outer circle iris region (segmentation) //'
                                    #'// normalization to normalize the iris region into rectangle so we can extract features//'
                                         #'// enhancement to enhance the iris region with ROI to get better features  //'
                                         
                                                                       #'// WARNING //'
                                         
                                            #'// Warning don't run the code otherwise it ll take 6h of preprocessing //'
                                               #'// The preprocessed data is availible in 0_data > Preprocessed//'

def preprocess(image):
    imagep = cv2.imread(image)                
    eye = cv2.cvtColor(imagep, cv2.COLOR_BGR2GRAY)
    outer , inner = locate_iris_boundaries(eye)
    x_iris,y_iris,r_iris = outer
    x_pupil,y1_pupil,r1_pupil = inner
    dra1 = eye.copy()
    cv2.circle(dra1, (x_iris, y_iris), r_iris, color=(255, 0, 0), thickness=3)
    cv2.circle(dra1, (x_pupil, y1_pupil), r1_pupil, color=(255, 0, 0), thickness=3)
    iris, pupil = outer,inner
    normalized = IrisNormalization(eye, pupil, iris)
    ROI = ImageEnhancement(normalized)
    return ROI
    
    
def savepreprocessed(image, folder, image_name):
    path_preprocessed = 'Backend/0_Data/Preprocessed_Data'
    if not os.path.exists(os.path.join(path_preprocessed, folder)):
        os.makedirs(os.path.join(path_preprocessed, folder))
    cv2.imwrite(os.path.join(path_preprocessed, folder, image_name + '.jpg'), image)

 
 
row_data = 'Backend/0_Data/Raw_Data/'

for folder in os.listdir(row_data):
    folder_path = os.path.join(row_data, folder)
    for image_name in os.listdir(folder_path):
        image_path = os.path.join(folder_path, image_name)
        preprocessed_image = preprocess(image_path)
        savepreprocessed(preprocessed_image, folder, os.path.splitext(image_name)[0])