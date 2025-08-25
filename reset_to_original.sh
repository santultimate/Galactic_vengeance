#!/bin/bash

# Script pour revenir à l'image originale sans zoom
echo "🔄 Retour à l'image originale pour Galactic Vengeance"

# Vérifier si l'image source existe
if [ ! -f "assets/images/icone.png" ]; then
    echo "❌ Erreur: assets/images/icone.png non trouvé"
    exit 1
fi

# Copier l'image originale
echo "📋 Copie de l'image originale..."
cp assets/images/icone.png assets/images/icon_zoomed.png

if [ $? -eq 0 ]; then
    echo "✅ Image originale copiée"
    
    # Afficher les informations sur l'image
    echo "📊 Informations sur l'image:"
    ls -lh assets/images/icon_zoomed.png
else
    echo "❌ Erreur lors de la copie de l'image"
    exit 1
fi

# Générer les icônes avec l'image originale
echo "🚀 Génération des icônes avec l'image originale..."
flutter pub run flutter_launcher_icons:main

if [ $? -eq 0 ]; then
    echo "✅ Icônes générées avec l'image originale !"
    echo ""
    echo "🎯 Image originale appliquée (sans zoom)"
    echo "🎯 Pour voir les changements:"
    echo "   flutter clean"
    echo "   flutter pub get"
    echo "   flutter run"
else
    echo "❌ Erreur lors de la génération des icônes"
    exit 1
fi

echo "✨ Retour à l'image originale terminé !"
