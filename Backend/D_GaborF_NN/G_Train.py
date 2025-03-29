
import numpy as np
import matplotlib.pyplot as plt
from keras.utils import to_categorical # type: ignore
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from keras.models import Sequential # type: ignore
from keras.layers import Dense # type: ignore
from keras.optimizers import SGD # type: ignore
from keras.constraints import max_norm # type: ignore
from keras.layers import Dropout # type: ignore
from F_ExtractFeature import FeatureExtraction
import cv2
import os



preprocessed_data = 'Backend/0_Data/Preprocessed_Data'
label = []
data = []
for folder in os.listdir(preprocessed_data):  
      folder_path = os.path.join(preprocessed_data, folder)
      for image_preprocessed in os.listdir(folder_path):
        input_preprocessedimg = cv2.imread(os.path.join(folder_path,image_preprocessed))
        img= cv2.cvtColor(input_preprocessedimg, cv2.COLOR_BGR2GRAY)
        label.append(folder)
        data.append(img)
        

new_data = []
new_data = FeatureExtraction(data)

f1 = np.array(label)
f2 = np.array(new_data)


# Assuming f1 and f2 are your data features and labels
x = f2
y_ = f1
y = to_categorical(y_)  # Use to_categorical from keras.utils to one-hot encode labels

# Split the data for training and testing
train_x, test_x, train_y, test_y = train_test_split(x, y, test_size=0.20)

# Build the model
model = Sequential()
model.add(Dense(1024, input_shape=(6144,), activation='relu', name='fc1'))
model.add(Dense(2048, activation='relu', name='fc2'))
model.add(Dense(65, activation='softmax', name='output'))

# Define optimizer
optimizer = SGD(momentum=0.9)

# Compile the model
model.compile(optimizer, loss='categorical_crossentropy', metrics=['accuracy'])

print('Neural Network Model Summary: ')
print(model.summary())

model.fit(train_x, train_y,validation_data=(test_x,test_y), verbose=1, epochs=100)

train_loss = model.history.history['loss']
val_loss = model.history.history['val_loss']
train_acc = model.history.history['accuracy']
val_acc = model.history.history['val_accuracy']
xc = range(100)

plt.figure(figsize=(20,10))
plt.plot(xc,train_acc,label = 'Train accuracy')
plt.plot(xc,val_acc,label='Test accuracy')
plt.legend(loc='upper left',prop={'size':20})
plt.title('Train and Test Accuracy plot',size=20)
plt.xlabel('Epochs',size=20)
plt.ylabel('Accuracy',size=20)

# Sauvegarder le modèle
model.save('Gabor+NN.h5')

print("Le modèle a été sauvegardé avec succès !")