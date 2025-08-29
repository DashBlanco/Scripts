import random
import string

def generar_contraseña():
    # Definimos los caracteres permitidos
    caracteres = string.ascii_letters + string.digits + string.punctuation
    # Longitud aleatoria entre 8 y 14
    longitud = random.randint(8, 14)
    # Generamos la contraseña
    contraseña = ''.join(random.choice(caracteres) for _ in range(longitud))
    return contraseña

def main():
    while True:
        print("\n🔐 Tu contraseña segura es:")
        print(generar_contraseña())
        
        opcion = input("\n¿Quieres generar otra? (s/n): ").strip().lower()
        if opcion != 's':
            print("👋 Saliendo del generador. ¡Hasta luego!")
            break

if __name__ == "__main__":
    main()
