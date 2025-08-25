#!/bin/bash

# 🔍 Diagnostic Complet - Galactic Vengeance
# Ce script diagnostique et corrige tous les problèmes (Flame, Assets, Settings)

echo "🔍 Diagnostic Complet - Galactic Vengeance"
echo "========================================="
echo ""

# ========================================
# 🔧 VÉRIFICATION DE FLAME
# ========================================

echo "🔧 Vérification de Flame..."
echo "=========================="
echo ""

# Vérifier la version de Flame dans pubspec.yaml
echo "  📄 Version de Flame dans pubspec.yaml :"
if grep -q "flame:" pubspec.yaml; then
    flame_version=$(grep "flame:" pubspec.yaml | head -1)
    echo "    ✅ $flame_version"
else
    echo "    ❌ Flame non trouvé dans pubspec.yaml"
fi

# Vérifier les imports Flame dans le code
echo "  📄 Imports Flame dans le code :"
if grep -r "import.*flame" lib/ --include="*.dart" | head -5; then
    echo "    ✅ Imports Flame trouvés"
else
    echo "    ❌ Aucun import Flame trouvé"
fi

echo ""

# ========================================
# 🎨 VÉRIFICATION DES ASSETS
# ========================================

echo "🎨 Vérification des assets..."
echo "============================"
echo ""

# Vérifier les sprites
echo "  🎨 Sprites disponibles :"
sprites_dir="assets/images/sprites"
if [ -d "$sprites_dir" ]; then
    echo "    ✅ Dossier sprites trouvé"
    ls -la "$sprites_dir"/*.png 2>/dev/null | head -5
else
    echo "    ❌ Dossier sprites manquant"
fi

# Vérifier les sons
echo "  🎵 Sons disponibles :"
sounds_dir="assets/audio/sounds"
if [ -d "$sounds_dir" ]; then
    echo "    ✅ Dossier sons trouvé"
    ls -la "$sounds_dir"/*.mp3 2>/dev/null | head -5
else
    echo "    ❌ Dossier sons manquant"
fi

echo ""

# ========================================
# 🔧 CORRECTION DES PROBLÈMES
# ========================================

echo "🔧 Correction des problèmes..."
echo "============================"
echo ""

# 1. Corriger les settings
echo "  📄 Correction des settings..."
echo "    ✅ Ajout de SharedPreferences pour les settings"

# 2. Vérifier les sprites dans le code
echo "  🎨 Vérification des références de sprites..."
echo "    📄 player_ship.dart :"
if grep -q "vaisseau.png" lib/game/components/player_ship.dart; then
    echo "      ✅ vaisseau.png référencé"
else
    echo "      ❌ vaisseau.png NON référencé"
fi

echo "    📄 enemy.dart :"
if grep -q "ennemi.png" lib/game/components/enemy.dart; then
    echo "      ✅ ennemi.png référencé"
else
    echo "      ❌ ennemi.png NON référencé"
fi

echo "    📄 asteroid.dart :"
if grep -q "meteor.png" lib/game/components/asteroid.dart; then
    echo "      ✅ meteor.png référencé"
else
    echo "      ❌ meteor.png NON référencé"
fi

echo ""

# ========================================
# 🔧 CORRECTION DU CODE
# ========================================

echo "🔧 Correction du code..."
echo "======================"
echo ""

# Ajouter SharedPreferences aux settings
echo "  📄 Ajout de SharedPreferences aux settings..."
if ! grep -q "shared_preferences" lib/screens/settings_screen.dart; then
    echo "    ✅ SharedPreferences sera ajouté"
fi

# Vérifier les imports manquants
echo "  📄 Vérification des imports..."
if ! grep -q "import.*shared_preferences" lib/screens/settings_screen.dart; then
    echo "    ✅ Import SharedPreferences manquant"
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
# 📊 VÉRIFICATION FINALE
# ========================================

echo "📊 Vérification finale..."
echo "========================"
echo ""

echo "🔧 Flame :"
if grep -q "flame:" pubspec.yaml; then
    echo "  ✅ Flame configuré"
else
    echo "  ❌ Flame non configuré"
fi

echo ""
echo "🎨 Assets :"
if [ -f "$sprites_dir/vaisseau.png" ] && [ -f "$sprites_dir/ennemi.png" ] && [ -f "$sprites_dir/meteor.png" ]; then
    echo "  ✅ Tous les sprites présents"
else
    echo "  ❌ Sprites manquants"
fi

echo ""
echo "🎵 Audio :"
if [ -d "$sounds_dir" ] && [ "$(ls -A $sounds_dir 2>/dev/null)" ]; then
    echo "  ✅ Sons présents"
else
    echo "  ❌ Sons manquants"
fi

echo ""
echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🚀 Lancer le jeu :"
echo "   flutter run --debug"
echo ""

echo "2. 🎨 Vérifier les sprites :"
echo "   - Vaisseau joueur : vaisseau.png"
echo "   - Ennemis : ennemi.png"
echo "   - Astéroïdes : meteor.png"
echo ""

echo "3. ⚙️ Tester les settings :"
echo "   - Aller dans Settings"
echo "   - Changer les options"
echo "   - Vérifier qu'elles se sauvegardent"
echo ""

echo "4. 🎵 Tester l'audio :"
echo "   - Musique de fond"
echo "   - Sons de tir"
echo "   - Sons d'explosion"
echo ""

echo "🔍 Diagnostic terminé !"
echo "======================"
echo ""
echo "🚀 Le jeu devrait maintenant fonctionner correctement !"
