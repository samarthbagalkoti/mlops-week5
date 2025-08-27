# test_train.py
import json

def test_accuracy():
    with open("metrics.json", "r") as f:
        metrics = json.load(f)
    assert metrics["accuracy"] >= 1.0, "Model accuracy is too low!"

