#!/bin/zsh

# Verifica que se pase un argumento
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <nombre_del_proyecto>"
    exit 1
fi

# Clona el repositorio
git clone https://github.com/victorcode1/templete.git $1

# Reemplaza "templete" por el nombre del proyecto
sed -i '' "s/templete/$1/g" $1/pubspec.yaml
sed -i '' "s/com.example.templete/com.$1.$1/g" $1/android/app/build.gradle
sed -i '' "s/com.example.templete/com.$1.$1/g" $1/ios/Runner.xcodeproj/project.pbxproj

# Reemplaza la estructura de carpetas en Android
mkdir -p $1/android/app/src/main/kotlin/com/$1/$1
mv $1/android/app/src/main/kotlin/com/example/templete/* $1/android/app/src/main/kotlin/com/$1/$1
rm -rf $1/android/app/src/main/kotlin/com/example

# Reemplaza la estructura de carpetas en iOS
mv $1/ios/Runner/com.example.templete/ $1/ios/Runner/com.$1.$1/

# Reemplaza la línea package en MainActivity.kt
sed -i '' "s/package com.example.templete/package com.$1.$1/g" $1/android/app/src/main/kotlin/com/$1/$1/MainActivity.kt

# Reemplaza la etiqueta android:label en AndroidManifest.xml
sed -i '' "s/android:label=\"templete\"/android:label=\"$1\"/g" $1/android/app/src/main/AndroidManifest.xml

# Abre el proyecto en Visual Studio Code
code $1

# Actualiza las dependencias de Flutter
cd $1
flutter pub get
