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
data = pd.read_csv('merged-rand.txt', sep='\t')
types = pd.read_csv('types-rand.txt', sep='\t')
labels = pd.read_csv('labels-rand.txt', sep='\t')


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

model = tf.keras.Sequential()
model.add(layers.Dense(128, activation='sigmoid'))
model.add(layers.Dense(128, activation='sigmoid'))
model.add(layers.Dense(7, activation='softmax'))
model.compile(optimizer=tf.train.RMSPropOptimizer(0.00021544),
              loss='categorical_crossentropy',
              metrics=['accuracy'])

model.fit(train, encoded_train, validation_data=(test, encoded_test), epochs=200, batch_size=32)

pred_y = model.predict_classes(test)
nnyhat = confusion_matrix(test_types, pred_y)
accuracy = metrics.accuracy_score(test_labels, pred_y)
print("Accuracy: ", accuracy)
print(nnyhat)

y_true = pd.Series(r_test_types)
y_pred = pd.Series(pred_y)

pd.crosstab(y_true, y_pred, rownames=['True'], colnames=['Predicted'], margins=True)

from sklearn.metrics import classification_report
from sklearn.metrics import accuracy_score
print(classification_report(y_true, pred_y))


print(classification_report(test_types, pred_y))
print(accuracy_score(test_types, pred_y, normalize=True, sample_weight=None))
