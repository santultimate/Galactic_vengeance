#!/bin/bash

# Script pour télécharger les assets audio pour Galactic Vengeance
echo "🎵 Téléchargement des Assets Audio - Galactic Vengeance"

# Créer les dossiers audio
mkdir -p assets/audio/music
mkdir -p assets/audio/sounds

echo "📁 Dossiers audio créés"

# URLs des musiques (exemples - à remplacer par les vrais liens)
MUSIC_URLS=(
    "https://pixabay.com/music/video-games-space-battle-141985/"
    "https://pixabay.com/music/video-games-sci-fi-action-141984/"
    "https://pixabay.com/music/video-games-space-adventure-141983/"
)

# URLs des effets sonores
SOUND_URLS=(
    "https://pixabay.com/sound-effects/laser-shot-1-145251/"
    "https://pixabay.com/sound-effects/explosion-1-145252/"
    "https://pixabay.com/sound-effects/power-up-1-145253/"
    "https://pixabay.com/sound-effects/boss-warning-1-145254/"
    "https://pixabay.com/sound-effects/game-over-1-145255/"
    "https://pixabay.com/sound-effects/victory-1-145256/"
    "https://pixabay.com/sound-effects/button-click-1-145257/"
    "https://pixabay.com/sound-effects/coin-1-145258/"
)

echo "⚠️  Note: Les URLs sont des exemples"
echo "📋 Veuillez télécharger manuellement depuis les liens suivants:"
echo ""

echo "🎵 MUSIQUES:"
echo "1. Space Battle: https://pixabay.com/music/video-games-space-battle-141985/"
echo "2. Sci-Fi Action: https://pixabay.com/music/video-games-sci-fi-action-141984/"
echo "3. Space Adventure: https://pixabay.com/music/video-games-space-adventure-141983/"
echo ""

echo "🔊 EFFETS SONORES:"
echo "1. Laser Shot: https://pixabay.com/sound-effects/search/laser/"
echo "2. Explosion: https://pixabay.com/sound-effects/search/explosion/"
echo "3. Power-up: https://pixabay.com/sound-effects/search/power-up/"
echo "4. Boss Warning: https://pixabay.com/sound-effects/search/warning/"
echo "5. Game Over: https://pixabay.com/sound-effects/search/game-over/"
echo "6. Victory: https://pixabay.com/sound-effects/search/victory/"
echo "7. Button Click: https://pixabay.com/sound-effects/search/click/"
echo "8. Coin: https://pixabay.com/sound-effects/search/coin/"
echo ""

echo "📁 Structure des fichiers attendue:"
echo "assets/audio/"
echo "├── music/"
echo "│   ├── background_music.mp3"
echo "│   ├── menu_music.mp3"
echo "│   └── boss_music.mp3"
echo "└── sounds/"
echo "    ├── shoot.wav"
echo "    ├── explosion.wav"
echo "    ├── powerup.wav"
echo "    ├── boss.wav"
echo "    ├── game_over.wav"
echo "    ├── victory.wav"
echo "    ├── button_click.wav"
echo "    └── coin.wav"
echo ""

echo "✅ Script terminé!"
echo "🎯 Prochaines étapes:"
echo "1. Télécharger les fichiers audio"
echo "2. Les placer dans les bons dossiers"
echo "3. Tester dans le jeu"
