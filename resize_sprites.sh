#!/bin/bash

# 🎨 Script de Redimensionnement des Sprites - Galactic Vengeance
# Ce script redimensionne les sprites pour les rendre plus visibles

echo "🎨 Redimensionnement des Sprites - Galactic Vengeance"
echo "==================================================="
echo ""

# ========================================
# 📏 DIMENSIONS CIBLES
# ========================================

echo "📏 Définition des dimensions cibles..."
echo "====================================="
echo ""

# Créer le dossier de backup
mkdir -p assets/images/sprites/backup_$(date +%Y%m%d_%H%M%S)

# Dimensions cibles pour une meilleure visibilité
declare -A target_sizes=(
    ["player_ship.png"]="64x64"
    ["enemy_basic.png"]="48x48"
    ["asteroid_medium.png"]="48x48"
    ["boss_final.png"]="128x128"
)

echo "🎯 Dimensions cibles définies :"
for sprite in "${!target_sizes[@]}"; do
    echo "  📄 $sprite → ${target_sizes[$sprite]}"
done
echo ""

# ========================================
# 🔄 REDIMENSIONNEMENT
# ========================================

echo "🔄 Redimensionnement des sprites..."
echo "=================================="
echo ""

sprites_dir="assets/images/sprites"

for sprite in "${!target_sizes[@]}"; do
    filepath="$sprites_dir/$sprite"
    target_size="${target_sizes[$sprite]}"
    
    if [ -f "$filepath" ]; then
        echo "  🔄 Redimensionnement de $sprite..."
        
        # Backup original
        cp "$filepath" "assets/images/sprites/backup_$(date +%Y%m%d_%H%M%S)/$sprite"
        
        # Redimensionner avec ImageMagick
        magick "$filepath" -resize "$target_size" -strip -quality 90 "$filepath"
        
        # Vérifier le résultat
        new_size=$(file "$filepath" | grep -o '[0-9]* x [0-9]*' | head -1)
        new_filesize=$(ls -lh "$filepath" | awk '{print $5}')
        
        echo "    ✅ Redimensionné vers $new_size ($new_filesize)"
    else
        echo "  ❌ $sprite non trouvé"
    fi
    echo ""
done

# ========================================
# 🎨 CRÉATION DE SPRITES ALTERNATIFS
# ========================================

echo "🎨 Création de sprites alternatifs colorés..."
echo "============================================"
echo ""

# Créer des sprites colorés alternatifs pour test
echo "  🎨 Création de sprites de test colorés..."

# Vaisseau joueur - Vert avec bordure
magick -size 64x64 xc:transparent \
  -fill "#00FF00" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 32,8 8,56 56,56" \
  -strip -quality 90 "$sprites_dir/player_ship_test.png"

# Ennemi - Rouge avec bordure
magick -size 48x48 xc:transparent \
  -fill "#FF0000" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 24,8 8,40 40,40" \
  -strip -quality 90 "$sprites_dir/enemy_basic_test.png"

# Astéroïde - Marron avec bordure
magick -size 48x48 xc:transparent \
  -fill "#8B4513" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "circle 24,24 24,8" \
  -strip -quality 90 "$sprites_dir/asteroid_medium_test.png"

echo "    ✅ Sprites de test créés"
echo ""

# ========================================
# 🔧 MISE À JOUR DU CODE POUR TEST
# ========================================

echo "🔧 Mise à jour du code pour utiliser les sprites de test..."
echo "=========================================================="
echo ""

# Créer des versions de test des fichiers Dart
echo "  📄 Création de versions de test..."

# Player ship test
cp lib/game/components/player_ship.dart lib/game/components/player_ship_test.dart
sed -i '' 's/player_ship.png/player_ship_test.png/g' lib/game/components/player_ship_test.dart

# Enemy test
cp lib/game/components/enemy.dart lib/game/components/enemy_test.dart
sed -i '' 's/enemy_basic.png/enemy_basic_test.png/g' lib/game/components/enemy_test.dart

# Asteroid test
cp lib/game/components/asteroid.dart lib/game/components/asteroid_test.dart
sed -i '' 's/asteroid_medium.png/asteroid_medium_test.png/g' lib/game/components/asteroid_test.dart

echo "    ✅ Versions de test créées"
echo ""

# ========================================
# 📊 VÉRIFICATION FINALE
# ========================================

echo "📊 Vérification finale des sprites..."
echo "===================================="
echo ""

for sprite in "${!target_sizes[@]}"; do
    filepath="$sprites_dir/$sprite"
    if [ -f "$filepath" ]; then
        size=$(file "$filepath" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$filepath" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    fi
done

echo ""
echo "🎨 Sprites de test créés :"
test_sprites=("player_ship_test.png" "enemy_basic_test.png" "asteroid_medium_test.png")
for sprite in "${test_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "  🎨 $sprite - $size"
    fi
done

echo ""
echo "🎯 Instructions pour tester :"
echo "============================"
echo ""

echo "1. 🔄 Redémarrer Flutter :"
echo "   flutter clean && flutter pub get && flutter run"
echo ""

echo "2. 🎨 Si les sprites originaux ne s'affichent toujours pas :"
echo "   Remplacer temporairement par les sprites de test"
echo ""

echo "3. 📱 Vérifier les logs pour les erreurs de chargement"
echo ""

echo "🎉 Redimensionnement terminé !"
echo "============================="
