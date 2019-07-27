import xgboost as xgb
import pandas as pd
import numpy as np
from xgboost import XGBClassifier
dummy = {'ANZSIC': [12333, 23334, 34341, 34303]}
data = pd.DataFrame.from_dict(dummy)
y = pd.DataFrame({'MD': [1, 1, 0, 0]})
model = XGBClassifier()
model.fit(data,y)
print(model)
y_pred = model.predict(data)

dtrain = xgb.DMatrix(data, y)
param = {'max_depth': 2, 'eta': 1, 'objective': 'binary:logistic'}
bst = xgb.train(param, dtrain)
bst.save_model('xgboost.model')
bst.predict(dtrain)
