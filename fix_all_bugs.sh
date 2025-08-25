#!/bin/bash

# 🐛 Correction Complète des Bugs - Galactic Vengeance
# Ce script corrige tous les bugs identifiés

echo "🐛 Correction Complète des Bugs - Galactic Vengeance"
echo "=================================================="
echo ""

# ========================================
# 🔧 CORRECTION DES CHEMINS DE SPRITES
# ========================================

echo "🔧 Correction des chemins de sprites..."
echo "====================================="
echo ""

# Vérifier et corriger basic_game.dart
echo "📄 Vérification de basic_game.dart..."
if grep -q "sprites/vaisseau.png" lib/game/basic_game.dart; then
    echo "  ✅ Chemins sprites/ déjà corrects"
else
    echo "  🔄 Correction des chemins..."
    sed -i '' 's|assets/images/vaisseau\.png|sprites/vaisseau.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/ennemi\.png|sprites/ennemi.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/meteor\.png|sprites/meteor.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/boss_final\.png|sprites/boss_final.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/powerup_shield\.png|sprites/powerup_shield.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/powerup_rapid_fire\.png|sprites/powerup_rapid_fire.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/powerup_laser\.png|sprites/powerup_laser.png|g' lib/game/basic_game.dart
    sed -i '' 's|assets/images/powerup_speed\.png|sprites/powerup_speed.png|g' lib/game/basic_game.dart
    echo "  ✅ Chemins corrigés"
fi

# ========================================
# 🛡️ CORRECTION DE L'ERREUR DE LISTE VIDE
# ========================================

echo ""
echo "🛡️ Correction de l'erreur de liste vide..."
echo "========================================="
echo ""

# Créer un fichier temporaire avec la correction
temp_file="temp_basic_game.dart"

# Lire le fichier et appliquer les corrections
cat lib/game/basic_game.dart | sed '
# Corriger la boucle asteroids
/for (int i = asteroids\.length - 1; i >= 0; i--)/ {
    a\
    if (asteroids.isEmpty) break;
}
# Corriger la boucle enemies
/for (int i = enemies\.length - 1; i >= 0; i--)/ {
    a\
    if (enemies.isEmpty) break;
}
# Corriger la boucle powerUps
/for (int i = powerUps\.length - 1; i >= 0; i--)/ {
    a\
    if (powerUps.isEmpty) break;
}
# Corriger la boucle bullets
/for (int i = bullets\.length - 1; i >= 0; i--)/ {
    a\
    if (bullets.isEmpty) break;
}
' > "$temp_file"

# Remplacer le fichier original
mv "$temp_file" lib/game/basic_game.dart

echo "  ✅ Protection contre les listes vides ajoutée"

# ========================================
# 🔍 VÉRIFICATION DES FICHIERS SPRITES
# ========================================

echo ""
echo "🔍 Vérification des fichiers sprites..."
echo "======================================"
echo ""

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

# ========================================
# 📋 VÉRIFICATION DE PUBSPEC.YAML
# ========================================

echo ""
echo "📋 Vérification de pubspec.yaml..."
echo "================================="
echo ""

if grep -q "assets/images/sprites/" pubspec.yaml; then
    echo "  ✅ assets/images/sprites/ déclaré"
else
    echo "  ❌ assets/images/sprites/ NON déclaré"
    echo "  🔄 Ajout de la déclaration..."
    # Ajouter la déclaration si elle n'existe pas
    sed -i '' '/assets\/images\//a\
    - assets/images/sprites/' pubspec.yaml
    echo "  ✅ Déclaration ajoutée"
fi

# ========================================
# 🧹 NETTOYAGE COMPLET
# ========================================

echo ""
echo "🧹 Nettoyage complet..."
echo "======================"
echo ""

echo "🔄 Nettoyage du cache Flutter..."
flutter clean
echo "  ✅ Cache nettoyé"

echo "📦 Réinstallation des dépendances..."
flutter pub get
echo "  ✅ Dépendances réinstallées"

# ========================================
# 🎯 VÉRIFICATION FINALE
# ========================================

echo ""
echo "🎯 Vérification finale..."
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
echo "🛡️ Vérification des protections de liste vide..."
if grep -q "if (asteroids.isEmpty) break;" lib/game/basic_game.dart; then
    echo "  ✅ Protection asteroids ajoutée"
else
    echo "  ❌ Protection asteroids manquante"
fi

if grep -q "if (enemies.isEmpty) break;" lib/game/basic_game.dart; then
    echo "  ✅ Protection enemies ajoutée"
else
    echo "  ❌ Protection enemies manquante"
fi

if grep -q "if (powerUps.isEmpty) break;" lib/game/basic_game.dart; then
    echo "  ✅ Protection powerUps ajoutée"
else
    echo "  ❌ Protection powerUps manquante"
fi

if grep -q "if (bullets.isEmpty) break;" lib/game/basic_game.dart; then
    echo "  ✅ Protection bullets ajoutée"
else
    echo "  ❌ Protection bullets manquante"
fi

# ========================================
# 🚀 LANCEMENT DU TEST
# ========================================

echo ""
echo "🚀 Lancement du test..."
echo "======================"
echo ""

echo "🎮 Lancement de l'application..."
echo "  📱 Utilisez 'flutter run' pour tester"
echo "  🔍 Vérifiez que les sprites s'affichent"
echo "  ⏸️ Testez le menu de pause"
echo "  🛡️ Plus d'erreurs de liste vide"
echo ""

echo "✅ Correction complète terminée !"
echo ""
echo "🎯 Prochaines étapes :"
echo "1. flutter run"
echo "2. Vérifier que les sprites s'affichent"
echo "3. Tester le menu de pause"
echo "4. Confirmer qu'il n'y a plus d'erreurs"
echo ""
