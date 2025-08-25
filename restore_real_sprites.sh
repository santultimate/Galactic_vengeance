#!/bin/bash

# 🎨 Script de Restauration des Vrais Sprites - Galactic Vengeance
# Ce script restaure les vrais sprites PNG au lieu des sprites de test

echo "🎨 Restauration des Vrais Sprites - Galactic Vengeance"
echo "====================================================="
echo ""

# ========================================
# 🔄 RESTAURATION DES RÉFÉRENCES
# ========================================

echo "🔄 Restauration des références dans le code..."
echo "============================================="
echo ""

# Restaurer player_ship.dart
echo "  📄 Restauration de player_ship.dart..."
sed -i '' 's/player_ship_test.png/player_ship.png/g' lib/game/components/player_ship.dart
echo "    ✅ player_ship.png restauré"

# Restaurer enemy.dart
echo "  📄 Restauration de enemy.dart..."
sed -i '' 's/enemy_basic_test.png/enemy_basic.png/g' lib/game/components/enemy.dart
echo "    ✅ enemy_basic.png restauré"

# Restaurer asteroid.dart
echo "  📄 Restauration de asteroid.dart..."
sed -i '' 's/asteroid_medium_test.png/asteroid_medium.png/g' lib/game/components/asteroid.dart
echo "    ✅ asteroid_medium.png restauré"

echo ""

# ========================================
# 📏 REDIMENSIONNEMENT DES VRAIS SPRITES
# ========================================

echo "📏 Redimensionnement des vrais sprites..."
echo "========================================"
echo ""

sprites_dir="assets/images/sprites"

# Redimensionner les vrais sprites pour une meilleure visibilité
echo "  🔄 Redimensionnement de player_ship.png..."
if [ -f "$sprites_dir/player_ship.png" ]; then
    magick "$sprites_dir/player_ship.png" -resize 64x64 -strip -quality 90 "$sprites_dir/player_ship.png"
    size=$(file "$sprites_dir/player_ship.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ player_ship.png non trouvé"
fi

echo "  🔄 Redimensionnement de enemy_basic.png..."
if [ -f "$sprites_dir/enemy_basic.png" ]; then
    magick "$sprites_dir/enemy_basic.png" -resize 48x48 -strip -quality 90 "$sprites_dir/enemy_basic.png"
    size=$(file "$sprites_dir/enemy_basic.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ enemy_basic.png non trouvé"
fi

echo "  🔄 Redimensionnement de asteroid_medium.png..."
if [ -f "$sprites_dir/asteroid_medium.png" ]; then
    magick "$sprites_dir/asteroid_medium.png" -resize 48x48 -strip -quality 90 "$sprites_dir/asteroid_medium.png"
    size=$(file "$sprites_dir/asteroid_medium.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ asteroid_medium.png non trouvé"
fi

echo ""

# ========================================
# 🧹 NETTOYAGE ET RECHARGEMENT
# ========================================

echo "🧹 Nettoyage et rechargement..."
echo "==============================="
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

echo "📊 Vérification finale des sprites..."
echo "===================================="
echo ""

real_sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png")

for sprite in "${real_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite manquant"
    fi
done

echo ""
echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🚀 Lancer le jeu :"
echo "   flutter run"
echo ""

echo "2. 🎨 Vérifier que les vrais sprites s'affichent :"
echo "   - Vaisseau avec le sprite original"
echo "   - Ennemis avec le sprite original"
echo "   - Astéroïdes avec le sprite original"
echo ""

echo "3. 🔄 Si les sprites ne s'affichent pas :"
echo "   - Vérifier les logs pour les erreurs"
echo "   - Revenir aux sprites de test si nécessaire"
echo ""

echo "🎉 Restauration terminée !"
echo "========================="
echo ""

echo "🚀 Les vrais sprites PNG sont maintenant restaurés !"
