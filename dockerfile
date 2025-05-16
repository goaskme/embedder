FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && apt-get clean

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy your FastAPI app code
COPY . .

# Expose port 5000
EXPOSE 5000

# Run the FastAPI app on port 5000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
