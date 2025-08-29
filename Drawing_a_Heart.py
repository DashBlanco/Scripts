#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import math
import tkinter as tk

PINK = "#ff66cc"      # Rosa principal
PINK_DARK = "#e055b3" # Rosa más oscuro para contorno y texto

def heart_points(cx, cy, scale=15, steps=720):
    """Genera puntos de la curva de corazón (paramétrica) para un polígono."""
    pts = []
    for i in range(steps + 1):
        t = (2 * math.pi) * (i / steps)
        x = 16 * math.sin(t) ** 3
        y = (13 * math.cos(t)
             - 5 * math.cos(2 * t)
             - 2 * math.cos(3 * t)
             - math.cos(4 * t))
        X = cx + scale * x
        Y = cy - scale * y  # Invertir eje Y para pantalla
        pts.extend([X, Y])
    return pts

def draw_ring_text(canvas, cx, cy, radius, text, font=("Arial", 14, "bold")):
    """Dibuja texto alrededor de un círculo, carácter por carácter, con orientación tangencial."""
    if not text:
        return
    # Repetimos el patrón para rodear completamente el círculo
    # Separador agradable con corazón pequeño
    pattern = f"  {text}  ♥  "
    # Aproximamos un número de caracteres que cubra bien el círculo (depende del tamaño de fuente y radio)
    repeats = max(1, int((2 * math.pi * radius) / 14))  # 14 px aprox por carácter a tamaño 14
    ring = (pattern * repeats)[: repeats * len(pattern)]

    L = len(ring)
    for i, ch in enumerate(ring):
        theta = (2 * math.pi) * (i / L) - math.pi / 2  # comenzar en la parte superior
        x = cx + radius * math.cos(theta)
        y = cy + radius * math.sin(theta)
        angle_deg = math.degrees(theta) + 90  # tangente al círculo
        # Evitar dibujar demasiados espacios
        if ch == " ":
            continue
        canvas.create_text(
            x, y,
            text=ch,
            angle=angle_deg,
            fill=PINK_DARK,
            font=font
        )

def main():
    # Leer nombre desde parámetros
    if len(sys.argv) < 2:
        print("Uso: python3 corazon.py \"Tu Nombre\"")
        sys.exit(1)
    nombre = " ".join(sys.argv[1:]).strip()

    # Ventana y lienzo
    width, height = 800, 600
    root = tk.Tk()
    root.title("Corazón rosa")
    canvas = tk.Canvas(root, width=width, height=height, bg="white", highlightthickness=0)
    canvas.pack()

    # Centro y escalas
    cx, cy = width // 2, height // 2 + 20
    scale = 16  # tamaño del corazón
    pts = heart_points(cx, cy, scale=scale, steps=720)

    # Dibujo del corazón (relleno y contorno)
    canvas.create_polygon(pts, fill=PINK, outline=PINK_DARK, width=3)

    # Texto alrededor (anillo)
    radius = scale * 18  # radio del anillo de texto alrededor del corazón
    draw_ring_text(canvas, cx, cy, radius, nombre)

    # Título sutil encima
    canvas.create_text(cx, cy - radius - 30, text=nombre, fill=PINK_DARK, font=("Arial", 20, "bold"))

    root.mainloop()

if __name__ == "__main__":
    main()
