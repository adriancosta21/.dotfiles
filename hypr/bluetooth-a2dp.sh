#!/bin/bash

# Espera o Bluetooth conectar completamente
sleep 5

# Encontra o card Bluetooth
CARD=$(pactl list short cards | grep bluez_card | awk '{print $1}')

# Define o perfil A2DP
pactl set-card-profile "$CARD" a2dp-sink
