#!/bin/bash

# 🔍 Diagnostic des Sprites - Galactic Vengeance
# Ce script diagnostique pourquoi les sprites ne se chargent pas

echo "🔍 Diagnostic des Sprites - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 📁 VÉRIFICATION DES FICHIERS
# ========================================

echo "📁 Vérification des fichiers..."
echo "=============================="
echo ""

sprites_dir="assets/images/sprites"
required_sprites=("vaisseau.png" "ennemi.png" "meteor.png" "boss_final.png")

for sprite in "${required_sprites[@]}"; do
    if [ -f "$sprites_dir/$sprite" ]; then
        size=$(file "$sprites_dir/$sprite" | grep -o '[0-9]* x [0-9]*' | head -1)
        file_size=$(ls -lh "$sprites_dir/$sprite" | awk '{print $5}')
        echo "  ✅ $sprite - $size ($file_size)"
    else
        echo "  ❌ $sprite - MANQUANT"
    fi
done

echo ""

# ========================================
# 🔍 VÉRIFICATION DES CHEMINS DANS LE CODE
# ========================================

echo "🔍 Vérification des chemins dans le code..."
echo "=========================================="
echo ""

# Vérifier basic_game.dart
echo "📄 basic_game.dart :"
if grep -q "sprites/vaisseau.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/vaisseau.png trouvé"
else
    echo "  ❌ sprites/vaisseau.png NON trouvé"
fi

if grep -q "sprites/ennemi.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/ennemi.png trouvé"
else
    echo "  ❌ sprites/ennemi.png NON trouvé"
fi

if grep -q "sprites/meteor.png" lib/game/basic_game.dart; then
    echo "  ✅ sprites/meteor.png trouvé"
else
    echo "  ❌ sprites/meteor.png NON trouvé"
fi

echo ""

# Vérifier les composants
echo "📄 Composants :"
if grep -q "sprites/vaisseau.png" lib/game/components/player_ship.dart; then
    echo "  ✅ player_ship.dart - sprites/vaisseau.png"
else
    echo "  ❌ player_ship.dart - sprites/vaisseau.png manquant"
fi

if grep -q "sprites/ennemi.png" lib/game/components/enemy.dart; then
    echo "  ✅ enemy.dart - sprites/ennemi.png"
else
    echo "  ❌ enemy.dart - sprites/ennemi.png manquant"
fi

if grep -q "sprites/meteor.png" lib/game/components/asteroid.dart; then
    echo "  ✅ asteroid.dart - sprites/meteor.png"
else
    echo "  ❌ asteroid.dart - sprites/meteor.png manquant"
fi

echo ""

# ========================================
# 📋 VÉRIFICATION DE PUBSPEC.YAML
# ========================================

echo "📋 Vérification de pubspec.yaml..."
echo "================================="
echo ""

if grep -q "assets/images/sprites/" pubspec.yaml; then
    echo "  ✅ assets/images/sprites/ déclaré"
else
    echo "  ❌ assets/images/sprites/ NON déclaré"
fi

if grep -q "assets/images/" pubspec.yaml; then
    echo "  ✅ assets/images/ déclaré"
else
    echo "  ❌ assets/images/ NON déclaré"
fi

echo ""

# ========================================
# 🔧 VÉRIFICATION DU CACHE FLUTTER
# ========================================

echo "🔧 Vérification du cache Flutter..."
echo "=================================="
echo ""

# Vérifier si les assets sont dans le cache
cache_dir="build/app/intermediates/flutter/debug/assets"
if [ -d "$cache_dir" ]; then
    echo "  ✅ Dossier cache Flutter présent"
    
    # Chercher les sprites dans le cache
    for sprite in "${required_sprites[@]}"; do
        if find "$cache_dir" -name "$sprite" -type f | grep -q .; then
            echo "    ✅ $sprite trouvé dans le cache"
        else
            echo "    ❌ $sprite NON trouvé dans le cache"
        fi
    done
else
    echo "  ❌ Dossier cache Flutter manquant"
fi

echo ""

# ========================================
# 🧪 TEST DE CHARGEMENT D'ASSET
# ========================================

echo "🧪 Test de chargement d'asset..."
echo "==============================="
echo ""

# Créer un test simple pour vérifier le chargement
test_file="test_asset_loading.dart"
cat > "$test_file" << 'EOF'
import 'package:flutter/services.dart';

void main() async {
  try {
    print('🔍 Test de chargement de sprites/vaisseau.png...');
    final data = await rootBundle.load('assets/images/sprites/vaisseau.png');
    print('✅ sprites/vaisseau.png chargé avec succès (${data.lengthInBytes} bytes)');
  } catch (e) {
    print('❌ Erreur lors du chargement de sprites/vaisseau.png: $e');
  }
  
  try {
    print('🔍 Test de chargement de sprites/ennemi.png...');
    final data = await rootBundle.load('assets/images/sprites/ennemi.png');
    print('✅ sprites/ennemi.png chargé avec succès (${data.lengthInBytes} bytes)');
  } catch (e) {
    print('❌ Erreur lors du chargement de sprites/ennemi.png: $e');
  }
  
  try {
    print('🔍 Test de chargement de sprites/meteor.png...');
    final data = await rootBundle.load('assets/images/sprites/meteor.png');
    print('✅ sprites/meteor.png chargé avec succès (${data.lengthInBytes} bytes)');
  } catch (e) {
    print('❌ Erreur lors du chargement de sprites/meteor.png: $e');
  }
}
EOF

echo "  📄 Fichier de test créé : $test_file"
echo "  🔄 Exécution du test..."

# Exécuter le test
if flutter run "$test_file" --debug > /tmp/asset_test.log 2>&1; then
    echo "  ✅ Test exécuté avec succès"
    echo "  📋 Résultats :"
    cat /tmp/asset_test.log | grep -E "(🔍|✅|❌)"
else
    echo "  ❌ Erreur lors de l'exécution du test"
    echo "  📋 Log d'erreur :"
    cat /tmp/asset_test.log | tail -10
fi

# Nettoyer
rm -f "$test_file"

echo ""

# ========================================
# 🎯 ANALYSE DES ERREURS
# ========================================

echo "🎯 Analyse des erreurs..."
echo "========================"
echo ""

echo "🔍 Erreurs typiques et solutions :"
echo ""
echo "1. ❌ 'assets/images/vaisseau.png' au lieu de 'sprites/vaisseau.png'"
echo "   💡 Solution : Vérifier que tous les chemins utilisent 'sprites/'"
echo ""
echo "2. ❌ Assets non déclarés dans pubspec.yaml"
echo "   💡 Solution : Ajouter 'assets/images/sprites/' dans pubspec.yaml"
echo ""
echo "3. ❌ Cache Flutter corrompu"
echo "   💡 Solution : flutter clean && flutter pub get"
echo ""
echo "4. ❌ Fichiers sprites manquants"
echo "   💡 Solution : Vérifier que les fichiers existent dans assets/images/sprites/"
echo ""

# ========================================
# 🚀 RECOMMANDATIONS
# ========================================

echo "🚀 Recommandations..."
echo "===================="
echo ""

echo "1. 🔄 Nettoyer complètement le cache :"
echo "   flutter clean && flutter pub get"
echo ""
echo "2. 🔍 Vérifier les chemins dans le code :"
echo "   Tous les chemins doivent commencer par 'sprites/'"
echo ""
echo "3. 📋 Vérifier pubspec.yaml :"
echo "   assets/images/sprites/ doit être déclaré"
echo ""
echo "4. 🧪 Tester avec un asset simple :"
echo "   Créer un test minimal pour isoler le problème"
echo ""

echo "✅ Diagnostic terminé !"
