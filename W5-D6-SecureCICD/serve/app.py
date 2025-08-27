# serve/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class PredictRequest(BaseModel):
    x: float

@app.get("/healthz")
def healthz():
    return {"status": "ok"}

@app.post("/predict")
def predict(req: PredictRequest):
    # Dummy linear: y = 2x
    return {"y": 2 * req.x}

