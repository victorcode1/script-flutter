#!/bin/zsh
clear
# Función para encontrar la ubicación de Flutter en el sistema
find_flutter_path() {
    # Obtenemos los directorios listados en la variable de entorno PATH
    local -a path_directories=(${(s/:/)PATH})
    # Iteramos sobre los directorios en la variable PATH para encontrar la ubicación de Flutter
    for directory in $path_directories; do
        # Verificamos si el directorio contiene un archivo ejecutable llamado "flutter"
        if [[ -x "$directory/flutter" ]]; then
            # Extraemos el directorio padre de la ruta actual (eliminando /bin/ de la ruta)
            local parent_directory=$(dirname "$directory")
            echo "$parent_directory"
            return 0
        fi
    done

    # Si no se encuentra la ruta de Flutter, mostramos un mensaje de error y retornamos 1
    echo "No se encontró la ruta de Flutter en este equipo."
    return 1
}

# Función para modificar el archivo flutter_project_metadata.dart
# modify_flutter_project_metadata() {
#     local flutter_path="$1"
#     echo "La ruta de Flutter en este equipo es: $flutter_path"
#     local metadata_file="$flutter_path/packages/flutter_tools/lib/src/flutter_project_metadata.dart"
# 
#     # Verificamos si el archivo flutter_project_metadata.dart existe
#     if [ -f "$metadata_file" ]; then
#         # Modificamos el archivo para agregar "test" como un proyecto de Flutter
#         sed -i '' '/enum FlutterProjectType implements CliEnum {/a\
#   test,
# ' "$metadata_file"
#         sed -i '' '/String get helpText => switch (this) {/a\
#   FlutterProjectType.test => '"'"'Generate a List View / Detail View Flutter application that follows community best practices.'"'"',
# ' "$metadata_file"
#         echo "Se ha modificado el archivo flutter_project_metadata.dart correctamente."
#     else
#         echo "No se encontró el archivo flutter_project_metadata.dart."
#     fi
# }

# Función para modificar el archivo create.dart
modify_create_dart() {
    local flutter_path="$1"
    echo "La ruta de Flutter en este equipo es: $flutter_path"
    local create_dart_file="$flutter_path/packages/flutter_tools/lib/src/commands/create.dart"

    # Verificamos si el archivo create.dart existe
    if [ -f "$create_dart_file" ]; then
        # Verificamos si ya se ha agregado el caso "test" previamente
        if ! grep -q "case FlutterProjectType.test:" "$create_dart_file"; then
            # Modificamos el archivo para agregar el caso "test" en la línea adecuada
            sed -i '' '/ switch (template) {/a\
        case FlutterProjectType.test:\
          generatedFileCount += await generateApp(\
            <String>['\''test'\''],\
            relativeDir,\
            templateContext,\
            overwrite: overwrite,\
            printStatusWhenWriting: !creatingNewProject,\
            generateMetadata: false,\
          );\
          pubContext = PubContext.create;\
' "$create_dart_file"
            echo "Se ha agregado el caso 'test' al archivo create.dart correctamente."
        else
            echo "El caso 'test' ya está presente en el archivo create.dart."
        fi
        
        # Agregar la línea 'case FlutterProjectType.test:' debajo de 'case FlutterProjectType.module:'
        sed -i '' '/case FlutterProjectType.module:/a\
    case FlutterProjectType.test:\
      gradleWrapperPropertiesFilePath = globals.fs.path.join(projectDirPath, '"'"'android/gradle/wrapper/gradle-wrapper.properties);' "$create_dart_file"
        echo "Se ha agregado el caso 'test' al caso 'module' en el archivo create.dart correctamente."
    else
        echo "No se encontró el archivo create.dart."
    fi
}




# Obtener la ubicación de Flutter en el sistema
flutter_path=$(find_flutter_path)

# Verificamos si se encontró la ubicación de Flutter
if [ -n "$flutter_path" ]; then
    # Modificamos el archivo flutter_project_metadata.dart
    modify_flutter_project_metadata "$flutter_path"
    
    # Modificamos el archivo create.dart
    modify_create_dart "$flutter_path"
else
    echo "No se encontró la ubicación de Flutter en el sistema."
fi
