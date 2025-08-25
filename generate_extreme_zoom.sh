#!/bin/bash

# Script pour générer des icônes avec zoom extrême pour Galactic Vengeance
# Usage: ./generate_extreme_zoom.sh [zoom_level]
# Exemple: ./generate_extreme_zoom.sh 10 (pour 1000% de zoom)

echo "🔍 Génération d'icônes avec zoom extrême pour Galactic Vengeance"

# Niveau de zoom par défaut (5 = 500% de zoom)
ZOOM_LEVEL=${1:-5}

echo "📏 Niveau de zoom extrême: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Créer l'icône avec zoom extrême
echo "🔍 Création de l'icône avec zoom extrême..."
magick assets/images/icone.png -resize ${ZOOM_LEVEL}00% -gravity center -extent 1024x1024 assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Icône avec zoom extrême créée: assets/images/icon_zoomed.png"
    
    # Afficher les informations sur la nouvelle image
    echo "📊 Informations sur l'icône générée:"
    file assets/images/icon_zoomed.png
    ls -lh assets/images/icon_zoomed.png
else
    echo "❌ Erreur lors de la création de l'icône avec zoom extrême"
    exit 1
fi

# Générer les icônes pour toutes les plateformes
echo "🚀 Génération des icônes pour toutes les plateformes..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Icônes générées avec succès !"
    echo ""
    echo "📱 Icônes créées pour:"
    echo "   - Android (avec icône adaptative)"
    echo "   - iOS"
    echo "   - Web"
    echo "   - Windows"
    echo "   - macOS"
    echo "   - Linux"
    echo ""
    echo "🎯 Zoom appliqué: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"
    echo "🎯 Pour voir les changements, redémarrez l'application"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Génération avec zoom extrême terminée !"
