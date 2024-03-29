#!/bin/zsh

# Función para encontrar la ubicación de Flutter en el sistema
find_flutter_path() {
    # Obtenemos los directorios listados en la variable de entorno PATH
    local -a path_directories=("${(@s/:/)PATH}")

    # Iteramos sobre los directorios en la variable PATH para encontrar la ubicación de Flutter
    for directory in $path_directories; do
        # Verificamos si el directorio contiene un archivo ejecutable llamado "flutter"
        if [[ -x "$directory/flutter" ]]; then
            echo "La ruta de Flutter en este equipo es: $directory"
            # Cambiamos al directorio padre
            cd "$directory/.."
            # Buscamos el archivo "globals.dart" y mostramos el path si lo encontramos
            local global_file=$(find . -name "globals.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                echo "El archivo globals.dart se encuentra en: $PWD/$global_file"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi
            return 0
        fi
    done

    # Si no se encuentra la ruta de Flutter, mostramos un mensaje de error
    echo "No se encontró la ruta de Flutter en este equipo."
    return 1
}

# Llamamos a la función para encontrar la ubicación de Flutter
find_flutter_path