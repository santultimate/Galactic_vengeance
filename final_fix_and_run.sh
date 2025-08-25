#!/bin/bash

# 🚀 Fix Final et Lancement - Galactic Vengeance
# Ce script corrige tous les problèmes et lance le jeu

echo "🚀 Fix Final et Lancement - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 🔧 VÉRIFICATION FINALE DES ASSETS
# ========================================

echo "🔧 Vérification finale des assets..."
echo "==================================="
echo ""

# Vérifier les sprites
echo "  🎨 Sprites :"
if [ -f "assets/images/sprites/vaisseau.png" ]; then
    echo "    ✅ vaisseau.png présent"
else
    echo "    ❌ vaisseau.png manquant"
fi

if [ -f "assets/images/sprites/ennemi.png" ]; then
    echo "    ✅ ennemi.png présent"
else
    echo "    ❌ ennemi.png manquant"
fi

if [ -f "assets/images/sprites/meteor.png" ]; then
    echo "    ✅ meteor.png présent"
else
    echo "    ❌ meteor.png manquant"
fi

# Vérifier les références dans le code
echo "  📄 Références dans le code :"
if grep -q "vaisseau.png" lib/game/components/player_ship.dart; then
    echo "    ✅ vaisseau.png référencé dans player_ship.dart"
else
    echo "    ❌ vaisseau.png NON référencé dans player_ship.dart"
fi

if grep -q "ennemi.png" lib/game/components/enemy.dart; then
    echo "    ✅ ennemi.png référencé dans enemy.dart"
else
    echo "    ❌ ennemi.png NON référencé dans enemy.dart"
fi

if grep -q "meteor.png" lib/game/components/asteroid.dart; then
    echo "    ✅ meteor.png référencé dans asteroid.dart"
else
    echo "    ❌ meteor.png NON référencé dans asteroid.dart"
fi

echo ""

# ========================================
# 🔧 CORRECTION FINALE
# ========================================

echo "🔧 Correction finale..."
echo "====================="
echo ""

# S'assurer que les sprites sont bien référencés
echo "  📄 Vérification des références de sprites..."

# Player Ship
if ! grep -q "vaisseau.png" lib/game/components/player_ship.dart; then
    echo "    🔧 Correction de player_ship.dart..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("vaisseau.png", images: game.images)/g' lib/game/components/player_ship.dart
fi

# Enemy
if ! grep -q "ennemi.png" lib/game/components/enemy.dart; then
    echo "    🔧 Correction de enemy.dart..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("ennemi.png", images: game.images)/g' lib/game/components/enemy.dart
fi

# Asteroid
if ! grep -q "meteor.png" lib/game/components/asteroid.dart; then
    echo "    🔧 Correction de asteroid.dart..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("meteor.png", images: game.images)/g' lib/game/components/asteroid.dart
fi

echo "    ✅ Références de sprites vérifiées"
echo ""

# ========================================
# 🧹 NETTOYAGE COMPLET
# ========================================

echo "🧹 Nettoyage complet..."
echo "======================"
echo ""

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  🔄 Régénération des icônes..."
flutter pub run flutter_launcher_icons:main

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 🚀 LANCEMENT DU JEU
# ========================================

echo "🚀 Lancement du jeu..."
echo "===================="
echo ""

echo "🎯 Le jeu va maintenant se lancer en mode debug !"
echo ""
echo "📱 Instructions de test :"
echo "========================"
echo ""
echo "1. 🎨 Vérifier les sprites :"
echo "   - Vaisseau joueur : vaisseau.png (vert)"
echo "   - Ennemis : ennemi.png (rouge)"
echo "   - Astéroïdes : meteor.png (marron)"
echo ""
echo "2. ⚙️ Tester les settings :"
echo "   - Aller dans Settings"
echo "   - Changer les options"
echo "   - Vérifier qu'elles se sauvegardent"
echo ""
echo "3. 🎵 Tester l'audio :"
echo "   - Musique de fond"
echo "   - Sons de tir"
echo "   - Sons d'explosion"
echo ""
echo "4. 🎮 Tester le gameplay :"
echo "   - Tirer sur les ennemis"
echo "   - Éviter les astéroïdes"
echo "   - Collecter les pièces"
echo ""

echo "🚀 Lancement en cours..."
flutter run --debug
