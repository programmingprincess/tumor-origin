import tensorflow as tf
import numpy
import pandas as pd 
from tensorflow.keras import layers 
from tensorflow.keras.utils import to_categorical

from numpy import random

from sklearn import metrics
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt

import cPickle as pickle



# raw working 
data = pd.read_csv('raw.txt', sep='\t')
types = pd.read_csv('types-numeric.txt', sep='\t')
labels = pd.read_csv('types-labels.txt', sep='\t')


# train test split 
random.seed(69)
ii = numpy.random.rand(len(data)) < 0.7 

np_data = data.values
np_types = types.values
np_labels = labels.values

train = np_data[ii]
test = np_data[~ii]

train_types = np_types[ii]
test_types = np_types[~ii]

train_labels = np_labels[ii]
test_labels = np_labels[~ii] 

r_train_types = train_types.ravel()
r_test_types = test_types.ravel()

r_train_labels = train_labels.ravel()
r_test_labels = test_labels.ravel()


# One hot encoding for keras model 
encoded_train = to_categorical(r_train_types)
encoded_test = to_categorical(r_test_types)


learningRate = 5.1794746792312125e-05

# encoded labels are one-hot encoded 
# Test labels are treated with ravel
batch_acc = {} 
histories = {}
def learnLoss(batch, epochs, train, encoded_train, test, encoded_test, test_labels):
    model = tf.keras.Sequential()
    model.add(layers.Dense(128, activation='sigmoid'))
    model.add(layers.Dense(128, activation='sigmoid'))
    model.add(layers.Dense(17, activation='softmax'))
    model.compile(optimizer=tf.train.RMSPropOptimizer(learningRate),
              loss='categorical_crossentropy',
              metrics=['accuracy'])
    
    model.fit(train, encoded_train, validation_data=(test, encoded_test), epochs=epochs, batch_size=batch)
    
    
    # test 
    pred_y = model.predict_classes(test)
    nnyhat = confusion_matrix(test_types, pred_y)
    accuracy = metrics.accuracy_score(test_labels, pred_y)
    print("Accuracy: ", accuracy)
    batch_acc[batch] = accuracy 
    histories[batch] = model.history.history

# filename='goodrates'
# with open(filename, 'rb') as fp:
#     goodrates = pickle.load(fp)

#learningRates =  numpy.geomspace(0.01, 0.000001, num=50)
for b in range(1,2000,100):
    learnLoss(b, 200, train, encoded_train, test, encoded_test, r_test_types)


# pickle batch_acc and histories dictionaries 
filename='200epoch-batch'
with open(filename, 'wb') as fp:
    pickle.dump(batch_acc, fp)
    pickle.dump(histories, fp)

