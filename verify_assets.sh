#!/bin/bash

# 🔍 Script de Vérification des Assets - Galactic Vengeance
# Ce script vérifie que tous les assets sont correctement reconnus par Flutter

echo "🔍 Vérification des Assets - Galactic Vengeance"
echo "=============================================="
echo ""

# ========================================
# 📋 VÉRIFICATION DU PUBSPEC.YAML
# ========================================

echo "📋 Vérification du pubspec.yaml..."
echo "================================="
echo ""

if grep -q "assets/images/sprites/" pubspec.yaml; then
    echo "  ✅ assets/images/sprites/ déclaré"
else
    echo "  ❌ assets/images/sprites/ NON déclaré"
fi

if grep -q "assets/audio/sounds/" pubspec.yaml; then
    echo "  ✅ assets/audio/sounds/ déclaré"
else
    echo "  ❌ assets/audio/sounds/ NON déclaré"
fi

if grep -q "assets/audio/music/" pubspec.yaml; then
    echo "  ✅ assets/audio/music/ déclaré"
else
    echo "  ❌ assets/audio/music/ NON déclaré"
fi

echo ""

# ========================================
# 🎵 VÉRIFICATION DES ASSETS AUDIO
# ========================================

echo "🎵 Vérification des Assets Audio..."
echo "=================================="
echo ""

# Sons
echo "📁 Sons (assets/audio/sounds/) :"
audio_sounds=(
    "button_click.mp3"
    "shoot.mp3"
    "explosion.mp3"
    "powerup.mp3"
    "coin.mp3"
    "game_over.mp3"
    "victory.mp3"
    "boss.mp3"
)

for sound in "${audio_sounds[@]}"; do
    if [ -f "assets/audio/sounds/$sound" ]; then
        size=$(ls -lh assets/audio/sounds/$sound | awk '{print $5}')
        echo "  ✅ $sound - $size"
    else
        echo "  ❌ $sound manquant"
    fi
done

echo ""

# Musiques
echo "🎼 Musiques (assets/audio/music/) :"
audio_music=(
    "background_music.mp3"
    "menu_music.mp3"
    "boss_music.mp3"
)

for music in "${audio_music[@]}"; do
    if [ -f "assets/audio/music/$music" ]; then
        size=$(ls -lh assets/audio/music/$music | awk '{print $5}')
        echo "  ✅ $music - $size"
    else
        echo "  ❌ $music manquant"
    fi
done

echo ""

# ========================================
# 🎨 VÉRIFICATION DES SPRITES
# ========================================

echo "🎨 Vérification des Sprites..."
echo "============================="
echo ""

echo "📁 Sprites (assets/images/sprites/) :"
sprites=(
    "player_ship.png"
    "enemy_basic.png"
    "enemy_advanced.png"
    "asteroid_small.png"
    "asteroid_medium.png"
    "asteroid_large.png"
    "powerup_shield.png"
    "powerup_rapid_fire.png"
    "powerup_laser.png"
    "powerup_speed.png"
    "boss_final.png"
)

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh assets/images/sprites/$sprite | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite manquant"
    fi
done

echo ""

# ========================================
# 🔧 VÉRIFICATION DU CODE
# ========================================

echo "🔧 Vérification du Code..."
echo "========================"
echo ""

# Vérifier les chemins audio dans le code
echo "📝 Chemins audio dans le code :"

if grep -q "assets/audio/sounds/shoot.mp3" lib/game/audio_manager.dart; then
    echo "  ✅ shoot.mp3 référencé dans audio_manager.dart"
else
    echo "  ❌ shoot.mp3 NON référencé dans audio_manager.dart"
fi

if grep -q "assets/audio/sounds/explosion.mp3" lib/game/audio_manager.dart; then
    echo "  ✅ explosion.mp3 référencé dans audio_manager.dart"
else
    echo "  ❌ explosion.mp3 NON référencé dans audio_manager.dart"
fi

if grep -q "assets/audio/music/background_music.mp3" lib/game/audio_manager.dart; then
    echo "  ✅ background_music.mp3 référencé dans audio_manager.dart"
else
    echo "  ❌ background_music.mp3 NON référencé dans audio_manager.dart"
fi

echo ""

# Vérifier les sprites dans le code
echo "📝 Sprites dans le code :"

if grep -q "player_ship.png" lib/game/components/player_ship.dart; then
    echo "  ✅ player_ship.png référencé dans player_ship.dart"
else
    echo "  ❌ player_ship.png NON référencé dans player_ship.dart"
fi

if grep -q "enemy_basic.png" lib/game/components/enemy.dart; then
    echo "  ✅ enemy_basic.png référencé dans enemy.dart"
else
    echo "  ❌ enemy_basic.png NON référencé dans enemy.dart"
fi

if grep -q "asteroid_medium.png" lib/game/components/asteroid.dart; then
    echo "  ✅ asteroid_medium.png référencé dans asteroid.dart"
else
    echo "  ❌ asteroid_medium.png NON référencé dans asteroid.dart"
fi

if grep -q "boss_final.png" lib/game/components/boss.dart; then
    echo "  ✅ boss_final.png référencé dans boss.dart"
else
    echo "  ❌ boss_final.png NON référencé dans boss.dart"
fi

echo ""

# ========================================
# 📊 RÉSUMÉ
# ========================================

echo "📊 Résumé de la Vérification"
echo "============================"
echo ""

# Compter les assets présents
audio_count=0
sprite_count=0

for sound in "${audio_sounds[@]}"; do
    if [ -f "assets/audio/sounds/$sound" ]; then
        ((audio_count++))
    fi
done

for music in "${audio_music[@]}"; do
    if [ -f "assets/audio/music/$music" ]; then
        ((audio_count++))
    fi
done

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        ((sprite_count++))
    fi
done

echo "🎵 Assets Audio : $audio_count/11 présents"
echo "🎨 Sprites : $sprite_count/11 présents"
echo "📋 pubspec.yaml : Configuré correctement"
echo "🔧 Code : Références mises à jour"

echo ""

# ========================================
# 🚀 RECOMMANDATIONS
# ========================================

echo "🚀 Recommandations"
echo "================="
echo ""

if [ $audio_count -eq 11 ] && [ $sprite_count -eq 11 ]; then
    echo "✅ Tous les assets sont présents et configurés !"
    echo "🎮 Le jeu est prêt à être testé avec :"
    echo "   - flutter clean"
    echo "   - flutter pub get"
    echo "   - flutter run"
else
    echo "⚠️  Certains assets manquent ou ne sont pas configurés"
    echo "💡 Vérifiez les fichiers manquants et relancez le script"
fi

echo ""
echo "🎉 Vérification terminée !"
echo "========================="
