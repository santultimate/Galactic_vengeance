#!/bin/bash

# ⚡ Correction Rapide des Sprites - Galactic Vengeance
# Ce script utilise les sprites qui fonctionnent déjà

echo "⚡ Correction Rapide des Sprites - Galactic Vengeance"
echo "=================================================="
echo ""

# ========================================
# 🔄 UTILISER LES SPRITES QUI FONCTIONNENT
# ========================================

echo "🔄 Utilisation des sprites qui fonctionnent..."
echo "============================================="
echo ""

# Utiliser player_ship.png (qui fonctionnait avant)
echo "  📄 Restauration de player_ship.png..."
sed -i '' 's/player_ship_test.png/player_ship.png/g' lib/game/components/player_ship.dart
echo "    ✅ player_ship.png restauré"

# Utiliser enemy_basic.png (qui fonctionnait avant)
echo "  📄 Restauration de enemy_basic.png..."
sed -i '' 's/enemy_basic_test.png/enemy_basic.png/g' lib/game/components/enemy.dart
echo "    ✅ enemy_basic.png restauré"

# Utiliser asteroid_medium.png (qui fonctionnait avant)
echo "  📄 Restauration de asteroid_medium.png..."
sed -i '' 's/asteroid_medium_test.png/asteroid_medium.png/g' lib/game/components/asteroid.dart
echo "    ✅ asteroid_medium.png restauré"

echo ""

# ========================================
# 🎨 CRÉER DES SPRITES SIMPLES QUI FONCTIONNENT
# ========================================

echo "🎨 Création de sprites simples qui fonctionnent..."
echo "================================================="
echo ""

# Créer un sprite simple pour le vaisseau
echo "  🎨 Création de player_ship_simple.png..."
magick -size 64x64 xc:transparent \
  -fill "#00FF00" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 32,8 8,56 56,56" \
  -fill "#FF6600" -draw "polygon 32,48 24,56 40,56" \
  -strip -quality 95 "assets/images/sprites/player_ship_simple.png"
echo "    ✅ Vaisseau simple créé"

# Créer un sprite simple pour les ennemis
echo "  🎨 Création de enemy_basic_simple.png..."
magick -size 48x48 xc:transparent \
  -fill "#FF0000" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 24,40 8,8 40,8" \
  -fill "#FF6666" -draw "circle 24,16 24,8" \
  -strip -quality 95 "assets/images/sprites/enemy_basic_simple.png"
echo "    ✅ Ennemi simple créé"

# Créer un sprite simple pour les astéroïdes
echo "  🎨 Création de asteroid_medium_simple.png..."
magick -size 48x48 xc:transparent \
  -fill "#8B4513" -stroke "#FFFFFF" -strokewidth 2 \
  -draw "polygon 24,8 8,24 16,40 32,44 40,32 32,16" \
  -fill "#A0522D" -draw "circle 24,24 16,8" \
  -strip -quality 95 "assets/images/sprites/asteroid_medium_simple.png"
echo "    ✅ Astéroïde simple créé"

echo ""

# ========================================
# 🔧 MISE À JOUR DU CODE POUR LES SPRITES SIMPLES
# ========================================

echo "🔧 Mise à jour du code pour les sprites simples..."
echo "================================================="
echo ""

# Utiliser les sprites simples
echo "  📄 Mise à jour pour utiliser les sprites simples..."
sed -i '' 's/player_ship.png/player_ship_simple.png/g' lib/game/components/player_ship.dart
sed -i '' 's/enemy_basic.png/enemy_basic_simple.png/g' lib/game/components/enemy.dart
sed -i '' 's/asteroid_medium.png/asteroid_medium_simple.png/g' lib/game/components/asteroid.dart

echo "    ✅ Sprites simples configurés"
echo ""

# ========================================
# 🧹 NETTOYAGE RAPIDE
# ========================================

echo "🧹 Nettoyage rapide..."
echo "====================="
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

echo "🎨 Sprites simples créés :"
simple_sprites=("player_ship_simple.png" "enemy_basic_simple.png" "asteroid_medium_simple.png")

for sprite in "${simple_sprites[@]}"; do
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
echo "   - Vaisseau joueur : Triangle vert avec flamme orange"
echo "   - Ennemis : Triangles rouges avec cercles roses"
echo "   - Astéroïdes : Formes marron polygonales avec cercles"
echo ""

echo "3. 🎵 Vérifier l'audio :"
echo "   - Musique de fond au démarrage"
echo "   - Sons de tir lors du tir"
echo "   - Sons d'explosion lors des collisions"
echo ""

echo "⚡ Correction rapide terminée !"
echo "============================="
echo ""
echo "🚀 Les sprites simples devraient maintenant s'afficher !"
