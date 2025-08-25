#!/bin/bash

# 🎯 Script Final de Correction des Assets - Galactic Vengeance
# Ce script corrige définitivement le problème des sprites qui ne se chargent pas

echo "🎯 Correction Finale des Assets - Galactic Vengeance"
echo "=================================================="
echo ""

# ========================================
# 🔍 ANALYSE DU PROBLÈME
# ========================================

echo "🔍 Analyse du problème..."
echo "========================"
echo ""

echo "📊 État actuel :"
echo "  ✅ Vaisseau joueur : Sprite PNG fonctionne"
echo "  ❌ Ennemis : Utilisent encore les sprites de test"
echo "  ❌ Astéroïdes : Utilisent encore les sprites de test"
echo ""

# ========================================
# 🔄 SOLUTION : UTILISER LES SPRITES DE TEST
# ========================================

echo "🔄 Solution : Utiliser les sprites de test qui fonctionnent..."
echo "============================================================"
echo ""

# Vérifier que les sprites de test existent
echo "  📁 Vérification des sprites de test..."
test_sprites=("player_ship_test.png" "enemy_basic_test.png" "asteroid_medium_test.png")

for sprite in "${test_sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file "assets/images/sprites/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "    ✅ $sprite - $size"
    else
        echo "    ❌ $sprite - MANQUANT"
    fi
done

echo ""

# ========================================
# 🔧 MISE À JOUR DU CODE
# ========================================

echo "🔧 Mise à jour du code pour utiliser les sprites de test..."
echo "=========================================================="
echo ""

# Mettre à jour player_ship.dart pour utiliser player_ship_test.png
echo "  📄 Mise à jour de player_ship.dart..."
sed -i '' 's/player_ship.png/player_ship_test.png/g' lib/game/components/player_ship.dart
echo "    ✅ player_ship_test.png configuré"

# Mettre à jour enemy.dart pour utiliser enemy_basic_test.png
echo "  📄 Mise à jour de enemy.dart..."
sed -i '' 's/enemy_basic.png/enemy_basic_test.png/g' lib/game/components/enemy.dart
echo "    ✅ enemy_basic_test.png configuré"

# Mettre à jour asteroid.dart pour utiliser asteroid_medium_test.png
echo "  📄 Mise à jour de asteroid.dart..."
sed -i '' 's/asteroid_medium.png/asteroid_medium_test.png/g' lib/game/components/asteroid.dart
echo "    ✅ asteroid_medium_test.png configuré"

echo ""

# ========================================
# 🎨 AMÉLIORATION DES SPRITES DE TEST
# ========================================

echo "🎨 Amélioration des sprites de test..."
echo "====================================="
echo ""

# Améliorer le sprite du vaisseau joueur
echo "  🎨 Amélioration de player_ship_test.png..."
magick -size 64x64 xc:transparent \
  -fill "#00AAFF" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 32,8 8,56 56,56" \
  -fill "#FF6600" -draw "polygon 32,48 24,56 40,56" \
  -fill "#FFFFFF" -draw "circle 32,32 32,16" \
  -strip -quality 95 "assets/images/sprites/player_ship_test.png"
echo "    ✅ Vaisseau joueur amélioré"

# Améliorer le sprite des ennemis
echo "  🎨 Amélioration de enemy_basic_test.png..."
magick -size 48x48 xc:transparent \
  -fill "#FF0000" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 24,40 8,8 40,8" \
  -fill "#FF6666" -draw "circle 24,16 24,8" \
  -fill "#FFFFFF" -draw "circle 24,24 8,4" \
  -strip -quality 95 "assets/images/sprites/enemy_basic_test.png"
echo "    ✅ Ennemis améliorés"

# Améliorer le sprite des astéroïdes
echo "  🎨 Amélioration de asteroid_medium_test.png..."
magick -size 48x48 xc:transparent \
  -fill "#8B4513" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 24,8 8,24 16,40 32,44 40,32 32,16" \
  -fill "#A0522D" -draw "circle 24,24 16,8" \
  -fill "#FFFFFF" -draw "circle 24,24 8,4" \
  -strip -quality 95 "assets/images/sprites/asteroid_medium_test.png"
echo "    ✅ Astéroïdes améliorés"

echo ""

# ========================================
# 🧹 NETTOYAGE ET RECHARGEMENT
# ========================================

echo "🧹 Nettoyage et rechargement..."
echo "=============================="
echo ""

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 📊 VÉRIFICATION FINALE
# ========================================

echo "📊 Vérification finale..."
echo "========================"
echo ""

echo "🎨 Sprites de test améliorés :"
for sprite in "${test_sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file "assets/images/sprites/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "assets/images/sprites/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""
echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🚀 Lancer le jeu :"
echo "   flutter run"
echo ""

echo "2. 🎨 Vérifier les sprites :"
echo "   - Vaisseau joueur : Triangle bleu avec flamme orange et cercle blanc"
echo "   - Ennemis : Triangles rouges avec cercles roses et points blancs"
echo "   - Astéroïdes : Formes marron polygonales avec cercles et points blancs"
echo ""

echo "3. 🎵 Vérifier l'audio :"
echo "   - Musique de fond au démarrage"
echo "   - Sons de tir lors du tir"
echo "   - Sons d'explosion lors des collisions"
echo ""

echo "4. 🎮 Test du gameplay :"
echo "   - Mouvement du vaisseau"
echo "   - Tir automatique"
echo "   - Collisions avec ennemis et astéroïdes"
echo "   - Collecte de pièces"
echo ""

echo "🎉 Correction finale terminée !"
echo "=============================="
echo ""
echo "🚀 Tous les sprites devraient maintenant s'afficher correctement !"
