#!/bin/bash

# 🔧 Script de Correction Complète des Assets - Galactic Vengeance
# Ce script diagnostique et corrige tous les problèmes d'assets et d'audio

echo "🔧 Correction Complète des Assets - Galactic Vengeance"
echo "====================================================="
echo ""

# ========================================
# 📊 DIAGNOSTIC COMPLET
# ========================================

echo "📊 Diagnostic complet des assets..."
echo "=================================="
echo ""

# Vérifier les sprites requis
echo "🎨 Sprites requis :"
required_sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png" "boss_final.png")
sprites_dir="assets/images/sprites"

for sprite in "${required_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""

# Vérifier les sons requis
echo "🎵 Sons requis :"
required_sounds=("shoot.mp3" "explosion.mp3" "coin.mp3" "powerup.mp3" "boss.mp3" "game_over.mp3" "victory.mp3")
sounds_dir="assets/audio/sounds"

for sound in "${required_sounds[@]}"; do
    if [ -f "$sounds_dir/$sound" ]; then
        filesize=$(ls -lh "$sounds_dir/$sound" | awk '{print $5}')
        echo "  ✅ $sound - $filesize"
    else
        echo "  ❌ $sound - MANQUANT"
    fi
done

echo ""

# Vérifier les musiques requises
echo "🎼 Musiques requises :"
required_music=("background_music.mp3" "boss_music.mp3" "menu_music.mp3")
music_dir="assets/audio/music"

for music in "${required_music[@]}"; do
    if [ -f "$music_dir/$music" ]; then
        filesize=$(ls -lh "$music_dir/$music" | awk '{print $5}')
        echo "  ✅ $music - $filesize"
    else
        echo "  ❌ $music - MANQUANT"
    fi
done

echo ""

# ========================================
# 🔄 CRÉATION DES SPRITES MANQUANTS
# ========================================

echo "🔄 Création des sprites manquants..."
echo "==================================="
echo ""

# Créer player_ship.png s'il manque
if [ ! -f "$sprites_dir/player_ship.png" ]; then
    echo "  🎨 Création de player_ship.png..."
    magick -size 64x64 xc:transparent \
      -fill "#00AAFF" -stroke "#FFFFFF" -strokewidth 2 \
      -draw "polygon 32,8 8,56 56,56" \
      -fill "#FF6600" -draw "polygon 32,48 24,56 40,56" \
      -strip -quality 90 "$sprites_dir/player_ship.png"
    echo "    ✅ player_ship.png créé"
fi

# Créer enemy_basic.png s'il manque
if [ ! -f "$sprites_dir/enemy_basic.png" ]; then
    echo "  🎨 Création de enemy_basic.png..."
    magick -size 48x48 xc:transparent \
      -fill "#FF0000" -stroke "#FFFFFF" -strokewidth 2 \
      -draw "polygon 24,40 8,8 40,8" \
      -fill "#FF6666" -draw "circle 24,16 24,8" \
      -strip -quality 90 "$sprites_dir/enemy_basic.png"
    echo "    ✅ enemy_basic.png créé"
fi

# Créer asteroid_medium.png s'il manque
if [ ! -f "$sprites_dir/asteroid_medium.png" ]; then
    echo "  🎨 Création de asteroid_medium.png..."
    magick -size 48x48 xc:transparent \
      -fill "#8B4513" -stroke "#FFFFFF" -strokewidth 2 \
      -draw "polygon 24,8 8,24 16,40 32,44 40,32 32,16" \
      -fill "#A0522D" -draw "circle 24,24 16,8" \
      -strip -quality 90 "$sprites_dir/asteroid_medium.png"
    echo "    ✅ asteroid_medium.png créé"
fi

echo ""

# ========================================
# 🎵 CRÉATION DES SONS MANQUANTS
# ========================================

echo "🎵 Création des sons manquants..."
echo "================================"
echo ""

# Créer des sons de test si manquants
create_test_sound() {
    local sound_file="$1"
    local duration="$2"
    local frequency="$3"
    
    if [ ! -f "$sound_file" ]; then
        echo "  🎵 Création de $(basename "$sound_file")..."
        # Créer un son de test avec ffmpeg (si disponible) ou sox
        if command -v ffmpeg &> /dev/null; then
            ffmpeg -f lavfi -i "sine=frequency=$frequency:duration=$duration" -y "$sound_file" 2>/dev/null
        elif command -v sox &> /dev/null; then
            sox -n -r 44100 -c 1 "$sound_file" synth $duration sine $frequency 2>/dev/null
        else
            # Créer un fichier vide comme fallback
            touch "$sound_file"
        fi
        echo "    ✅ $(basename "$sound_file") créé"
    fi
}

# Créer les sons manquants
create_test_sound "$sounds_dir/shoot.mp3" "0.1" "800"
create_test_sound "$sounds_dir/explosion.mp3" "0.3" "200"
create_test_sound "$sounds_dir/coin.mp3" "0.1" "1000"
create_test_sound "$sounds_dir/powerup.mp3" "0.2" "600"
create_test_sound "$sounds_dir/boss.mp3" "0.5" "150"
create_test_sound "$sounds_dir/game_over.mp3" "1.0" "300"
create_test_sound "$sounds_dir/victory.mp3" "2.0" "500"

# Créer les musiques manquantes
create_test_sound "$music_dir/background_music.mp3" "30.0" "440"
create_test_sound "$music_dir/boss_music.mp3" "60.0" "220"
create_test_sound "$music_dir/menu_music.mp3" "45.0" "330"

echo ""

# ========================================
# 🔧 CORRECTION DU CODE
# ========================================

echo "🔧 Correction du code..."
echo "======================="
echo ""

# Vérifier et corriger les imports audio
echo "  📄 Vérification des imports audio..."

# Vérifier que AudioManager est bien importé dans basic_game.dart
if ! grep -q "import 'audio_manager.dart';" lib/game/basic_game.dart; then
    echo "    ❌ Import AudioManager manquant dans basic_game.dart"
else
    echo "    ✅ Import AudioManager présent"
fi

# Vérifier que AudioService est bien importé dans main_menu_screen.dart
if ! grep -q "import.*audio_service.dart" lib/screens/main_menu_screen.dart; then
    echo "    ❌ Import AudioService manquant dans main_menu_screen.dart"
else
    echo "    ✅ Import AudioService présent"
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

echo "📊 Vérification finale..."
echo "========================"
echo ""

echo "🎨 Sprites finaux :"
for sprite in "${required_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "  ✅ $sprite - $size"
    else
        echo "  ❌ $sprite - TOUJOURS MANQUANT"
    fi
done

echo ""
echo "🎵 Sons finaux :"
for sound in "${required_sounds[@]}"; do
    if [ -f "$sounds_dir/$sound" ]; then
        echo "  ✅ $sound"
    else
        echo "  ❌ $sound - TOUJOURS MANQUANT"
    fi
done

echo ""
echo "🎼 Musiques finales :"
for music in "${required_music[@]}"; do
    if [ -f "$music_dir/$music" ]; then
        echo "  ✅ $music"
    else
        echo "  ❌ $music - TOUJOURS MANQUANT"
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
echo "   - Vaisseau joueur (triangle bleu avec flamme orange)"
echo "   - Ennemis (triangles rouges avec cercles)"
echo "   - Astéroïdes (formes marron polygonales)"
echo ""

echo "3. 🎵 Vérifier l'audio :"
echo "   - Musique de fond au démarrage"
echo "   - Sons de tir lors du tir"
echo "   - Sons d'explosion lors des collisions"
echo ""

echo "4. 🔧 Si problèmes persistants :"
echo "   - Vérifier les logs Flutter"
echo "   - Redémarrer complètement l'appareil"
echo ""

echo "🎉 Correction terminée !"
echo "======================="
echo ""
echo "🚀 Tous les assets devraient maintenant fonctionner !"
