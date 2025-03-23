# -*- coding: utf-8 -*-
"""

@author: Yassine
"""

import pandas as pd
from sklearn.linear_model import LogisticRegression
import numpy as np
from sklearn import metrics #Generate accuracy score

#Importing csv
X_Train = pd.read_csv (r'X_Train.csv')
Y_Train = pd.read_csv (r'Y_Train.csv')
X_Test = pd.read_csv (r'X_Test.csv')
Y_Test = pd.read_csv (r'Y_Test.csv')

#Convert to numpy array
X_Train = np.array(X_Train)
Y_Train = np.array(Y_Train)
X_Test = np.array(X_Test)
Y_Test = np.array(Y_Test)

#Initialise the model
model = LogisticRegression(C=100) #plus C est grande plus on a la regularisation

#Fit the model
model.fit(X_Train,Y_Train)
pred = model.predict(X_Test)
score = metrics.accuracy_score(Y_Test,pred)
conf = metrics.plot_confusion_matrix(model, X_Test, Y_Test)

########################PREDICTION###########################################
pro = pd.read_csv (r'Pro.csv')
nonpro = pd.read_csv (r'nonPro.csv')

pro = np.array(pro).reshape(1,17)
nonpro = np.array(nonpro).reshape(1,17)

predp = model.predict(pro)
prednonp = model.predict(nonpro)

score = metrics.accuracy_score(Y_Test,pred)

def affichage(pred) :
    print("####Cette email est professionnel####") if pred == 1 else print("####Cet email n'est pas professionnel####")
    


affichage(predp)
affichage(prednonp)