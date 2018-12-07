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




# random forest baseline 
from sklearn.ensemble import RandomForestClassifier

rfmodel = RandomForestClassifier(n_estimators=100)
rf = rfmodel.fit(train, r_train_labels)

rf_pred = rf.predict(test)

# Model Accuracy, how often is the classifier correct
print("Accuracy: ", metrics.accuracy_score(r_test_labels, rf_pred))

rf_cm = confusion_matrix(r_test_labels, rf_pred,)
print(rf_cm)

y_true = pd.Series(r_test_labels)
rf_pred = pd.Series(rf_pred)

pd.crosstab(y_true, rf_pred, rownames=['True'], colnames=['Predicted'], margins=True)

from sklearn.metrics import classification_report

print(classification_report(y_true, rf_pred))





#filename='200epoch-10batch'
#with open(filename, 'wb') as fp:
#    pickle.dump(batch_acc, fp)
#    pickle.dump(histories, fp)

