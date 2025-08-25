#!/bin/bash

# 🔍 Script de Diagnostic des Assets - Galactic Vengeance
# Ce script diagnostique pourquoi les assets ne s'appliquent pas

echo "🔍 Diagnostic des Assets - Galactic Vengeance"
echo "============================================="
echo ""

# Vérifier la structure des dossiers
echo "📁 Vérification de la structure..."
if [ -d "assets/images/sprites" ]; then
    echo "  ✅ Dossier sprites existe"
else
    echo "  ❌ Dossier sprites manquant"
    exit 1
fi

echo ""

# Vérifier les fichiers de sprites
echo "🎨 Vérification des fichiers de sprites..."
echo ""

sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png" "boss_final.png")
missing_sprites=()

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh assets/images/sprites/$sprite | awk '{print $5}')
        echo "  ✅ $sprite - Taille: $size, Fichier: $filesize"
    else
        echo "  ❌ $sprite manquant"
        missing_sprites+=("$sprite")
    fi
done

echo ""

# Vérifier pubspec.yaml
echo "📋 Vérification de pubspec.yaml..."
if grep -q "assets/images/" pubspec.yaml; then
    echo "  ✅ Assets déclarés dans pubspec.yaml"
    echo "  📄 Ligne trouvée :"
    grep "assets/images/" pubspec.yaml
else
    echo "  ❌ Assets non déclarés dans pubspec.yaml"
fi

echo ""

# Vérifier les permissions
echo "🔐 Vérification des permissions..."
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        permissions=$(ls -l assets/images/sprites/$sprite | awk '{print $1}')
        echo "  📄 $sprite : $permissions"
    fi
done

echo ""

# Vérifier le format des images
echo "🖼️ Vérification du format des images..."
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        format=$(file assets/images/sprites/$sprite | grep -o 'PNG image data')
        if [ "$format" = "PNG image data" ]; then
            echo "  ✅ $sprite : Format PNG valide"
        else
            echo "  ❌ $sprite : Format invalide"
        fi
    fi
done

echo ""

# Vérifier les dimensions
echo "📏 Vérification des dimensions..."
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        dimensions=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        echo "  📐 $sprite : $dimensions"
    fi
done

echo ""

# Vérifier le code
echo "💻 Vérification du code..."
echo ""

# Vérifier PlayerShip
if grep -q "player_ship.png" lib/game/components/player_ship.dart; then
    echo "  ✅ PlayerShip utilise player_ship.png"
else
    echo "  ❌ PlayerShip n'utilise pas player_ship.png"
fi

# Vérifier Enemy
if grep -q "enemy_basic.png" lib/game/components/enemy.dart; then
    echo "  ✅ Enemy utilise enemy_basic.png"
else
    echo "  ❌ Enemy n'utilise pas enemy_basic.png"
fi

# Vérifier Asteroid
if grep -q "asteroid_medium.png" lib/game/components/asteroid.dart; then
    echo "  ✅ Asteroid utilise asteroid_medium.png"
else
    echo "  ❌ Asteroid n'utilise pas asteroid_medium.png"
fi

# Vérifier Boss
if grep -q "boss_final.png" lib/game/components/boss.dart; then
    echo "  ✅ Boss utilise boss_final.png"
else
    echo "  ❌ Boss n'utilise pas boss_final.png"
fi

echo ""

# Vérifier les imports
echo "📚 Vérification des imports..."
echo ""

if grep -q "import.*flame.*components" lib/game/components/player_ship.dart; then
    echo "  ✅ PlayerShip : Import Flame components"
else
    echo "  ❌ PlayerShip : Import Flame components manquant"
fi

if grep -q "import.*flame.*components" lib/game/components/enemy.dart; then
    echo "  ✅ Enemy : Import Flame components"
else
    echo "  ❌ Enemy : Import Flame components manquant"
fi

if grep -q "import.*flame.*components" lib/game/components/asteroid.dart; then
    echo "  ✅ Asteroid : Import Flame components"
else
    echo "  ❌ Asteroid : Import Flame components manquant"
fi

if grep -q "import.*flame.*components" lib/game/components/boss.dart; then
    echo "  ✅ Boss : Import Flame components"
else
    echo "  ❌ Boss : Import Flame components manquant"
fi

echo ""

# Diagnostic des problèmes potentiels
echo "🔍 Diagnostic des problèmes potentiels..."
echo ""

if [ ${#missing_sprites[@]} -gt 0 ]; then
    echo "  ❌ PROBLÈME : Sprites manquants :"
    for sprite in "${missing_sprites[@]}"; do
        echo "    - $sprite"
    done
    echo "  💡 SOLUTION : Régénérer les sprites manquants"
fi

# Vérifier si les fichiers sont trop grands
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        filesize_kb=$(ls -l assets/images/sprites/$sprite | awk '{print $5}' | sed 's/K//')
        if [ "$filesize_kb" -gt 50 ]; then
            echo "  ⚠️  ATTENTION : $sprite est trop grand ($filesize_kb KB)"
            echo "  💡 SOLUTION : Optimiser la taille du fichier"
        fi
    fi
done

echo ""

# Recommandations
echo "💡 Recommandations :"
echo "==================="
echo ""

echo "1. Si les sprites ne s'affichent pas :"
echo "   - Vérifier les logs Flutter pour les erreurs de chargement"
echo "   - S'assurer que les fichiers sont au format PNG valide"
echo "   - Vérifier que les dimensions sont correctes"
echo ""

echo "2. Si les sprites sont trop grands :"
echo "   - Optimiser la taille des fichiers (< 50KB)"
echo "   - Redimensionner les images si nécessaire"
echo ""

echo "3. Si le code ne fonctionne pas :"
echo "   - Vérifier les imports Flame"
echo "   - S'assurer que les noms de fichiers correspondent"
echo "   - Vérifier la syntaxe du code"
echo ""

echo "4. Actions recommandées :"
echo "   - Exécuter 'flutter clean && flutter pub get'"
echo "   - Redémarrer le jeu avec 'flutter run'"
echo "   - Vérifier les logs de débogage"
echo ""

echo "🎯 Prochaines étapes :"
echo "====================="
echo ""

if [ ${#missing_sprites[@]} -eq 0 ]; then
    echo "✅ Tous les sprites sont présents"
    echo "🔧 Vérifier les logs Flutter pour les erreurs de chargement"
    echo "🧪 Tester le jeu avec 'flutter run'"
else
    echo "❌ Sprites manquants détectés"
    echo "🔄 Régénérer les sprites manquants"
    echo "🧪 Retester après régénération"
fi

echo ""
echo "🎉 Diagnostic terminé !"
echo "======================="
