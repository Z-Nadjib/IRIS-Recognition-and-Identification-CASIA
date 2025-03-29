import cv2
import numpy as np
from tensorflow.keras.models import load_model
import time

def predictwithCNNandNN(image):
    
    model = load_model('Backend\C_CNN_NN\Model\CNN_NN.h5')
    # Charger l'image
    img = cv2.imread(image)
    # Redimensionner l'image à la taille attendue par le modèle
    img_resized = cv2.resize(img, (150, 200))
    # Normaliser l'image
    img_normalized = img_resized / 255.0
    # Ajouter une dimension supplémentaire pour correspondre à la forme attendue par le modèle
    img_normalized = np.expand_dims(img_normalized, axis=0)
    # Faire la prédiction avec le modèle
    start = time.time()
    prediction = model.predict(img_normalized)
    end = time.time()
    
    prediction_time = end - start
    
    predicted_class = np.argmax(prediction)
    # Renvoyer la prédiction
    return predicted_class , prediction_time

