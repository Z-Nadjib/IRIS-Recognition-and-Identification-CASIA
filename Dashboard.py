import sys
import subprocess
from PySide6.QtWidgets import QApplication , QFileDialog
from PySide6.QtQuick import QQuickView
from PySide6.QtCore import QUrl, Qt, QObject, Slot , QPoint
import shutil
import os
import cv2
import time
from Backend.D_GaborF_NN.A_Bounderies import locate_iris_boundaries
from Backend.D_GaborF_NN.B_Normalization import IrisNormalization
from Backend.D_GaborF_NN.C_Enhancement_ROI import ImageEnhancement
from Backend.D_GaborF_NN.predict import PredictWithGaborNN 
from Backend.C_CNN_NN.predict import predictwithCNNandNN
from Backend.B_SIFT_KNN.predict import equalize_iris_region , segment_regions , detect_keypoints , find_best_match , compute_descriptors


def cleantmp():
    temp_directory = "Temp"  # Chemin vers le dossier temporaire
    if os.path.exists(temp_directory) and os.path.isdir(temp_directory):
        # Parcours tous les fichiers dans le dossier temporaire et les supprime un par un
        for file_name in os.listdir(temp_directory):
            file_path = os.path.join(temp_directory, file_name)
            try:
                if os.path.isfile(file_path):
                    os.remove(file_path)
                elif os.path.isdir(file_path):
                    os.rmdir(file_path)
            except Exception as e:
                print(f"Erreur lors de la suppression du fichier {file_path}: {e}")
    else:
        print(f"Le dossier temporaire {temp_directory} n'existe pas.")

class Controller(QObject):
    def __init__(self, view):
        super().__init__()
        self.view = view
        self.dragging = False
        self.last_mouse_pos = None
        self.model = 'SIFT'
        self.imageraw=""
        self.steppreprocessing=0
        
    @Slot(float, float)
    def handle_mouse_press(self, x, y):
        self.dragging = True
        self.last_mouse_pos = (x, y)

    @Slot(float, float)
    def handle_mouse_move(self, x, y):
        if self.dragging:
            dx = x - self.last_mouse_pos[0]
            dy = y - self.last_mouse_pos[1]
            new_x = self.view.position().x() + dx
            new_y = self.view.position().y() + dy
            self.view.setPosition(QPoint(new_x, new_y))
            self.last_mouse_pos = (x, y)

    @Slot()
    def handle_mouse_release(self):
        self.dragging = False

    @Slot()
    def quit_application(self):
        QApplication.quit()
        
    @Slot(str,QObject,QObject,QObject,QObject,QObject)
    def switchmenu(self,option,dashboard,config,preprocess,classification,aboutdev):
        rectangles = [dashboard, config, preprocess, classification, aboutdev]
        for rectangle in rectangles:
            rectangle.setProperty("visible", False)
            
        if option == "dashboard":
            dashboard.setProperty("visible", True)
        elif option == "config":
            config.setProperty("visible", True)
        elif option == "preprocess":
            preprocess.setProperty("visible", True)
        elif option == "classification":
            classification.setProperty("visible", True)
        elif option == "aboutdev":
            aboutdev.setProperty("visible", True)
        
    
    @Slot(QObject)
    def afficherlist(self, list):
        if list.property("visible") == True:
            list.setProperty("visible", False)
        else:
            list.setProperty("visible", True)
            
    @Slot(str,QObject)
    def choosenmodel(self, model , list):
        if model == "SIFT":
            self.model = "SIFT"
            list.setProperty("visible", False)
            view.rootContext().setContextProperty("modelselected", "SIFT + Classification")
        elif model == "GABOR":
            self.model = "GABOR"
            list.setProperty("visible", False)
            view.rootContext().setContextProperty("modelselected", "Gabor + Neural Network")
        elif model == "CNN":
            self.model = "CNN"
            list.setProperty("visible", False)
            view.rootContext().setContextProperty("modelselected", "Conv Neural Network")
            
    @Slot()
    def uploadimage(self):
        options = QFileDialog.Options()
        options |= QFileDialog.ReadOnly
        file_path, _ = QFileDialog.getOpenFileName(None, "Open Image File", "", "Image Files (*.png *.jpg *.bmp)", options=options)
        if file_path:
            current_directory = os.getcwd()
            temp_directory = os.path.join(current_directory, 'Temp')
            if not os.path.exists(temp_directory):
                os.makedirs(temp_directory)
            destination_path = os.path.join(temp_directory, os.path.basename(file_path))
            shutil.copy(file_path, destination_path)
            self.imageraw="Temp/"+os.path.basename(file_path)
            
            
    @Slot(QObject,QObject,QObject)
    def applyconfig(self,preprocesssift,preprocesscnn,preprocessgabor):
        all_rectangles = [preprocesssift,preprocessgabor,preprocesscnn]
        for rectangle in all_rectangles:
            rectangle.setProperty("visible", False)
        view.rootContext().setContextProperty("rawimage", self.imageraw)
        
        view.rootContext().setContextProperty("steponestatus","Waiting")
        view.rootContext().setContextProperty("steptwostatus","Waiting")
        view.rootContext().setContextProperty("stepthreestatus","Waiting")
        view.rootContext().setContextProperty("stepfourstatus","Waiting")
        view.rootContext().setContextProperty("steponestatuscolor","#ffc100")
        view.rootContext().setContextProperty("steptwostatuscolor","#ffc100")
        view.rootContext().setContextProperty("stepthreestatuscolor","#ffc100")
        view.rootContext().setContextProperty("stepfourstatuscolor","#ffc100")
        view.rootContext().setContextProperty("textsteppreprocess","Start")
        
        if self.model == "SIFT":
            preprocesssift.setProperty("visible", True)
            view.rootContext().setContextProperty("modeltitle", "SIFT + Classification")
            view.rootContext().setContextProperty("accuracymodel", "98%")
            view.rootContext().setContextProperty("timeprocessing", "~ 40sec")
            view.rootContext().setContextProperty("timeprediction", "285ms")
            view.rootContext().setContextProperty("steponepreprocessing","Bounderies detection")
            view.rootContext().setContextProperty("steptwopreprocessing","Equalizer")
            view.rootContext().setContextProperty("stepthreepreprocessing","Segmentation")
            view.rootContext().setContextProperty("stepfourpreprocessing","KeyPoint Extraction")
            view.rootContext().setContextProperty("robotchat","oh ! so you choose SIFT + Classification model, it's a good choice, this model is based on SIFT algorithm and KNN classifier ,let's start the preprocessing steps click on start button ;)")

        elif self.model == "GABOR":
            preprocessgabor.setProperty("visible", True)
            view.rootContext().setContextProperty("modeltitle", "Gabor + Neural Network")
            view.rootContext().setContextProperty("accuracymodel", "92%")
            view.rootContext().setContextProperty("timeprocessing", "~ 40sec")
            view.rootContext().setContextProperty("timeprediction", "129ms")
            view.rootContext().setContextProperty("steponepreprocessing","Bounderies detection")
            view.rootContext().setContextProperty("steptwopreprocessing","Normalization")
            view.rootContext().setContextProperty("stepthreepreprocessing","Enhancement")
            view.rootContext().setContextProperty("stepfourpreprocessing","Gabors Filter")
            view.rootContext().setContextProperty("robotchat","oh ! so you choose Gabor + Neural Network model, it's a good choice, this model is based on Gabor filter and Neural Network classifier ,let's start the preprocessing steps click on start button ;)")
        elif self.model == "CNN":
            preprocesscnn.setProperty("visible", True)
            view.rootContext().setContextProperty("modeltitle", "Conv Neural Network")
            view.rootContext().setContextProperty("accuracymodel", "97%")
            view.rootContext().setContextProperty("timeprocessing", "~ 40sec")
            view.rootContext().setContextProperty("timeprediction", "120ms")
            view.rootContext().setContextProperty("steponepreprocessing","Bounderies detection")
            view.rootContext().setContextProperty("steptwopreprocessing","Normalization")
            view.rootContext().setContextProperty("stepthreepreprocessing","Enhancement")
            view.rootContext().setContextProperty("stepfourpreprocessing","Feature Extraction")
            view.rootContext().setContextProperty("robotchat","oh ! so you choose Conv Neural Network model, it's a good choice, this model is based on Convolutional Neural Network classifier ,let's start the preprocessing steps click on start button ;)")

    @Slot()
    def start_chat(self):
        if self.model == "CNN":
            if self.steppreprocessing == 0:
                view.rootContext().setContextProperty("robotchat","first ,the bounderies detection , I will try to find the iris for you by detecting the inner and outer circle of the iris region it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("steponestatus","In process...")
                view.rootContext().setContextProperty("steponestatuscolor","#FFFB14")
                view.rootContext().setContextProperty("textsteppreprocess","Next")
            elif self.steppreprocessing == 1:
                view.rootContext().setContextProperty("robotchat","second, the normalization , I will normalize the iris region into rectangle with polar to cartesian transformation it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("steptwostatus","In process...")
                view.rootContext().setContextProperty("steptwostatuscolor","#FFFB14")
            elif self.steppreprocessing == 2:
                view.rootContext().setContextProperty("robotchat","third, the enhancement , I will enhance the iris region with ROI to get better features it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("stepthreestatus","In process...")
                view.rootContext().setContextProperty("stepthreestatuscolor","#FFFB14")
            elif self.steppreprocessing == 3:
                view.rootContext().setContextProperty("robotchat","finally, the keypoint extraction , I will extract the keypoints from the iris region , i'm sorry i can't let you visualize the extraction it's a secret ;) (just kidding) the image is vectorized !")
                
                view.rootContext().setContextProperty("stepfourstatus","In process...")
                view.rootContext().setContextProperty("stepfourstatuscolor","#FFFB14")
        elif self.model == "GABOR":
            if self.steppreprocessing == 0:
                view.rootContext().setContextProperty("robotchat","first ,the bounderies detection , I will try to find the iris for you by detecting the inner and outer circle of the iris region it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("steponestatus","In process...")
                view.rootContext().setContextProperty("steponestatuscolor","#FFFB14")
            elif self.steppreprocessing == 1:
                view.rootContext().setContextProperty("robotchat","second, the normalization , I will normalize the iris region into rectangle with polar to cartesian transformation it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("steptwostatus","In process...")
                view.rootContext().setContextProperty("steptwostatuscolor","#FFFB14")
            elif self.steppreprocessing == 2:
                view.rootContext().setContextProperty("robotchat","third, the enhancement , I will enhance the iris region with ROI to get better features it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("stepthreestatus","In process...")
                view.rootContext().setContextProperty("stepthreestatuscolor","#FFFB14")
            elif self.steppreprocessing == 3:
                view.rootContext().setContextProperty("robotchat","finally, the gabors filter , I will apply gabors filter to the iris region the vizualization option is disabled in this step... i'm sorry , it will take few seconds so please wait ")
                
                view.rootContext().setContextProperty("stepfourstatus","In process...")
                view.rootContext().setContextProperty("stepfourstatuscolor","#FFFB14")
        elif self.model == "SIFT":
            if self.steppreprocessing == 0:
                view.rootContext().setContextProperty("robotchat","first ,the bounderies detection , I will try to find the iris for you by detecting the inner and outer circle of the iris region it will take few seconds so please wait")
                view.rootContext().setContextProperty("steponestatus","In process...")
                view.rootContext().setContextProperty("steponestatuscolor","#FFFB14")
            elif self.steppreprocessing == 1:
                view.rootContext().setContextProperty("robotchat","second, the equalizer , I will equalize the iris region so you can see the iris region with better quality it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("steptwostatus","In process...")
                view.rootContext().setContextProperty("steptwostatuscolor","#FFFB14")
            elif self.steppreprocessing == 2:
                view.rootContext().setContextProperty("robotchat","third, the segmentation , I will segment the iris region so you can see the iris region only without the other parts of the eye it will take few seconds so please wait")
                
                view.rootContext().setContextProperty("stepthreestatus","In process...")
                view.rootContext().setContextProperty("stepthreestatuscolor","#FFFB14")
            elif self.steppreprocessing == 3:
                view.rootContext().setContextProperty("robotchat","finally, the keypoint extraction , I will extract the keypoints from the iris region you can see the keypoint in the visualizer window once the process is done")
                
                view.rootContext().setContextProperty("stepfourstatus","In process...")
                view.rootContext().setContextProperty("stepfourstatuscolor","#FFFB14")
            
    @Slot(QObject,QObject)
    def startpreprocess(self,mouseareapreprocess,mouseareaclassification):
        if self.model == "GABOR":
            if self.steppreprocessing == 0:
                image = cv2.imread(self.imageraw, cv2.COLOR_BGR2GRAY)
                start_time = time.time()
                outer_circle , inner_circle , result_image = locate_iris_boundaries(image)
                if result_image is not None:
                    cv2.imwrite('Temp/image_bounderies.png', result_image)
                    view.rootContext().setContextProperty("steponevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steponevisualizationcolor","#07DB00")
                    
                end_time = time.time()
                time_bounderies=end_time-start_time
                view.rootContext().setContextProperty("steponestatus","Done")
                view.rootContext().setContextProperty("steponestatuscolor","#07DB00")
                view.rootContext().setContextProperty("textsteppreprocess","Next")
                view.rootContext().setContextProperty("steponetime",time_bounderies)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_bounderies.png")
                self.iris, self.pupil = outer_circle, inner_circle
                self.steppreprocessing += 1
                
            elif self.steppreprocessing == 1:
                image = cv2.imread('Temp/image_bounderies.png', cv2.IMREAD_GRAYSCALE)
                start_time = time.time()
                normalized = IrisNormalization(image, self.pupil, self.iris)
                end_time = time.time()
                time_normalization = end_time - start_time
                if normalized is not None:
                    cv2.imwrite('Temp/image_normalized.png', normalized)
                    view.rootContext().setContextProperty("steptwovisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steptwovisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("steptwostatus","Done")
                view.rootContext().setContextProperty("steptwostatuscolor","#07DB00")
                view.rootContext().setContextProperty("steptwotime",time_normalization)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_normalized.png")
                self.steppreprocessing += 1   
            elif self.steppreprocessing == 2:
                image = cv2.imread('Temp/image_normalized.png', cv2.IMREAD_GRAYSCALE)
                start_time = time.time()
                roi = ImageEnhancement(image)
                end_time = time.time()
                time_enhancement = end_time - start_time
                if roi is not None:
                    cv2.imwrite('Temp/image_enhanced.png', roi)
                    view.rootContext().setContextProperty("stepthreevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("stepthreevisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("stepthreestatus","Done")
                view.rootContext().setContextProperty("stepthreestatuscolor","#07DB00")
                view.rootContext().setContextProperty("stepthreetime",time_enhancement)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_enhanced.png")
                
                self.steppreprocessing += 1 
                
            elif self.steppreprocessing == 3:
                start_time = time.time()
                self.predictedclass , self.predictiontime = PredictWithGaborNN('Temp/image_enhanced.png')
                end_time = time.time()
                time_gabor = end_time - start_time
                self.predictedclass = str(self.predictedclass)
                view.rootContext().setContextProperty("stepfourstatus","Done")
                view.rootContext().setContextProperty("stepfourstatuscolor","#07DB00")
                view.rootContext().setContextProperty("resultpreprocessingcolor","#07DB00")
                view.rootContext().setContextProperty("resultpreprocessing","Preprocessing finished successfully")
                view.rootContext().setContextProperty("stepfourtime",time_gabor)
                view.rootContext().setContextProperty("stepfourvisualization","Visualization not available")
                view.rootContext().setContextProperty("stepfourvisualizationcolor","#FF0D21")
                self.steppreprocessing += 1
                view.rootContext().setContextProperty("textsteppreprocess","Predict")
                mouseareapreprocess.setProperty("visible", False)
                mouseareaclassification.setProperty("visible", True)
                
                
        elif self.model == "CNN":
            
            if self.steppreprocessing == 0:
                image = cv2.imread(self.imageraw, cv2.COLOR_BGR2GRAY)
                start_time = time.time()
                outer_circle , inner_circle , result_image = locate_iris_boundaries(image)
                if result_image is not None:
                    cv2.imwrite('Temp/image_bounderies.png', result_image)
                    view.rootContext().setContextProperty("steponevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steponevisualizationcolor","#07DB00")
                    
                end_time = time.time()
                time_bounderies=end_time-start_time
                view.rootContext().setContextProperty("steponestatus","Done")
                view.rootContext().setContextProperty("steponestatuscolor","#07DB00")
                view.rootContext().setContextProperty("textsteppreprocess","Next")
                view.rootContext().setContextProperty("steponetime",time_bounderies)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_bounderies.png")
                self.iris, self.pupil = outer_circle, inner_circle
                self.steppreprocessing += 1
                
            elif self.steppreprocessing == 1:
                image = cv2.imread('Temp/image_bounderies.png', cv2.IMREAD_GRAYSCALE)
                start_time = time.time()
                normalized = IrisNormalization(image, self.pupil, self.iris)
                end_time = time.time()
                time_normalization = end_time - start_time
                if normalized is not None:
                    cv2.imwrite('Temp/image_normalized.png', normalized)
                    view.rootContext().setContextProperty("steptwovisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steptwovisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("steptwostatus","Done")
                view.rootContext().setContextProperty("steptwostatuscolor","#07DB00")
                view.rootContext().setContextProperty("steptwotime",time_normalization)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_normalized.png")
                self.steppreprocessing += 1   
            elif self.steppreprocessing == 2:
                image = cv2.imread('Temp/image_normalized.png', cv2.IMREAD_GRAYSCALE)
                start_time = time.time()
                roi = ImageEnhancement(image)
                end_time = time.time()
                time_enhancement = end_time - start_time
                if roi is not None:
                    cv2.imwrite('Temp/image_enhanced.png', roi)
                    view.rootContext().setContextProperty("stepthreevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("stepthreevisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("stepthreestatus","Done")
                view.rootContext().setContextProperty("stepthreestatuscolor","#07DB00")
                view.rootContext().setContextProperty("stepthreetime",time_enhancement)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_enhanced.png")
                
                self.steppreprocessing += 1 
                
            elif self.steppreprocessing == 3:
                start_time = time.time()
                self.predictedclass , self.predictiontime = predictwithCNNandNN('Temp/image_enhanced.png')
                end_time = time.time()
                time_cnn = end_time - start_time
                self.predictedclass = str(self.predictedclass)
                view.rootContext().setContextProperty("stepfourstatus","Done")
                view.rootContext().setContextProperty("stepfourstatuscolor","#07DB00")
                view.rootContext().setContextProperty("resultpreprocessingcolor","#07DB00")
                view.rootContext().setContextProperty("resultpreprocessing","Preprocessing finished successfully")
                view.rootContext().setContextProperty("stepfourtime",time_cnn)
                view.rootContext().setContextProperty("stepfourvisualization","Visualization not available")
                view.rootContext().setContextProperty("stepfourvisualizationcolor","#FF0D21")
                self.steppreprocessing += 1
                view.rootContext().setContextProperty("textsteppreprocess","Predict")
                mouseareapreprocess.setProperty("visible", False)
                mouseareaclassification.setProperty("visible", True)

        elif self.model == "SIFT":
            
            if self.steppreprocessing == 0:
                image = cv2.imread(self.imageraw, cv2.COLOR_BGR2GRAY)
                start_time = time.time()
                inner_circle , outer_circle , result_image = locate_iris_boundaries(image)
                if result_image is not None:
                    cv2.imwrite('Temp/image_bounderies.png', result_image)
                    view.rootContext().setContextProperty("steponevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steponevisualizationcolor","#07DB00")
                    
                end_time = time.time()
                time_bounderies=end_time-start_time
                view.rootContext().setContextProperty("steponestatus","Done")
                view.rootContext().setContextProperty("steponestatuscolor","#07DB00")
                view.rootContext().setContextProperty("textsteppreprocess","Next")
                view.rootContext().setContextProperty("steponetime",time_bounderies)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_bounderies.png")
                self.steppreprocessing += 1
                self.iris, self.pupil = outer_circle, inner_circle
                
            elif self.steppreprocessing == 1:
                image = cv2.imread(self.imageraw, 0)
                start_time = time.time()
                self.region = equalize_iris_region(image, self.iris, self.pupil)
                end_time = time.time()
                time_equalizer = end_time - start_time
                if self.region is not None:
                    cv2.imwrite('Temp/image_equalizer.png', self.region)
                    view.rootContext().setContextProperty("steptwovisualization","Generated Successfull")
                    view.rootContext().setContextProperty("steponevisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("steptwostatus","Done")
                view.rootContext().setContextProperty("steptwostatuscolor","#07DB00")
                view.rootContext().setContextProperty("steptwotime",time_equalizer)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_equalizer.png")
                self.steppreprocessing += 1
                
            elif self.steppreprocessing == 2:
                start_time = time.time()
                self.regions, self.plot = segment_regions(self.region, self.pupil, self.iris, display=True)
                end_time = time.time()
                time_segmentation = end_time - start_time
                if self.regions is not None and self.plot is not None:
                    cv2.imwrite('Temp/image_segmentation.png', self.plot)
                    view.rootContext().setContextProperty("stepthreevisualization","Generated Successfull")
                    view.rootContext().setContextProperty("stepthreevisualizationcolor","#07DB00")
                
                view.rootContext().setContextProperty("stepthreestatus","Done")
                view.rootContext().setContextProperty("stepthreestatuscolor","#07DB00")
                view.rootContext().setContextProperty("stepthreetime",time_segmentation)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_segmentation.png")
                self.steppreprocessing += 1
                
            elif self.steppreprocessing == 3:
                start_time = time.time()
                sift_engine = cv2.SIFT_create()
                self.imagekeypoints = detect_keypoints(sift_engine , self.regions)
                end_time = time.time()
                time_keypoint = end_time - start_time
                if self.imagekeypoints is not None:
                    cv2.imwrite('Temp/image_keypoints.png', self.imagekeypoints)
                    view.rootContext().setContextProperty("stepfourvisualization","Generated Successfull")
                    view.rootContext().setContextProperty("stepfourvisualizationcolor","#07DB00")
                
                
                compute_descriptors(sift_engine, self.regions)  
                view.rootContext().setContextProperty("stepfourstatus","Done")
                view.rootContext().setContextProperty("stepfourstatuscolor","#07DB00")
                view.rootContext().setContextProperty("stepfourtime",time_keypoint)
                view.rootContext().setContextProperty("visualizationpreprocessing","Temp/image_keypoints.png")
                view.rootContext().setContextProperty("resultpreprocessingcolor","#07DB00")
                view.rootContext().setContextProperty("resultpreprocessing","Preprocessing finished successfully")
                self.steppreprocessing += 1
                view.rootContext().setContextProperty("textsteppreprocess","Predict")
                mouseareapreprocess.setProperty("visible", False)
                mouseareaclassification.setProperty("visible", True)
                self.predictedclass , self.predictiontime = find_best_match(self.regions)
                self.predictedimagematch = 'Temp\image_matches.png'
                
    @Slot(QObject,QObject)
    def start_classification(self,preprocess,classification):
        preprocess.setProperty("visible", False)
        classification.setProperty("visible", True) 
        view.rootContext().setContextProperty("classpredicted", self.predictedclass)
        view.rootContext().setContextProperty("timepredicted", self.predictiontime)
        if self.model == "SIFT":
            view.rootContext().setContextProperty("chatbotdisucssion","the prediction is done successfully , the predicted class is "+self.predictedclass+" , you can see the matching keypoints in the visualization window")
            view.rootContext().setContextProperty("visualizationclassification",self.predictedimagematch)
        elif self.model == "CNN":
            view.rootContext().setContextProperty("chatbotdisucssion","the prediction is done successfully , the predicted class is "+self.predictedclass+" , sadly the visualization is not available in this model")
        elif self.model == "GABOR":
            view.rootContext().setContextProperty("chatbotdisucssion","the prediction is done successfully , the predicted class is "+self.predictedclass+" , sadly the visualization is not available in this model")
                
        
    @Slot(QObject,QObject,QObject,QObject,QObject)
    def reset_all(self,mouseareapreprocess,mouseareaclassification,rectsift,rectcnn,rectgabor):
        rectangles = [rectsift,rectcnn,rectgabor]
        for rectangle in rectangles:
            rectangle.setProperty("visible", False)
            
        cleantmp()
        self.model = ""
        self.imageraw=""
        self.steppreprocessing=0
        self.predictedclass = ""
        self.predictedimagematch = ""
        self.predictedclass = ""
        self.predictiontime = ""
        view.rootContext().setContextProperty("modelselected", "")
        view.rootContext().setContextProperty("rawimage", "")
        view.rootContext().setContextProperty("steponestatus","Waiting")
        view.rootContext().setContextProperty("steptwostatus","Waiting")
        view.rootContext().setContextProperty("stepthreestatus","Waiting")
        view.rootContext().setContextProperty("stepfourstatus","Waiting")
        view.rootContext().setContextProperty("steponestatuscolor","#ffc100")
        view.rootContext().setContextProperty("steptwostatuscolor","#ffc100")
        view.rootContext().setContextProperty("stepthreestatuscolor","#ffc100")
        view.rootContext().setContextProperty("stepfourstatuscolor","#ffc100")
        view.rootContext().setContextProperty("textsteppreprocess","Start")
        view.rootContext().setContextProperty("modeltitle", "")
        view.rootContext().setContextProperty("accuracymodel", "")
        view.rootContext().setContextProperty("timeprocessing", "")
        view.rootContext().setContextProperty("timeprediction", "")
        view.rootContext().setContextProperty("steponepreprocessing","")
        view.rootContext().setContextProperty("steptwopreprocessing","")
        view.rootContext().setContextProperty("stepthreepreprocessing","")
        view.rootContext().setContextProperty("stepfourpreprocessing","")
        view.rootContext().setContextProperty("robotchat","")
        view.rootContext().setContextProperty("steponevisualization","")
        view.rootContext().setContextProperty("steptwovisualization","")
        view.rootContext().setContextProperty("stepthreevisualization","")
        view.rootContext().setContextProperty("stepfourvisualization","")
        view.rootContext().setContextProperty("steponevisualizationcolor","")
        view.rootContext().setContextProperty("steptwovisualizationcolor","")
        view.rootContext().setContextProperty("stepthreevisualizationcolor","")
        view.rootContext().setContextProperty("stepfourvisualizationcolor","")
        view.rootContext().setContextProperty("steponetime","")
        view.rootContext().setContextProperty("steptwotime","")
        view.rootContext().setContextProperty("stepthreetime","")
        view.rootContext().setContextProperty("stepfourtime","")
        view.rootContext().setContextProperty("visualizationpreprocessing","")
        view.rootContext().setContextProperty("resultpreprocessing","")
        view.rootContext().setContextProperty("resultpreprocessingcolor","")
        view.rootContext().setContextProperty("visualizationclassification","")
        view.rootContext().setContextProperty("chatbotdisucssion","")
        view.rootContext().setContextProperty("classpredicted","")
        view.rootContext().setContextProperty("timepredicted","")
        view.rootContext().setContextProperty("imagemodel","")
        mouseareapreprocess.setProperty("visible", True)
        mouseareaclassification.setProperty("visible", False)
        
        
            
        
        

app = QApplication(sys.argv)
view = QQuickView()
controller = Controller(view)

url = QUrl("Dashboard.qml")
view.setSource(url)

view.rootContext().setContextProperty("controller", controller)

view.setFlags(Qt.FramelessWindowHint | Qt.WindowTitleHint)
view.setColor(Qt.transparent)
view.show()
sys.exit(app.exec())