#!/bin/bash

# 🧹 Force Clean et Relance - Galactic Vengeance
# Ce script force un nettoyage complet et relance le jeu

echo "🧹 Force Clean et Relance - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 🧹 NETTOYAGE FORCÉ
# ========================================

echo "🧹 Nettoyage forcé..."
echo "===================="
echo ""

echo "  🔄 Arrêt de tous les processus Flutter..."
pkill -f "flutter" 2>/dev/null || true
pkill -f "dart" 2>/dev/null || true

echo "  🔄 Nettoyage Flutter complet..."
flutter clean

echo "  🔄 Suppression du cache pub..."
rm -rf .dart_tool/ 2>/dev/null || true
rm -rf build/ 2>/dev/null || true
rm -rf .flutter-plugins 2>/dev/null || true
rm -rf .flutter-plugins-dependencies 2>/dev/null || true

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  🔄 Régénération des icônes..."
flutter pub run flutter_launcher_icons:main

echo "  ✅ Nettoyage forcé terminé"
echo ""

# ========================================
# 📊 VÉRIFICATION DES ASSETS
# ========================================

echo "📊 Vérification des assets..."
echo "============================"
echo ""

echo "  🎵 Vérification des fichiers audio :"
if [ -f "assets/audio/sounds/explosion.mp3" ]; then
    echo "    ✅ explosion.mp3 présent"
else
    echo "    ❌ explosion.mp3 manquant"
fi

if [ -f "assets/audio/sounds/shoot.mp3" ]; then
    echo "    ✅ shoot.mp3 présent"
else
    echo "    ❌ shoot.mp3 manquant"
fi

if [ -f "assets/audio/sounds/powerup.mp3" ]; then
    echo "    ✅ powerup.mp3 présent"
else
    echo "    ❌ powerup.mp3 manquant"
fi

if [ -f "assets/audio/music/background_music.mp3" ]; then
    echo "    ✅ background_music.mp3 présent"
else
    echo "    ❌ background_music.mp3 manquant"
fi

echo ""

# ========================================
# 🔧 VÉRIFICATION DU CODE
# ========================================

echo "🔧 Vérification du code..."
echo "========================="
echo ""

echo "  📄 Vérification des chemins dans AudioManager :"
if grep -q "assets/audio/sounds/explosion.mp3" lib/game/audio_manager.dart; then
    echo "    ✅ Chemin explosion.mp3 correct"
else
    echo "    ❌ Chemin explosion.mp3 incorrect"
fi

if grep -q "assets/audio/sounds/shoot.mp3" lib/game/audio_manager.dart; then
    echo "    ✅ Chemin shoot.mp3 correct"
else
    echo "    ❌ Chemin shoot.mp3 incorrect"
fi

if grep -q "assets/audio/music/background_music.mp3" lib/game/audio_manager.dart; then
    echo "    ✅ Chemin background_music.mp3 correct"
else
    echo "    ❌ Chemin background_music.mp3 incorrect"
fi

echo ""

# ========================================
# 🚀 LANCEMENT FORCÉ
# ========================================

echo "🚀 Lancement forcé..."
echo "==================="
echo ""

echo "🎯 Le jeu va maintenant se lancer avec un nettoyage forcé !"
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
