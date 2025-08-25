#!/bin/bash

# Script simple pour appliquer un zoom à l'icône
# Usage: ./apply_zoom.sh [pourcentage]
# Exemple: ./apply_zoom.sh 150 (pour 150% de zoom)

echo "🔍 Application de zoom pour Galactic Vengeance"

# Pourcentage de zoom par défaut (150%)
ZOOM_PERCENT=${1:-150}

echo "📏 Zoom appliqué: ${ZOOM_PERCENT}%"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Créer l'icône avec le zoom spécifié
echo "🔍 Création de l'icône avec zoom ${ZOOM_PERCENT}%..."
magick assets/images/icone.png -resize ${ZOOM_PERCENT}% -gravity center -extent 1024x1024 assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Icône créée avec zoom ${ZOOM_PERCENT}%"
    
    # Afficher les informations sur la nouvelle image
    echo "📊 Informations sur l'icône:"
    ls -lh assets/images/icon_zoomed.png
else
    echo "❌ Erreur lors de la création de l'icône"
    exit 1
fi

# Générer les icônes
echo "🚀 Génération des icônes..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Icônes générées avec succès !"
    echo ""
    echo "🎯 Zoom appliqué: ${ZOOM_PERCENT}%"
    echo "🎯 Pour voir les changements:"
    echo "   flutter clean"
    echo "   flutter pub get"
    echo "   flutter run"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Zoom appliqué avec succès !"
