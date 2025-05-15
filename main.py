from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import tensorflow as tf
import tensorflow_hub as hub
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

logger = logging.getLogger(__name__)


app = FastAPI()

# Load the Universal Sentence Encoder model once at startup
model = hub.load("https://tfhub.dev/google/universal-sentence-encoder/4")


class KeywordRequest(BaseModel):
    keywords: List[str]

@app.post("/api/embed")
def get_embedding(request: KeywordRequest):
    try:
        text = " ".join(request.keywords)
        embeddings = model([text])  # shape: [1, 512]
        result = embeddings.numpy().tolist()  # Convert tensor to Python list
        logger.info("Embedding generated successfully for keywords: %s", request.keywords)
        return {"embedding": result[0]}
    except Exception as e:
        print("Error in creating embedding message:", e)
        logger.exception("Error in creating embedding:")
        raise HTTPException(status_code=500, detail=str(e))

# if __name__ == "__main__":
#     import uvicorn
#     uvicorn.run(app, host="0.0.0.0", port=8000)