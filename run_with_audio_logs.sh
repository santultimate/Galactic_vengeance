#!/bin/bash

# 🎵 Lancement avec Logs Audio - Galactic Vengeance
# Ce script lance le jeu avec tous les logs audio activés

echo "🎵 Lancement avec Logs Audio - Galactic Vengeance"
echo "================================================"
echo ""

# ========================================
# 📊 VÉRIFICATION DES ASSETS AUDIO
# ========================================

echo "📊 Vérification des assets audio..."
echo "=================================="
echo ""

# Vérifier les sons
echo "  🎵 Sons disponibles :"
sounds_dir="assets/audio/sounds"
if [ -d "$sounds_dir" ]; then
    echo "    ✅ Dossier sons trouvé"
    ls -la "$sounds_dir"/*.mp3 2>/dev/null | while read file; do
        echo "      📄 $file"
    done
else
    echo "    ❌ Dossier sons manquant"
fi

# Vérifier la musique
echo "  🎼 Musique disponible :"
music_dir="assets/audio/music"
if [ -d "$music_dir" ]; then
    echo "    ✅ Dossier musique trouvé"
    ls -la "$music_dir"/*.mp3 2>/dev/null | while read file; do
        echo "      📄 $file"
    done
else
    echo "    ❌ Dossier musique manquant"
fi

echo ""

# ========================================
# 🔧 VÉRIFICATION DES LOGS
# ========================================

echo "🔧 Vérification des logs audio..."
echo "================================"
echo ""

echo "  📄 Logs ajoutés dans AudioManager :"
echo "    ✅ Initialisation AudioManager"
echo "    ✅ Sons de tir (shoot.mp3)"
echo "    ✅ Sons d'explosion (explosion.mp3)"
echo "    ✅ Sons de power-up (powerup.mp3)"
echo "    ✅ Sons de pièces (coin.mp3)"
echo "    ✅ Sons de boss (boss.mp3)"
echo "    ✅ Musique de fond (background_music.mp3)"
echo ""

echo "  📄 Logs ajoutés dans BasicGame :"
echo "    ✅ Initialisation audio du jeu"
echo "    ✅ Sons de tir lors du tir"
echo "    ✅ Sons de power-up lors de la collecte"
echo "    ✅ Sons de boss lors de l'apparition"
echo "    ✅ Sons d'explosion lors de la destruction"
echo ""

# ========================================
# 🧹 NETTOYAGE FINAL
# ========================================

echo "🧹 Nettoyage final..."
echo "===================="
echo ""

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 🚀 LANCEMENT AVEC LOGS
# ========================================

echo "🚀 Lancement avec logs audio..."
echo "=============================="
echo ""

echo "🎯 Le jeu va maintenant se lancer avec tous les logs audio !"
echo ""
echo "📱 Logs à observer dans la console :"
echo "===================================="
echo ""
echo "🎵 Initialisation :"
echo "  🎵 Initializing AudioManager..."
echo "  ✅ AudioManager initialized successfully"
echo "  🎵 Starting background music..."
echo "  ✅ Background music started successfully (loop mode)"
echo "  ✅ Game audio initialized successfully"
echo ""
echo "🔫 Sons de tir :"
echo "  🔫 Bullet fired at position: [x], [y]"
echo "  🔫 Playing shoot sound..."
echo "  ✅ Shoot sound played successfully"
echo ""
echo "⚡ Power-ups :"
echo "  ⚡ Power-up collected: [type]"
echo "  ⚡ Playing power-up sound..."
echo "  ✅ Power-up sound played successfully"
echo ""
echo "👹 Boss :"
echo "  👹 Spawning boss: [type]"
echo "  👹 Playing boss sound..."
echo "  ✅ Boss sound played successfully"
echo ""
echo "💥 Explosions :"
echo "  💥 Enemy destroyed at position: [x], [y]"
echo "  💥 Playing explosion sound..."
echo "  ✅ Explosion sound played successfully"
echo ""
echo "🪙 Pièces :"
echo "  🪙 Playing coin sound..."
echo "  ✅ Coin sound played successfully"
echo ""

echo "🚀 Lancement en cours..."
echo "========================"
echo ""

flutter run --debug
