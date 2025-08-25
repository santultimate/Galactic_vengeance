#!/bin/bash

# 🎨 Utilisation des Sprites PNG Originaux - Galactic Vengeance
# Ce script utilise les vrais sprites PNG au lieu des sprites simples

echo "🎨 Utilisation des Sprites PNG Originaux - Galactic Vengeance"
echo "==========================================================="
echo ""

# ========================================
# 📊 VÉRIFICATION DES SPRITES ORIGINAUX
# ========================================

echo "📊 Vérification des sprites originaux..."
echo "======================================="
echo ""

sprites_dir="assets/images/sprites"

# Vérifier les sprites originaux
echo "🎨 Sprites originaux disponibles :"
original_sprites=("vaisseau.png" "ennemi.png" "meteor.png")

for sprite in "${original_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""

# ========================================
# 📏 REDIMENSIONNEMENT DES SPRITES ORIGINAUX
# ========================================

echo "📏 Redimensionnement des sprites originaux..."
echo "============================================"
echo ""

# Redimensionner vaisseau.png pour le vaisseau joueur
echo "  🔄 Redimensionnement de vaisseau.png..."
if [ -f "$sprites_dir/vaisseau.png" ]; then
    magick "$sprites_dir/vaisseau.png" -resize 64x64 -strip -quality 95 "$sprites_dir/vaisseau.png"
    size=$(file "$sprites_dir/vaisseau.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ vaisseau.png non trouvé"
fi

# Redimensionner ennemi.png pour les ennemis
echo "  🔄 Redimensionnement de ennemi.png..."
if [ -f "$sprites_dir/ennemi.png" ]; then
    magick "$sprites_dir/ennemi.png" -resize 48x48 -strip -quality 95 "$sprites_dir/ennemi.png"
    size=$(file "$sprites_dir/ennemi.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ ennemi.png non trouvé"
fi

# Redimensionner meteor.png pour les astéroïdes
echo "  🔄 Redimensionnement de meteor.png..."
if [ -f "$sprites_dir/meteor.png" ]; then
    magick "$sprites_dir/meteor.png" -resize 48x48 -strip -quality 95 "$sprites_dir/meteor.png"
    size=$(file "$sprites_dir/meteor.png" | grep -o '[0-9]* x [0-9]*' | head -1)
    echo "    ✅ Redimensionné vers $size"
else
    echo "    ❌ meteor.png non trouvé"
fi

echo ""

# ========================================
# 🔧 MISE À JOUR DU CODE
# ========================================

echo "🔧 Mise à jour du code pour utiliser les sprites originaux..."
echo "============================================================"
echo ""

# Mettre à jour player_ship.dart pour utiliser vaisseau.png
echo "  📄 Mise à jour de player_ship.dart..."
sed -i '' 's/player_ship_simple.png/vaisseau.png/g' lib/game/components/player_ship.dart
echo "    ✅ vaisseau.png configuré pour le vaisseau joueur"

# Mettre à jour enemy.dart pour utiliser ennemi.png
echo "  📄 Mise à jour de enemy.dart..."
sed -i '' 's/enemy_basic_simple.png/ennemi.png/g' lib/game/components/enemy.dart
echo "    ✅ ennemi.png configuré pour les ennemis"

# Mettre à jour asteroid.dart pour utiliser meteor.png
echo "  📄 Mise à jour de asteroid.dart..."
sed -i '' 's/asteroid_medium_simple.png/meteor.png/g' lib/game/components/asteroid.dart
echo "    ✅ meteor.png configuré pour les astéroïdes"

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

echo "🎨 Sprites originaux configurés :"
for sprite in "${original_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
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
echo "   - Vaisseau joueur : Sprite vaisseau.png original"
echo "   - Ennemis : Sprite ennemi.png original"
echo "   - Astéroïdes : Sprite meteor.png original"
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

echo "🎉 Utilisation des sprites originaux terminée !"
echo "============================================="
echo ""

echo "🚀 Les vrais sprites PNG sont maintenant utilisés !"
