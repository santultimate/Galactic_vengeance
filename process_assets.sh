#!/bin/bash

# 🎨 Script de Traitement des Assets - Galactic Vengeance
# Ce script traite et organise les assets ajoutés

echo "🎨 Traitement des Assets - Galactic Vengeance"
echo "============================================="
echo ""

# Vérifier si ImageMagick est installé
if ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install imagemagick
    else
        echo "⚠️  Veuillez installer ImageMagick manuellement"
        echo "   Ubuntu/Debian: sudo apt-get install imagemagick"
        echo "   CentOS/RHEL: sudo yum install ImageMagick"
    fi
fi

echo "📁 Organisation des sprites existants..."
echo ""

# Créer les dossiers de backup
mkdir -p assets/images/sprites/backup
mkdir -p assets/images/sprites/processed

# Sauvegarder les originaux
echo "💾 Sauvegarde des originaux..."
cp assets/images/sprites/*.png assets/images/sprites/backup/ 2>/dev/null || true

# Traiter chaque sprite
echo "🔧 Traitement des sprites..."

# Vaisseau joueur (64x64)
if [ -f "assets/images/sprites/vaisseau.png" ]; then
    echo "  🚀 Traitement du vaisseau joueur..."
    magick assets/images/sprites/vaisseau.png -resize 64x64 assets/images/sprites/player_ship.png
    echo "    ✅ player_ship.png créé (64x64)"
fi

# Ennemi (48x48)
if [ -f "assets/images/sprites/ennemi.png" ]; then
    echo "  👾 Traitement de l'ennemi..."
    magick assets/images/sprites/ennemi.png -resize 48x48 assets/images/sprites/enemy_basic.png
    echo "    ✅ enemy_basic.png créé (48x48)"
fi

# Astéroïde (32x32)
if [ -f "assets/images/sprites/meteor.png" ]; then
    echo "  ☄️ Traitement de l'astéroïde..."
    magick assets/images/sprites/meteor.png -resize 32x32 assets/images/sprites/asteroid_medium.png
    echo "    ✅ asteroid_medium.png créé (32x32)"
fi

# Boss final (128x128)
if [ -f "assets/images/sprites/Final_boss1.png" ]; then
    echo "  👑 Traitement du boss final..."
    magick assets/images/sprites/Final_boss1.png -resize 128x128 assets/images/sprites/boss_final.png
    echo "    ✅ boss_final.png créé (128x128)"
fi

echo ""
echo "📊 Résumé des assets traités :"
echo "=============================="
echo ""

# Lister les fichiers traités
echo "✅ Sprites traités :"
ls -la assets/images/sprites/*.png 2>/dev/null | grep -E "(player_ship|enemy_basic|asteroid_medium|boss_final)" || echo "  Aucun sprite traité trouvé"

echo ""
echo "📋 Prochaines étapes :"
echo "====================="
echo ""

echo "1. ✅ Assets traités et redimensionnés"
echo "2. ⏳ Ajouter dans pubspec.yaml"
echo "3. ⏳ Intégrer dans le code du jeu"
echo "4. ⏳ Tester dans le jeu"
echo "5. ⏳ Générer les assets manquants"

echo ""
echo "🎯 Assets manquants à générer :"
echo "=============================="
echo ""

echo "🚀 Sprites :"
echo "  □ enemy_advanced.png (48x48)"
echo "  □ asteroid_small.png (32x32)"
echo "  □ asteroid_large.png (48x48)"
echo "  □ powerup_shield.png (24x24)"
echo "  □ powerup_rapid_fire.png (24x24)"
echo "  □ powerup_laser.png (24x24)"
echo "  □ powerup_speed.png (24x24)"

echo ""
echo "🌌 Backgrounds :"
echo "  □ space_bg_1.png (1024x1024)"
echo "  □ space_bg_2.png (1024x1024)"
echo "  □ space_bg_3.png (1024x1024)"

echo ""
echo "💥 Effets :"
echo "  □ explosion.png (256x256)"
echo "  □ particles.png (256x256)"
echo "  □ laser_beam.png (256x256)"

echo ""
echo "🎮 UI :"
echo "  □ button_play.png (256x128)"
echo "  □ button_pause.png (256x128)"
echo "  □ button_settings.png (256x128)"

echo ""
echo "🎉 Traitement terminé !"
echo "======================"
echo ""
echo "💡 Prochaines actions :"
echo "- Vérifier la qualité des sprites redimensionnés"
echo "- Ajouter les assets dans pubspec.yaml"
echo "- Intégrer dans le code du jeu"
echo "- Tester le gameplay"
echo ""
echo "🚀 Prêt pour l'intégration !"
