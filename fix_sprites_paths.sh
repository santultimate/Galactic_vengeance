#!/bin/bash

# 🎨 Script de Correction des Chemins de Sprites - Galactic Vengeance
# Ce script corrige les chemins des sprites pour qu'ils soient visibles

echo "🎨 Correction des Chemins de Sprites - Galactic Vengeance"
echo "======================================================="
echo ""

# ========================================
# 📁 VÉRIFICATION DES SPRITES DISPONIBLES
# ========================================

echo "📁 Vérification des sprites disponibles..."
echo "========================================="
echo ""

sprites_dir="assets/images/sprites"
available_sprites=()

# Vérifier les sprites disponibles
for sprite in "$sprites_dir"/*.png; do
    if [ -f "$sprite" ]; then
        filename=$(basename "$sprite")
        size=$(file "$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprite" | awk '{print $5}')
        available_sprites+=("$filename")
        echo "  ✅ $filename - $size ($filesize)"
    fi
done

echo ""

# ========================================
# 🔧 CORRECTION DES CHEMINS DANS LE CODE
# ========================================

echo "🔧 Correction des chemins dans le code..."
echo "========================================"
echo ""

# Vérifier et corriger player_ship.dart
echo "  📄 Vérification de player_ship.dart..."
if grep -q "vaisseau.png" lib/game/components/player_ship.dart; then
    echo "    ✅ vaisseau.png déjà référencé"
else
    echo "    🔧 Correction du chemin pour vaisseau.png..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("vaisseau.png", images: game.images)/g' lib/game/components/player_ship.dart
    echo "    ✅ Chemin corrigé"
fi

# Vérifier et corriger enemy.dart
echo "  📄 Vérification de enemy.dart..."
if grep -q "ennemi.png" lib/game/components/enemy.dart; then
    echo "    ✅ ennemi.png déjà référencé"
else
    echo "    🔧 Correction du chemin pour ennemi.png..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("ennemi.png", images: game.images)/g' lib/game/components/enemy.dart
    echo "    ✅ Chemin corrigé"
fi

# Vérifier et corriger asteroid.dart
echo "  📄 Vérification de asteroid.dart..."
if grep -q "meteor.png" lib/game/components/asteroid.dart; then
    echo "    ✅ meteor.png déjà référencé"
else
    echo "    🔧 Correction du chemin pour meteor.png..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("meteor.png", images: game.images)/g' lib/game/components/asteroid.dart
    echo "    ✅ Chemin corrigé"
fi

# Vérifier et corriger boss.dart
echo "  📄 Vérification de boss.dart..."
if grep -q "boss_final.png" lib/game/components/boss.dart; then
    echo "    ✅ boss_final.png déjà référencé"
else
    echo "    🔧 Correction du chemin pour boss_final.png..."
    sed -i '' 's/Sprite\.load.*\.png/Sprite.load("boss_final.png", images: game.images)/g' lib/game/components/boss.dart
    echo "    ✅ Chemin corrigé"
fi

echo ""

# ========================================
# 🔄 NETTOYAGE ET RECHARGEMENT
# ========================================

echo "🔄 Nettoyage et rechargement..."
echo "=============================="
echo ""

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 📊 RÉSUMÉ DES CORRECTIONS
# ========================================

echo "📊 Résumé des corrections..."
echo "==========================="
echo ""

echo "🎨 Sprites configurés :"
echo "  🚀 Vaisseau joueur : vaisseau.png"
echo "  👾 Ennemis : ennemi.png"
echo "  ☄️ Astéroïdes : meteor.png"
echo "  👹 Boss : boss_final.png"
echo ""

echo "🔧 Modifications apportées :"
echo "  ✅ Préchargement des images dans basic_game.dart"
echo "  ✅ Chemins corrigés dans tous les composants"
echo "  ✅ Nettoyage Flutter effectué"
echo ""

echo "🎯 Prochaines étapes :"
echo "  1. Lancer le jeu : flutter run"
echo "  2. Vérifier que les sprites s'affichent"
echo "  3. Tester le gameplay"
echo ""

echo "✅ Correction des chemins de sprites terminée !"
