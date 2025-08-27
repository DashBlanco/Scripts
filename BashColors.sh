#!/bin/bash

for color in $(seq 1 245);
do
    echo -e "$color: \\033[38;5;${color}m TEXTO: 38;5;${color} \\033[48;5;${color}m FONDO: 48;5;${color} \\033[0m"
done