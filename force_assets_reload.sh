#!/bin/bash

# 🔄 Script de Rechargement Forcé des Assets - Galactic Vengeance
# Ce script force le rechargement des assets avec des logs détaillés

echo "🔄 Rechargement Forcé des Assets - Galactic Vengeance"
echo "==================================================="
echo ""

# ========================================
# 🔍 DIAGNOSTIC DÉTAILLÉ
# ========================================

echo "🔍 Diagnostic détaillé des assets..."
echo "==================================="
echo ""

# Vérifier les permissions des fichiers
echo "📁 Permissions des dossiers :"
echo "  assets/images/sprites/ : $(ls -ld assets/images/sprites/)"
echo "  assets/audio/sounds/ : $(ls -ld assets/audio/sounds/)"
echo "  assets/audio/music/ : $(ls -ld assets/audio/music/)"
echo ""

# Vérifier les formats des images
echo "🎨 Formats des sprites :"
sprites_dir="assets/images/sprites"
for sprite in player_ship.png enemy_basic.png asteroid_medium.png boss_final.png; do
    if [ -f "$sprites_dir/$sprite" ]; then
        format=$(file "$sprites_dir/$sprite" | grep -o 'PNG\|JPEG\|GIF' | head -1)
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $format, $size, $filesize"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""

# Vérifier les formats des sons
echo "🎵 Formats des sons :"
sounds_dir="assets/audio/sounds"
for sound in shoot.mp3 explosion.mp3 coin.mp3 powerup.mp3 boss.mp3 game_over.mp3 victory.mp3; do
    if [ -f "$sounds_dir/$sound" ]; then
        format=$(file "$sounds_dir/$sound" | grep -o 'MPEG\|Audio' | head -1)
        filesize=$(ls -lh "$sounds_dir/$sound" | awk '{print $5}')
        echo "  ✅ $sound - $format, $filesize"
    else
        echo "  ❌ $sound - MANQUANT"
    fi
done

echo ""

# ========================================
# 🔧 OPTIMISATION DES SPRITES
# ========================================

echo "🔧 Optimisation des sprites..."
echo "============================="
echo ""

# Optimiser les sprites pour Flutter
echo "  🔄 Optimisation de player_ship.png..."
if [ -f "$sprites_dir/player_ship.png" ]; then
    magick "$sprites_dir/player_ship.png" -strip -quality 95 -define png:compression-level=9 "$sprites_dir/player_ship.png"
    echo "    ✅ player_ship.png optimisé"
fi

echo "  🔄 Optimisation de enemy_basic.png..."
if [ -f "$sprites_dir/enemy_basic.png" ]; then
    magick "$sprites_dir/enemy_basic.png" -strip -quality 95 -define png:compression-level=9 "$sprites_dir/enemy_basic.png"
    echo "    ✅ enemy_basic.png optimisé"
fi

echo "  🔄 Optimisation de asteroid_medium.png..."
if [ -f "$sprites_dir/asteroid_medium.png" ]; then
    magick "$sprites_dir/asteroid_medium.png" -strip -quality 95 -define png:compression-level=9 "$sprites_dir/asteroid_medium.png"
    echo "    ✅ asteroid_medium.png optimisé"
fi

echo ""

# ========================================
# 📝 AJOUT DE LOGS DÉTAILLÉS
# ========================================

echo "📝 Ajout de logs détaillés..."
echo "============================"
echo ""

# Ajouter des logs détaillés dans player_ship.dart
echo "  📄 Ajout de logs dans player_ship.dart..."
sed -i '' 's/print('\''Loading player_ship.png...'\'');/print('\''🔍 Loading player_ship.png...'\'');\n      print('\''📁 Current directory: ${Directory.current.path}'\'');\n      print('\''📦 Images available: ${game.images.listFiles()}'\'');/g' lib/game/components/player_ship.dart

# Ajouter des logs détaillés dans enemy.dart
echo "  📄 Ajout de logs dans enemy.dart..."
sed -i '' 's/print('\''Loading enemy_basic.png...'\'');/print('\''🔍 Loading enemy_basic.png...'\'');\n      print('\''📁 Current directory: ${Directory.current.path}'\'');\n      print('\''📦 Images available: ${game.images.listFiles()}'\'');/g' lib/game/components/enemy.dart

# Ajouter des logs détaillés dans asteroid.dart
echo "  📄 Ajout de logs dans asteroid.dart..."
sed -i '' 's/print('\''Loading asteroid_medium.png...'\'');/print('\''🔍 Loading asteroid_medium.png...'\'');\n      print('\''📁 Current directory: ${Directory.current.path}'\'');\n      print('\''📦 Images available: ${game.images.listFiles()}'\'');/g' lib/game/components/asteroid.dart

echo "    ✅ Logs détaillés ajoutés"
echo ""

# ========================================
# 🧹 NETTOYAGE COMPLET
# ========================================

echo "🧹 Nettoyage complet..."
echo "======================"
echo ""

echo "  🔄 Suppression des caches..."
rm -rf .dart_tool/
rm -rf build/
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies

echo "  🔄 Nettoyage Flutter..."
flutter clean

echo "  🔄 Récupération des packages..."
flutter pub get

echo "  ✅ Nettoyage terminé"
echo ""

# ========================================
# 🔧 RÉGÉNÉRATION DES ICÔNES
# ========================================

echo "🔧 Régénération des icônes..."
echo "============================"
echo ""

echo "  🔄 Génération des icônes..."
flutter pub run flutter_launcher_icons:main

echo "  ✅ Icônes régénérées"
echo ""

# ========================================
# 📊 VÉRIFICATION FINALE
# ========================================

echo "📊 Vérification finale..."
echo "========================"
echo ""

echo "🎨 Sprites optimisés :"
for sprite in player_ship.png enemy_basic.png asteroid_medium.png boss_final.png; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($filesize)"
    fi
done

echo ""
echo "🎵 Sons vérifiés :"
for sound in shoot.mp3 explosion.mp3 coin.mp3 powerup.mp3 boss.mp3 game_over.mp3 victory.mp3; do
    if [ -f "$sounds_dir/$sound" ]; then
        filesize=$(ls -lh "$sounds_dir/$sound" | awk '{print $5}')
        echo "  ✅ $sound - $filesize"
    fi
done

echo ""
echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🚀 Lancer le jeu avec logs détaillés :"
echo "   flutter run --verbose"
echo ""

echo "2. 📋 Observer les logs pour :"
echo "   - 🔍 Messages de chargement des sprites"
echo "   - 📁 Chemins des fichiers"
echo "   - 📦 Images disponibles"
echo "   - ❌ Erreurs de chargement"
echo ""

echo "3. 🎨 Vérifier les sprites :"
echo "   - Vaisseau joueur (triangle bleu avec flamme orange)"
echo "   - Ennemis (triangles rouges avec cercles)"
echo "   - Astéroïdes (formes marron polygonales)"
echo ""

echo "4. 🎵 Vérifier l'audio :"
echo "   - Musique de fond au démarrage"
echo "   - Sons de tir lors du tir"
echo "   - Sons d'explosion lors des collisions"
echo ""

echo "🎉 Rechargement forcé terminé !"
echo "=============================="
echo ""
echo "🚀 Les assets devraient maintenant se charger correctement !"
