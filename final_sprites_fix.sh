#!/bin/bash

# 🎯 Correction Finale des Sprites - Galactic Vengeance
# Ce script force la correction de tous les chemins de sprites

echo "🎯 Correction Finale des Sprites - Galactic Vengeance"
echo "=================================================="
echo ""

# ========================================
# 🔍 DIAGNOSTIC INITIAL
# ========================================

echo "🔍 Diagnostic initial..."
echo "======================"
echo ""

# Vérifier les fichiers sprites
sprites_dir="assets/images/sprites"
required_sprites=("vaisseau.png" "ennemi.png" "meteor.png" "boss_final.png")

for sprite in "${required_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "  ✅ $sprite - $size"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""

# ========================================
# 🔧 CORRECTION FORCÉE DES CHEMINS
# ========================================

echo "🔧 Correction forcée des chemins..."
echo "================================="
echo ""

# 1. Corriger basic_game.dart
echo "📄 Correction de basic_game.dart..."
sed -i '' 's|assets/images/vaisseau\.png|sprites/vaisseau.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/ennemi\.png|sprites/ennemi.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/meteor\.png|sprites/meteor.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/boss_final\.png|sprites/boss_final.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/powerup_shield\.png|sprites/powerup_shield.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/powerup_rapid_fire\.png|sprites/powerup_rapid_fire.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/powerup_laser\.png|sprites/powerup_laser.png|g' lib/game/basic_game.dart
sed -i '' 's|assets/images/powerup_speed\.png|sprites/powerup_speed.png|g' lib/game/basic_game.dart
echo "  ✅ basic_game.dart corrigé"

# 2. Corriger player_ship.dart
echo "📄 Correction de player_ship.dart..."
sed -i '' 's|assets/images/vaisseau\.png|sprites/vaisseau.png|g' lib/game/components/player_ship.dart
sed -i '' 's|vaisseau\.png|sprites/vaisseau.png|g' lib/game/components/player_ship.dart
echo "  ✅ player_ship.dart corrigé"

# 3. Corriger enemy.dart
echo "📄 Correction de enemy.dart..."
sed -i '' 's|assets/images/ennemi\.png|sprites/ennemi.png|g' lib/game/components/enemy.dart
sed -i '' 's|ennemi\.png|sprites/ennemi.png|g' lib/game/components/enemy.dart
echo "  ✅ enemy.dart corrigé"

# 4. Corriger asteroid.dart
echo "📄 Correction de asteroid.dart..."
sed -i '' 's|assets/images/meteor\.png|sprites/meteor.png|g' lib/game/components/asteroid.dart
sed -i '' 's|meteor\.png|sprites/meteor.png|g' lib/game/components/asteroid.dart
echo "  ✅ asteroid.dart corrigé"

# 5. Corriger boss.dart
echo "📄 Correction de boss.dart..."
sed -i '' 's|assets/images/boss_final\.png|sprites/boss_final.png|g' lib/game/components/boss.dart
sed -i '' 's|boss_final\.png|sprites/boss_final.png|g' lib/game/components/boss.dart
echo "  ✅ boss.dart corrigé"

# 6. Corriger tous les autres fichiers Dart
echo "📄 Correction de tous les fichiers Dart..."
find lib -name "*.dart" -exec sed -i '' 's|assets/images/vaisseau\.png|sprites/vaisseau.png|g' {} \;
find lib -name "*.dart" -exec sed -i '' 's|assets/images/ennemi\.png|sprites/ennemi.png|g' {} \;
find lib -name "*.dart" -exec sed -i '' 's|assets/images/meteor\.png|sprites/meteor.png|g' {} \;
find lib -name "*.dart" -exec sed -i '' 's|assets/images/boss_final\.png|sprites/boss_final.png|g' {} \;
echo "  ✅ Tous les fichiers Dart corrigés"

echo ""

# ========================================
# 🧹 NETTOYAGE COMPLET
# ========================================

echo "🧹 Nettoyage complet..."
echo "======================"
echo ""

echo "🔄 Nettoyage du cache Flutter..."
flutter clean
echo "  ✅ Cache nettoyé"

echo "📦 Réinstallation des dépendances..."
flutter pub get
echo "  ✅ Dépendances réinstallées"

echo "🏗️ Build complet..."
flutter build ios --debug
echo "  ✅ Build terminé"

echo ""

# ========================================
# 🔍 VÉRIFICATION FINALE
# ========================================

echo "🔍 Vérification finale..."
echo "======================="
echo ""

echo "📄 Vérification des chemins corrects..."
if grep -q "sprites/vaisseau.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/vaisseau.png dans basic_game.dart"
else
    echo "  ❌ sprites/vaisseau.png manquant dans basic_game.dart"
fi

if grep -q "sprites/ennemi.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/ennemi.png dans basic_game.dart"
else
    echo "  ❌ sprites/ennemi.png manquant dans basic_game.dart"
fi

if grep -q "sprites/meteor.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/meteor.png dans basic_game.dart"
else
    echo "  ❌ sprites/meteor.png manquant dans basic_game.dart"
fi

echo ""
echo "🔍 Vérification qu'il n'y a plus d'anciens chemins..."
if grep -r "assets/images/vaisseau\.png" lib/; then
    echo "  ❌ Anciens chemins trouvés dans vaisseau"
else
    echo "  ✅ Aucun ancien chemin pour vaisseau"
fi

if grep -r "assets/images/ennemi\.png" lib/; then
    echo "  ❌ Anciens chemins trouvés dans ennemi"
else
    echo "  ✅ Aucun ancien chemin pour ennemi"
fi

if grep -r "assets/images/meteor\.png" lib/; then
    echo "  ❌ Anciens chemins trouvés dans meteor"
else
    echo "  ✅ Aucun ancien chemin pour meteor"
fi

echo ""

# ========================================
# 🚀 LANCEMENT DU TEST
# ========================================

echo "🚀 Lancement du test..."
echo "======================"
echo ""

echo "🎮 Lancement de l'application..."
echo "  📱 Utilisez 'flutter run' pour tester"
echo "  🔍 Vérifiez que les sprites s'affichent"
echo "  ⏸️ Testez le menu de pause"
echo ""

echo "✅ Correction finale terminée !"
echo ""
echo "🎯 Prochaines étapes :"
echo "1. flutter run"
echo "2. Vérifier que les sprites s'affichent"
echo "3. Tester le menu de pause"
echo "4. Confirmer qu'il n'y a plus d'erreurs"
echo ""

