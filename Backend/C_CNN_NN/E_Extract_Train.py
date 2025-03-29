
import os
import numpy as np
import cv2
import pandas as pd
from sklearn.model_selection import train_test_split
from keras.constraints import max_norm # type: ignore
from keras.models import Sequential # type: ignore
from keras.layers import Conv2D, MaxPooling2D, Flatten, Dense, Dropout # type: ignore
from keras.optimizers import SGD # type: ignore
from keras.constraints import max_norm # type: ignore
from keras.utils import to_categorical # type: ignore


def createCNNModel(num_classes):
    model = Sequential()
    model.add(Conv2D(32, (3, 3), input_shape=(200, 150, 3), padding='same', activation='relu', kernel_constraint=max_norm(3)))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Conv2D(64, (3, 3), padding='same', activation='relu', kernel_constraint=max_norm(3)))
    model.add(MaxPooling2D(pool_size=(2, 2)))
    model.add(Conv2D(128, (3, 3), padding='same', activation='relu', kernel_constraint=max_norm(3)))
    model.add(MaxPooling2D(pool_size=(2, 2)))

    model.add(Flatten())
    model.add(Dense(512, activation='relu', kernel_constraint=max_norm(3)))
    model.add(Dropout(0.3))
    model.add(Dense(256, activation='relu', kernel_constraint=max_norm(3)))
    model.add(Dense(num_classes, activation='softmax'))

    epochs = 100
    learning_rate = 0.01
    decay = learning_rate / epochs
    sgd = SGD(learning_rate=learning_rate, momentum=0.9, decay=decay, nesterov=False)
    model.compile(loss='categorical_crossentropy', optimizer=sgd, metrics=['accuracy'])
    print(model.summary())
    return model, epochs




preprocessed_data = 'Backend/0_Data/Preprocessed_Data'
label = []
data = []
for folder in os.listdir(preprocessed_data):  
      folder_path = os.path.join(preprocessed_data, folder)
      for image_preprocessed in os.listdir(folder_path):
        input_preprocessedimg = cv2.imread(os.path.join(folder_path,image_preprocessed))
        img = cv2.resize(input_preprocessedimg,(150,200))
        label.append(folder)
        data.append(img)
        
        
# Convertir la liste 'data' et la liste 'label' en tableaux numpy
data = np.array(data)
label = np.array(label)

# Normaliser les données en les divisant par 255
data_normalized = data / 255.0


# Diviser les données en ensembles d'entraînement (70%) et de test (30%)
train_data, test_data, train_label, test_label = train_test_split(data_normalized, label, test_size=0.2, random_state=42)


train_label = np.array(train_label)
test_label = np.array(test_label)
train_label = to_categorical(train_label)
test_label = to_categorical(test_label)
num_classes = train_label.shape[1]
print('data normalized and hot encoded')
print(num_classes)


num_classes = 65
model,epochs = createCNNModel(num_classes)
print("CNN MODEL created.")
history = model.fit(train_data, train_label, epochs=epochs, batch_size=32)
# Évaluer le modèle sur l'ensemble de test
test_loss, test_accuracy = model.evaluate(test_data, test_label)
print("Test Loss:", test_loss)
print("Test Accuracy:", test_accuracy)

