#!/bin/bash

# 🔍 Script de Diagnostic des Sprites - Galactic Vengeance
# Ce script diagnostique pourquoi les sprites ne se chargent pas

echo "🔍 Diagnostic des Sprites - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 📁 VÉRIFICATION DES FICHIERS
# ========================================

echo "📁 Vérification des fichiers sprites..."
echo "======================================"
echo ""

sprites_dir="assets/images/sprites"
required_sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png" "boss_final.png")

for sprite in "${required_sprites[@]}"; do
    filepath="$sprites_dir/$sprite"
    if [ -f "$filepath" ]; then
        size=$(file "$filepath" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$filepath" | awk '{print $5}')
        permissions=$(ls -l "$filepath" | awk '{print $1}')
        echo "  ✅ $sprite"
        echo "     📏 Taille: $size"
        echo "     💾 Poids: $filesize"
        echo "     🔐 Permissions: $permissions"
    else
        echo "  ❌ $sprite - FICHIER MANQUANT"
    fi
    echo ""
done

# ========================================
# 🔧 VÉRIFICATION DU PUBSPEC.YAML
# ========================================

echo "🔧 Vérification du pubspec.yaml..."
echo "================================="
echo ""

if grep -q "assets/images/sprites/" pubspec.yaml; then
    echo "  ✅ assets/images/sprites/ déclaré dans pubspec.yaml"
else
    echo "  ❌ assets/images/sprites/ NON déclaré dans pubspec.yaml"
fi

if grep -q "assets/images/" pubspec.yaml; then
    echo "  ✅ assets/images/ déclaré dans pubspec.yaml"
else
    echo "  ❌ assets/images/ NON déclaré dans pubspec.yaml"
fi

echo ""

# ========================================
# 🎯 VÉRIFICATION DES RÉFÉRENCES CODE
# ========================================

echo "🎯 Vérification des références dans le code..."
echo "============================================="
echo ""

# Vérifier les références dans les fichiers Dart
echo "  📄 Références dans player_ship.dart:"
if grep -q "player_ship.png" lib/game/components/player_ship.dart; then
    echo "    ✅ player_ship.png référencé"
else
    echo "    ❌ player_ship.png NON référencé"
fi

echo "  📄 Références dans enemy.dart:"
if grep -q "enemy_basic.png" lib/game/components/enemy.dart; then
    echo "    ✅ enemy_basic.png référencé"
else
    echo "    ❌ enemy_basic.png NON référencé"
fi

echo "  📄 Références dans asteroid.dart:"
if grep -q "asteroid_medium.png" lib/game/components/asteroid.dart; then
    echo "    ✅ asteroid_medium.png référencé"
else
    echo "    ❌ asteroid_medium.png NON référencé"
fi

echo ""

# ========================================
# 🔄 TEST DE CHARGEMENT FLUTTER
# ========================================

echo "🔄 Test de chargement Flutter..."
echo "==============================="
echo ""

echo "  🔄 Nettoyage et rechargement..."
flutter clean > /dev/null 2>&1
flutter pub get > /dev/null 2>&1

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 📊 ANALYSE DES MÉTADONNÉES
# ========================================

echo "📊 Analyse des métadonnées des images..."
echo "======================================="
echo ""

for sprite in "${required_sprites[@]}"; do
    filepath="$sprites_dir/$sprite"
    if [ -f "$filepath" ]; then
        echo "  📄 $sprite:"
        
        # Vérifier le format
        format=$(file "$filepath" | grep -o 'PNG\|JPEG\|GIF' | head -1)
        echo "    🖼️ Format: $format"
        
        # Vérifier les dimensions
        dimensions=$(file "$filepath" | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "    📏 Dimensions: $dimensions"
        
        # Vérifier si l'image est corrompue
        if file "$filepath" | grep -q "PNG image data"; then
            echo "    ✅ Image PNG valide"
        else
            echo "    ❌ Image PNG invalide ou corrompue"
        fi
        
        echo ""
    fi
done

# ========================================
# 🎯 SOLUTIONS RECOMMANDÉES
# ========================================

echo "🎯 Solutions recommandées..."
echo "============================"
echo ""

echo "1. 🔄 Redémarrer complètement Flutter:"
echo "   flutter clean && flutter pub get && flutter run"
echo ""

echo "2. 📱 Vérifier les logs pendant le lancement:"
echo "   flutter run --verbose"
echo ""

echo "3. 🎨 Vérifier que les images sont bien des PNG valides:"
echo "   file assets/images/sprites/*.png"
echo ""

echo "4. 🔧 Forcer le rechargement des assets:"
echo "   ./force_reload_assets.sh"
echo ""

echo "5. 📋 Vérifier les erreurs dans les logs Dart:"
echo "   Rechercher 'Failed to load' dans les logs"
echo ""

echo "🔍 Diagnostic terminé !"
echo "======================"
