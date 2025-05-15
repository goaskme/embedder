from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import tensorflow as tf
import tensorflow_hub as hub

app = FastAPI()

# Load the Universal Sentence Encoder model once at startup
model = hub.load("https://tfhub.dev/google/universal-sentence-encoder/4")

class KeywordRequest(BaseModel):
    keywords: List[str]

@app.post("/embed")
def get_embedding(request: KeywordRequest):
    try:
        text = " ".join(request.keywords)
        embeddings = model([text])  # shape: [1, 512]
        result = embeddings.numpy().tolist()  # Convert tensor to Python list
        return {"embedding": result[0]}
    except Exception as e:
        print("Error in creating embedding message:", e)
        raise HTTPException(status_code=500, detail=str(e))

