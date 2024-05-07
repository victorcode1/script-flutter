#!/bin/zsh
clear

# Función para encontrar la ubicación de Flutter en el sistema
find_flutter_path() {
    # Obtenemos los directorios listados en la variable de entorno PATH
    local -a path_directories=("${(@s/:/)PATH}")

    # Iteramos sobre los directorios en la variable PATH para encontrar la ubicación de Flutter
    for directory in $path_directories; do
        # Verificamos si el directorio contiene un archivo ejecutable llamado "flutter"
        if [[ -x "$directory/flutter" ]]; then
            echo "La ruta de Flutter en este equipo es: $directory"
            if [[ -d "hack-f" ]]; then
                rm -rf hack-f
            fi
            # Clonar el repositorio hack-f
            git clone https://github.com/victorcode1/hack-f.git

            # Obtener la ruta del directorio donde se clonó el repositorio
            local repo_directory="$PWD/hack-f"
            echo "El repositorio hack-f se ha clonado en: $repo_directory"

            # Cambiamos al directorio padre
            cd "$directory/.."

            # Buscamos el archivo "globals.dart" y lo eliminamos si lo encontramos
          local global_file=$(find . -name "templates" -print -quit)
if [[ -n "$global_file" ]]; then
    git clone https://github.com/victorcode1/templete.git "$global_file/skeleton/d"

    echo "se encontro templates"
    echo "++++++++"
else
    echo "No se encontró el archivo globals.dart en este proyecto."
fi
            local global_file=$(find . -name "create.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/create.dart" "$PWD/${global_file%/*}"
                echo "El archivo create.dart ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi

            local global_file=$(find . -name "analyze_all_templates_test.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/analyze_all_templates_test.dart" "$PWD/${global_file%/*}"
                echo "El archivo analyze_all_templates_test.dart ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi

            local global_file=$(find . -name "create_test.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/create_test.dart" "$PWD/${global_file%/*}"
                echo "El archivo create_test.dart ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi

            local global_file=$(find . -name "create_usage_test.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/create_usage_test.dart" "$PWD/${global_file%/*}"
                echo "El archivo create_usage_test.dart ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi

            local global_file=$(find . -name "flutter_project_metadata.dart" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/flutter_project_metadata.dart" "$PWD/${global_file%/*}"
                echo "El archivo flutter_project_metadata.dart ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi

            local global_file=$(find . -name "template_manifest.json" -print -quit)
            if [[ -n "$global_file" ]]; then
                rm "$global_file"
                echo "El archivo globals.dart ha sido eliminado."

                # Mover el archivo analyze_all_templates_test.dart desde el repositorio clonado al lugar donde estaba el archivo borrado
                mv "$repo_directory/template_manifest.json" "$PWD/${global_file%/*}"
                echo "El archivo template_manifest.json ha sido movido a: $PWD/${global_file%/*}"
            else
                echo "No se encontró el archivo globals.dart en este proyecto."
            fi



            # Buscamos y mostramos los paths de otros archivos especificados





            return 0
        fi
    done

    # Si no se encuentra la ruta de Flutter, mostramos un mensaje de error
    echo "No se encontró la ruta de Flutter en este equipo."
    return 1
}

# Función para buscar y mostrar el path de un archivo
buscar_y_mostrar() {
    local file="$1"
    local global_file=$(find . -name "$file" -print -quit)
    if [[ -n "$global_file" ]]; then
        echo "El archivo $file se encuentra en: $PWD/$global_file"
    else
        echo "No se encontró el archivo $file en este proyecto."
    fi
}

# Llamamos a la función para encontrar la ubicación de Flutter
find_flutter_path