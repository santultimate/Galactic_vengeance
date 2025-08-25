#!/bin/bash

# Script pour tester rapidement différents niveaux de zoom
# Usage: ./test_zoom_levels.sh [zoom_level]
# Exemple: ./test_zoom_levels.sh 8 (pour tester un zoom de 8x)

echo "🧪 Test de niveaux de zoom pour Galactic Vengeance"

# Niveau de zoom à tester
ZOOM_LEVEL=${1:-8}

echo "📏 Test du zoom: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Créer l'icône avec le zoom de test
echo "🔍 Création de l'icône de test..."
magick assets/images/icone.png -resize ${ZOOM_LEVEL}00% -gravity center -extent 1024x1024 assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Icône de test créée avec zoom ${ZOOM_LEVEL}x"
    
    # Afficher les informations sur la nouvelle image
    echo "📊 Informations sur l'icône de test:"
    file assets/images/icon_zoomed.png
    ls -lh assets/images/icon_zoomed.png
else
    echo "❌ Erreur lors de la création de l'icône de test"
    exit 1
fi

# Générer les icônes
echo "🚀 Génération des icônes..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Icônes générées avec succès !"
    echo ""
    echo "🧪 Test prêt !"
    echo "📱 Zoom appliqué: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"
    echo ""
    echo "🎯 Pour tester l'icône:"
    echo "   flutter clean"
    echo "   flutter pub get"
    echo "   flutter run"
    echo ""
    echo "📋 Évaluez la visibilité de l'icône et notez vos observations"
    echo "📋 Si l'icône est encore trop petite, testez un zoom plus important"
    echo "📋 Si l'icône est trop grande, testez un zoom plus faible"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Test de zoom terminé !"
