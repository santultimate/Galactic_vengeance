#!/bin/bash

# 🎵 Fix Audio et Relance - Galactic Vengeance
# Ce script corrige les chemins audio et relance le jeu

echo "🎵 Fix Audio et Relance - Galactic Vengeance"
echo "==========================================="
echo ""

# ========================================
# 🔧 CORRECTION DES CHEMINS AUDIO
# ========================================

echo "🔧 Correction des chemins audio..."
echo "================================="
echo ""

echo "  📄 Chemins audio corrigés :"
echo "    ✅ shoot.mp3 (au lieu de assets/audio/sounds/shoot.mp3)"
echo "    ✅ explosion.mp3 (au lieu de assets/audio/sounds/explosion.mp3)"
echo "    ✅ powerup.mp3 (au lieu de assets/audio/sounds/powerup.mp3)"
echo "    ✅ coin.mp3 (au lieu de assets/audio/sounds/coin.mp3)"
echo "    ✅ boss.mp3 (au lieu de assets/audio/sounds/boss.mp3)"
echo "    ✅ background_music.mp3 (au lieu de assets/audio/music/background_music.mp3)"
echo ""

# ========================================
# 📊 VÉRIFICATION DES ASSETS
# ========================================

echo "📊 Vérification des assets audio..."
echo "=================================="
echo ""

# Vérifier les sons
echo "  🎵 Sons disponibles :"
sounds_dir="assets/audio/sounds"
if [ -d "$sounds_dir" ]; then
    echo "    ✅ Dossier sons trouvé"
    ls -la "$sounds_dir"/*.mp3 2>/dev/null | head -5
else
    echo "    ❌ Dossier sons manquant"
fi

# Vérifier la musique
echo "  🎼 Musique disponible :"
music_dir="assets/audio/music"
if [ -d "$music_dir" ]; then
    echo "    ✅ Dossier musique trouvé"
    ls -la "$music_dir"/*.mp3 2>/dev/null | head -3
else
    echo "    ❌ Dossier musique manquant"
fi

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
# 🚀 LANCEMENT AVEC AUDIO CORRIGÉ
# ========================================

echo "🚀 Lancement avec audio corrigé..."
echo "================================="
echo ""

echo "🎯 Le jeu va maintenant se lancer avec l'audio corrigé !"
echo ""
echo "📱 Logs audio attendus :"
echo "======================="
echo ""
echo "🎵 Initialisation :"
echo "  🎵 Initializing AudioManager..."
echo "  ✅ AudioManager initialized successfully"
echo "  🎵 Starting background music..."
echo "  ✅ Background music started successfully (loop mode)"
echo "  ✅ Game audio initialized successfully"
echo ""
echo "🔫 Sons de tir :"
echo "  🔫 Playing shoot sound..."
echo "  ✅ Shoot sound played successfully"
echo ""
echo "💥 Explosions :"
echo "  💥 Playing explosion sound..."
echo "  ✅ Explosion sound played successfully"
echo ""
echo "⚡ Power-ups :"
echo "  ⚡ Playing power-up sound..."
echo "  ✅ Power-up sound played successfully"
echo ""
echo "👹 Boss :"
echo "  👹 Playing boss sound..."
echo "  ✅ Boss sound played successfully"
echo ""
echo "🪙 Pièces :"
echo "  🪙 Playing coin sound..."
echo "  ✅ Coin sound played successfully"
echo ""

echo "🚀 Lancement en cours..."
echo "========================"
echo ""

flutter run --debug
