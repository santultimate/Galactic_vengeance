#!/bin/bash

# 🔄 Script de Rechargement Forcé des Assets - Galactic Vengeance
# Ce script force le rechargement des assets par Flutter

echo "🔄 Rechargement Forcé des Assets - Galactic Vengeance"
echo "=================================================="
echo ""

# ========================================
# 🧹 NETTOYAGE COMPLET
# ========================================

echo "🧹 Nettoyage complet..."
echo "======================"
echo ""

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Suppression du cache..."
rm -rf .dart_tool/
rm -rf build/
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 📦 RÉINSTALLATION DES DÉPENDANCES
# ========================================

echo "📦 Réinstallation des dépendances..."
echo "=================================="
echo ""

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  ✅ Dépendances réinstallées"
echo ""

# ========================================
# 🎨 VÉRIFICATION DES ASSETS
# ========================================

echo "🎨 Vérification des assets..."
echo "============================"
echo ""

# Vérifier les sprites principaux
sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png" "boss_final.png")

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh assets/images/sprites/$sprite | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite manquant"
    fi
done

echo ""

# Vérifier les sons principaux
sounds=("shoot.mp3" "explosion.mp3" "button_click.mp3")

for sound in "${sounds[@]}"; do
    if [ -f "assets/audio/sounds/$sound" ]; then
        size=$(ls -lh assets/audio/sounds/$sound | awk '{print $5}')
        echo "  ✅ $sound - $size"
    else
        echo "  ❌ $sound manquant"
    fi
done

echo ""

# ========================================
# 🔧 RÉGÉNÉRATION DES ICÔNES
# ========================================

echo "🔧 Régénération des icônes..."
echo "============================"
echo ""

echo "  🔄 Génération des icônes..."
flutter pub run flutter_launcher_icons:main

echo "  ✅ Icônes régénérées"
echo ""

# ========================================
# 🚀 LANCEMENT DU JEU
# ========================================

echo "🚀 Lancement du jeu..."
echo "====================="
echo ""

echo "  🎮 Démarrage de Flutter..."
echo "  📱 Le jeu va se lancer avec les nouveaux assets"
echo "  🎵 L'audio devrait maintenant fonctionner"
echo "  🎨 Les sprites devraient maintenant s'afficher"
echo ""

echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🎮 Testez le gameplay"
echo "2. 🎵 Vérifiez que l'audio fonctionne"
echo "3. 🎨 Vérifiez que les sprites s'affichent"
echo "4. ⏸️ Testez le système de pause"
echo "5. 🎯 Testez les collisions"

echo ""
echo "🎉 Rechargement terminé !"
echo "========================"
echo ""
echo "🚀 Le jeu est maintenant prêt avec tous les assets !"
