#!/bin/bash

# Tumhara container ka naam yahaan daalo
CONTAINER_NAME="tumhara-container-naam"

# Check karo container chal raha hai ya nahi
if [ "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Arey meri jaan, container '$CONTAINER_NAME' already up hai"
else
    echo "Oh no! Container '$CONTAINER_NAME' down hai"
    echo "Chalo usko up karte hain abhi ke abhi"
    docker start $CONTAINER_NAME

    if [ $? -eq 0 ]; then
        echo "Yayyy! Container '$CONTAINER_NAME' ab up ho gaya hai"
    else
        echo "Uff... kuch gadbad ho gayi. Container up nahi hua"
    fi
fi

