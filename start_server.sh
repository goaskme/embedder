#!/bin/bash

SESSION_NAME="aimatch"
PYTHON_SCRIPT="$HOME/embedder/main.py"
PROJECT_DIR="$HOME/embedder"
VENV_DIR="$PROJECT_DIR/.venv"

# Check if the screen session already exists
if ! screen -list | grep -q "$SESSION_NAME"; then
    echo "Screen session not found. Starting a new one..."
    screen -dmS "$SESSION_NAME" bash -c "cd $PROJECT_DIR && source $VENV_DIR/bin/activate && python3 $PYTHON_SCRIPT"
else
    echo "Screen session '$SESSION_NAME' is already running."
fi
