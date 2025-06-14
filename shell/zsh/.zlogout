#!/bin/bash

if pgrep -x "ollama" > /dev/null; then
  echo "Apagando servicio ollama..."
  # ollama stop
else
  echo "El servicio ollama no está corriendo."
fi
