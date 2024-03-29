#!/bin/zsh

# Función para encontrar la ubicación de Flutter en el sistema
find_flutter_path() {
    # Obtenemos los directorios listados en la variable de entorno PATH
    local -a path_directories=("${(@s/:/)PATH}")

    # Variable para almacenar la ubicación de Flutter
    local flutter_directory

    # Iteramos sobre los directorios en la variable PATH para encontrar la ubicación de Flutter
    for directory in $path_directories; do
        # Verificamos si el directorio contiene un archivo ejecutable llamado "flutter"
        if [[ -x "$directory/flutter" ]]; then
            flutter_directory="$directory"
            echo "La ruta de Flutter en este equipo es: $flutter_directory"

            # Clonar el repositorio hack-f si se encuentra la carpeta de Flutter
            echo "Clonando el repositorio hack-f..."
            git clone https://github.com/victorcode1/hack-f.git
            echo "Repositorio clonado exitosamente."

            # Cambiamos al directorio padre
            cd "$flutter_directory/.."

            # Buscamos el archivo "analyze_all_templates_test.dart" y mostramos el path si lo encontramos
            local analyze_file=$(find . -name "analyze_all_templates_test.dart" -print -quit)
            if [[ -n "$analyze_file" ]]; then
                echo "El archivo analyze_all_templates_test.dart se encuentra en: $PWD/$analyze_file"
            else
                echo "No se encontró el archivo analyze_all_templates_test.dart en este proyecto."
            fi
            return 0
        fi
    done

    # Si no se encuentra la ruta de Flutter, mostramos un mensaje de error
    echo "No se encontró la ruta de Flutter en este equipo."
    return 1
}

# Llamamos a la función para encontrar la ubicación de Flutter y clonar el repositorio hack-f si se encuentra
find_flutter_path
