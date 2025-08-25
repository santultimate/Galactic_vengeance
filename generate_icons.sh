#!/bin/bash

# Script pour générer des icônes avec zoom pour Galactic Vengeance
# Usage: ./generate_icons.sh [zoom_level]
# Exemple: ./generate_icons.sh 1.2 (pour 20% de zoom)

echo "🎨 Génération d'icônes pour Galactic Vengeance"

# Niveau de zoom par défaut (1.2 = 20% de zoom)
ZOOM_LEVEL=${1:-1.2}

echo "📏 Niveau de zoom: ${ZOOM_LEVEL}x"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Créer l'icône zoomée
echo "🔍 Création de l'icône avec zoom..."
magick assets/images/icone.png -resize ${ZOOM_LEVEL}00% -gravity center -extent 1024x1024 assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Icône zoomée créée: assets/images/icon_zoomed.png"
else
    echo "❌ Erreur lors de la création de l'icône zoomée"
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
    echo "🎯 Pour voir les changements, redémarrez l'application"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Génération terminée !"
