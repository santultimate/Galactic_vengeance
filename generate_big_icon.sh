#!/bin/bash

# Script pour générer des icônes vraiment grandes et visibles
# Usage: ./generate_big_icon.sh [zoom_level]
# Exemple: ./generate_big_icon.sh 50 (pour un zoom de 5000%)

echo "🔍 Génération d'icônes TRÈS grandes pour Galactic Vengeance"

# Niveau de zoom par défaut (50 = 5000% de zoom)
ZOOM_LEVEL=${1:-50}

echo "📏 Zoom TRÈS important: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Créer l'icône avec zoom très important
echo "🔍 Création de l'icône TRÈS grande..."
magick assets/images/icone.png -resize ${ZOOM_LEVEL}00% -gravity center -extent 1024x1024 assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Icône TRÈS grande créée: assets/images/icon_zoomed.png"
    
    # Afficher les informations sur la nouvelle image
    echo "📊 Informations sur l'icône générée:"
    file assets/images/icon_zoomed.png
    ls -lh assets/images/icon_zoomed.png
    
    # Vérifier la taille de l'image
    IMAGE_SIZE=$(ls -lh assets/images/icon_zoomed.png | awk '{print $5}')
    echo "📏 Taille de l'icône: $IMAGE_SIZE"
else
    echo "❌ Erreur lors de la création de l'icône TRÈS grande"
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
    echo "🎯 Zoom TRÈS important appliqué: ${ZOOM_LEVEL}x (${ZOOM_LEVEL}00%)"
    echo "🎯 L'icône devrait maintenant être BEAUCOUP plus grande et visible !"
    echo "🎯 Pour voir les changements, redémarrez l'application"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Génération d'icône TRÈS grande terminée !"
