#!/bin/bash

SESSION_NAME="embedder"
PYTHON_SCRIPT="$HOME/embedder/main.py"
PROJECT_DIR="$HOME/embedder"
VENV_DIR="$PROJECT_DIR/.venv"
PORT_TO_KILL=8000  # <-- Change this port if needed

# Check if the screen session exists
if ! screen -list | grep -q "$SESSION_NAME"; then
    echo "Screen session not found. Cleaning up port $PORT_TO_KILL if occupied..."

    PORT_PID=$(lsof -ti:$PORT_TO_KILL)
    if [ -n "$PORT_PID" ]; then
        echo "Port $PORT_TO_KILL is in use by PID(s): $PORT_PID. Killing..."
        kill -9 $PORT_PID
    else
        echo "Port $PORT_TO_KILL is already free."
    fi

    echo "Starting new screen session..."
    screen -dmS "$SESSION_NAME" bash -c "cd $PROJECT_DIR && source $VENV_DIR/bin/activate && python3 $PYTHON_SCRIPT"
else
    echo "Screen session '$SESSION_NAME' is already running. No action needed."
fi
