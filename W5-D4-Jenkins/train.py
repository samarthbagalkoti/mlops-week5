# train.py
import numpy as np
from sklearn.linear_model import LinearRegression
import json

# generate dummy data
X = np.array([[1], [2], [3], [4], [5]])
y = np.array([2, 4, 6, 8, 10])  # y = 2x

model = LinearRegression()
model.fit(X, y)

# evaluate
preds = model.predict([[6]])
acc = 1.0 if round(preds[0]) == 12 else 0.0

# save metrics
metrics = {"accuracy": acc}
with open("metrics.json", "w") as f:
    json.dump(metrics, f)

print("Training complete. Accuracy:", acc)

