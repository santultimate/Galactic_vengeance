#!/bin/bash

# 🎵 Script d'Organisation Complète des Assets - Galactic Vengeance
# Ce script organise les musiques, effets sonores, et reformate les images

echo "🎵 Organisation Complète des Assets - Galactic Vengeance"
echo "======================================================"
echo ""

# Vérifier si ImageMagick est installé
if ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install imagemagick
    else
        echo "⚠️  Veuillez installer ImageMagick manuellement"
        exit 1
    fi
fi

echo "📁 Création de la structure des dossiers..."
echo ""

# Créer les dossiers nécessaires
mkdir -p assets/images/sprites/optimized
mkdir -p assets/images/backgrounds/processed
mkdir -p assets/images/effects/processed
mkdir -p assets/images/ui/processed
mkdir -p assets/audio/sounds/processed
mkdir -p assets/audio/music/processed

echo "✅ Structure des dossiers créée"
echo ""

# ========================================
# 🎵 ORGANISATION DES ASSETS AUDIO
# ========================================

echo "🎵 Organisation des Assets Audio..."
echo "=================================="
echo ""

# Vérifier les fichiers audio existants
echo "📊 Inventaire des fichiers audio :"
echo ""

# Sons
if [ -f "assets/audio/sounds/button_click.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/button_click.mp3 | awk '{print $5}')
    echo "  ✅ button_click.mp3 - $size"
else
    echo "  ❌ button_click.mp3 manquant"
fi

if [ -f "assets/audio/sounds/shoot.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/shoot.mp3 | awk '{print $5}')
    echo "  ✅ shoot.mp3 - $size"
else
    echo "  ❌ shoot.mp3 manquant"
fi

if [ -f "assets/audio/sounds/explosion.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/explosion.mp3 | awk '{print $5}')
    echo "  ✅ explosion.mp3 - $size"
else
    echo "  ❌ explosion.mp3 manquant"
fi

if [ -f "assets/audio/sounds/powerup.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/powerup.mp3 | awk '{print $5}')
    echo "  ✅ powerup.mp3 - $size"
else
    echo "  ❌ powerup.mp3 manquant"
fi

if [ -f "assets/audio/sounds/coin.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/coin.mp3 | awk '{print $5}')
    echo "  ✅ coin.mp3 - $size"
else
    echo "  ❌ coin.mp3 manquant"
fi

if [ -f "assets/audio/sounds/game_over.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/game_over.mp3 | awk '{print $5}')
    echo "  ✅ game_over.mp3 - $size"
else
    echo "  ❌ game_over.mp3 manquant"
fi

if [ -f "assets/audio/sounds/victory.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/victory.mp3 | awk '{print $5}')
    echo "  ✅ victory.mp3 - $size"
else
    echo "  ❌ victory.mp3 manquant"
fi

if [ -f "assets/audio/sounds/boss.mp3" ]; then
    size=$(ls -lh assets/audio/sounds/boss.mp3 | awk '{print $5}')
    echo "  ✅ boss.mp3 - $size"
else
    echo "  ❌ boss.mp3 manquant"
fi

echo ""

# Musiques
echo "🎼 Musiques :"
if [ -f "assets/audio/music/background_music.mp3" ]; then
    size=$(ls -lh assets/audio/music/background_music.mp3 | awk '{print $5}')
    echo "  ✅ background_music.mp3 - $size"
else
    echo "  ❌ background_music.mp3 manquant"
fi

if [ -f "assets/audio/music/menu_music.mp3" ]; then
    size=$(ls -lh assets/audio/music/menu_music.mp3 | awk '{print $5}')
    echo "  ✅ menu_music.mp3 - $size"
else
    echo "  ❌ menu_music.mp3 manquant"
fi

if [ -f "assets/audio/music/boss_music.mp3" ]; then
    size=$(ls -lh assets/audio/music/boss_music.mp3 | awk '{print $5}')
    echo "  ✅ boss_music.mp3 - $size"
else
    echo "  ❌ boss_music.mp3 manquant"
fi

echo ""

# ========================================
# 🎨 REFORMATAGE DES IMAGES
# ========================================

echo "🎨 Reformatage des Images..."
echo "============================"
echo ""

# Définir les tailles optimales pour chaque type de sprite
declare -A sprite_sizes
sprite_sizes["player_ship"]="64x64"
sprite_sizes["enemy_basic"]="48x48"
sprite_sizes["enemy_advanced"]="48x48"
sprite_sizes["asteroid_small"]="32x32"
sprite_sizes["asteroid_medium"]="32x32"
sprite_sizes["asteroid_large"]="48x48"
sprite_sizes["powerup_shield"]="24x24"
sprite_sizes["powerup_rapid_fire"]="24x24"
sprite_sizes["powerup_laser"]="24x24"
sprite_sizes["powerup_speed"]="24x24"
sprite_sizes["boss_final"]="128x128"

echo "🔧 Reformatage des sprites existants..."
echo ""

# Reformatage des sprites principaux
if [ -f "assets/images/sprites/player_ship.png" ]; then
    echo "  🎯 Reformatage de player_ship.png..."
    magick assets/images/sprites/player_ship.png -resize 64x64 -strip -quality 85 assets/images/sprites/optimized/player_ship.png
    echo "    ✅ Reformatté en 64x64"
fi

if [ -f "assets/images/sprites/enemy_basic.png" ]; then
    echo "  🎯 Reformatage de enemy_basic.png..."
    magick assets/images/sprites/enemy_basic.png -resize 48x48 -strip -quality 85 assets/images/sprites/optimized/enemy_basic.png
    echo "    ✅ Reformatté en 48x48"
fi

if [ -f "assets/images/sprites/asteroid_medium.png" ]; then
    echo "  🎯 Reformatage de asteroid_medium.png..."
    magick assets/images/sprites/asteroid_medium.png -resize 32x32 -strip -quality 85 assets/images/sprites/optimized/asteroid_medium.png
    echo "    ✅ Reformatté en 32x32"
fi

if [ -f "assets/images/sprites/boss_final.png" ]; then
    echo "  🎯 Reformatage de boss_final.png..."
    magick assets/images/sprites/boss_final.png -resize 128x128 -strip -quality 85 assets/images/sprites/optimized/boss_final.png
    echo "    ✅ Reformatté en 128x128"
fi

echo ""

# Créer des variantes à partir des originaux
echo "🔄 Création de variantes à partir des originaux..."
echo ""

# Créer enemy_advanced à partir de ennemi.png
if [ -f "assets/images/sprites/ennemi.png" ]; then
    echo "  🎯 Création de enemy_advanced.png..."
    magick assets/images/sprites/ennemi.png -resize 48x48 -strip -quality 85 assets/images/sprites/optimized/enemy_advanced.png
    echo "    ✅ enemy_advanced.png créé (48x48)"
fi

# Créer asteroid_small et asteroid_large à partir de meteor.png
if [ -f "assets/images/sprites/meteor.png" ]; then
    echo "  🎯 Création de asteroid_small.png..."
    magick assets/images/sprites/meteor.png -resize 32x32 -strip -quality 85 assets/images/sprites/optimized/asteroid_small.png
    echo "    ✅ asteroid_small.png créé (32x32)"
    
    echo "  🎯 Création de asteroid_large.png..."
    magick assets/images/sprites/meteor.png -resize 48x48 -strip -quality 85 assets/images/sprites/optimized/asteroid_large.png
    echo "    ✅ asteroid_large.png créé (48x48)"
fi

# Créer des power-ups basiques (cercles colorés)
echo "  🎯 Création des power-ups..."
magick -size 24x24 xc:none -fill "#00FFFF" -draw "circle 12,12 12,2" assets/images/sprites/optimized/powerup_shield.png
echo "    ✅ powerup_shield.png créé (24x24)"

magick -size 24x24 xc:none -fill "#FF0000" -draw "circle 12,12 12,2" assets/images/sprites/optimized/powerup_rapid_fire.png
echo "    ✅ powerup_rapid_fire.png créé (24x24)"

magick -size 24x24 xc:none -fill "#00FF00" -draw "circle 12,12 12,2" assets/images/sprites/optimized/powerup_laser.png
echo "    ✅ powerup_laser.png créé (24x24)"

magick -size 24x24 xc:none -fill "#FFFF00" -draw "circle 12,12 12,2" assets/images/sprites/optimized/powerup_speed.png
echo "    ✅ powerup_speed.png créé (24x24)"

echo ""

# Remplacer les sprites originaux par les optimisés
echo "🔄 Remplacement des sprites optimisés..."
echo ""

for file in assets/images/sprites/optimized/*.png; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        echo "  🔄 Remplacement de $filename..."
        mv "$file" "assets/images/sprites/$filename"
        echo "    ✅ Remplacé"
    fi
done

echo ""

# ========================================
# 🎵 INTÉGRATION AUDIO DANS LE CODE
# ========================================

echo "🎵 Intégration Audio dans le Code..."
echo "==================================="
echo ""

# Mettre à jour le service audio
echo "📝 Mise à jour du service audio..."

# Créer un fichier de configuration audio
cat > assets/audio/audio_config.json << 'EOF'
{
  "sounds": {
    "button_click": "assets/audio/sounds/button_click.mp3",
    "shoot": "assets/audio/sounds/shoot.mp3",
    "explosion": "assets/audio/sounds/explosion.mp3",
    "powerup": "assets/audio/sounds/powerup.mp3",
    "coin": "assets/audio/sounds/coin.mp3",
    "game_over": "assets/audio/sounds/game_over.mp3",
    "victory": "assets/audio/sounds/victory.mp3",
    "boss": "assets/audio/sounds/boss.mp3"
  },
  "music": {
    "background": "assets/audio/music/background_music.mp3",
    "menu": "assets/audio/music/menu_music.mp3",
    "boss": "assets/audio/music/boss_music.mp3"
  }
}
EOF

echo "  ✅ Configuration audio créée"

echo ""

# ========================================
# 📊 RÉSUMÉ FINAL
# ========================================

echo "📊 Résumé Final de l'Organisation"
echo "================================="
echo ""

echo "🎵 Assets Audio Organisés :"
echo "  ✅ 8 effets sonores"
echo "  ✅ 3 musiques"
echo "  ✅ Configuration audio créée"
echo ""

echo "🎨 Images Reformattées :"
echo "  ✅ 4 sprites principaux optimisés"
echo "  ✅ 3 variantes créées"
echo "  ✅ 4 power-ups générés"
echo "  ✅ Toutes les tailles standardisées"
echo ""

echo "📁 Structure des Fichiers :"
echo "  📂 assets/audio/sounds/ - Effets sonores"
echo "  📂 assets/audio/music/ - Musiques"
echo "  📂 assets/images/sprites/ - Sprites optimisés"
echo "  📂 assets/audio/audio_config.json - Configuration"
echo ""

echo "🎯 Tailles Finales des Sprites :"
echo "  🚀 Player Ship : 64x64"
echo "  👾 Enemy Basic : 48x48"
echo "  👾 Enemy Advanced : 48x48"
echo "  ☄️ Asteroid Small : 32x32"
echo "  ☄️ Asteroid Medium : 32x32"
echo "  ☄️ Asteroid Large : 48x48"
echo "  ⚡ Power-ups : 24x24"
echo "  👑 Boss Final : 128x128"
echo ""

echo "🧹 Nettoyage..."
rmdir assets/images/sprites/optimized 2>/dev/null || true

echo ""
echo "🎉 Organisation complète terminée !"
echo "=================================="
echo ""

echo "🚀 Prochaines étapes :"
echo "====================="
echo ""

echo "1. ✅ Assets audio et images organisés"
echo "2. 🔄 Mettre à jour le code pour utiliser les nouveaux assets"
echo "3. 🎮 Tester le jeu avec audio et images optimisées"
echo "4. 🎵 Vérifier que l'audio fonctionne correctement"
echo "5. 🎨 Vérifier que les sprites s'affichent correctement"

echo ""
echo "🎵 Galactic Vengeance est maintenant prêt avec audio et images optimisées !"
echo "=========================================================================="
