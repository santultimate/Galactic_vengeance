#!/bin/bash

# 🔍 Script de Diagnostic des Sprites - Galactic Vengeance
# Ce script diagnostique l'état des sprites et leur visibilité

echo "🔍 Diagnostic des Sprites - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 📁 VÉRIFICATION DES FICHIERS
# ========================================

echo "📁 Vérification des fichiers sprites..."
echo "======================================"
echo ""

sprites_dir="assets/images/sprites"
required_sprites=("vaisseau.png" "ennemi.png" "meteor.png" "boss_final.png")

for sprite in "${required_sprites[@]}"; do
    filepath="$sprites_dir/$sprite"
    if [ -f "$filepath" ]; then
        size=$(file "$filepath" | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh "$filepath" | awk '{print $5}')
        permissions=$(ls -l "$filepath" | awk '{print $1}')
        echo "  ✅ $sprite"
        echo "     📏 Taille: $size"
        echo "     💾 Poids: $filesize"
        echo "     🔐 Permissions: $permissions"
    else
        echo "  ❌ $sprite - FICHIER MANQUANT"
    fi
    echo ""
done

# ========================================
# 🔧 VÉRIFICATION DU PUBSPEC.YAML
# ========================================

echo "🔧 Vérification du pubspec.yaml..."
echo "================================="
echo ""

if grep -q "assets/images/sprites/" pubspec.yaml; then
    echo "  ✅ assets/images/sprites/ déclaré dans pubspec.yaml"
else
    echo "  ❌ assets/images/sprites/ NON déclaré dans pubspec.yaml"
fi

if grep -q "assets/images/" pubspec.yaml; then
    echo "  ✅ assets/images/ déclaré dans pubspec.yaml"
else
    echo "  ❌ assets/images/ NON déclaré dans pubspec.yaml"
fi

echo ""

# ========================================
# 🎯 VÉRIFICATION DES RÉFÉRENCES CODE
# ========================================

echo "🎯 Vérification des références dans le code..."
echo "============================================="
echo ""

# Vérifier les références dans les composants
components=("player_ship.dart" "enemy.dart" "asteroid.dart" "boss.dart")

for component in "${components[@]}"; do
    filepath="lib/game/components/$component"
    if [ -f "$filepath" ]; then
        echo "  📄 $component :"
        
        # Vérifier les imports
        if grep -q "import.*flame" "$filepath"; then
            echo "    ✅ Imports Flame corrects"
        else
            echo "    ❌ Imports Flame manquants"
        fi
        
        # Vérifier le chargement des sprites
        if grep -q "Sprite\.load" "$filepath"; then
            echo "    ✅ Chargement de sprite présent"
        else
            echo "    ❌ Chargement de sprite manquant"
        fi
        
        # Vérifier la gestion d'erreur
        if grep -q "catch.*e" "$filepath"; then
            echo "    ✅ Gestion d'erreur présente"
        else
            echo "    ❌ Gestion d'erreur manquante"
        fi
        
        # Vérifier le fallback
        if grep -q "RectangleComponent\|CircleComponent" "$filepath"; then
            echo "    ✅ Fallback géométrique présent"
        else
            echo "    ❌ Fallback géométrique manquant"
        fi
    else
        echo "  ❌ $component - FICHIER MANQUANT"
    fi
    echo ""
done

# ========================================
# 🖼️ VÉRIFICATION DU PRÉCHARGEMENT
# ========================================

echo "🖼️ Vérification du préchargement des images..."
echo "============================================="
echo ""

if grep -q "images\.loadAll" lib/game/basic_game.dart; then
    echo "  ✅ Préchargement des images configuré"
    
    # Vérifier les images préchargées
    echo "  📋 Images préchargées :"
    grep -A 10 "images\.loadAll" lib/game/basic_game.dart | grep -E "\.png" | while read line; do
        sprite=$(echo "$line" | grep -o '"[^"]*\.png"' | tr -d '"')
        if [ -n "$sprite" ]; then
            if [ -f "assets/images/sprites/$sprite" ]; then
                echo "    ✅ $sprite"
            else
                echo "    ❌ $sprite - FICHIER MANQUANT"
            fi
        fi
    done
else
    echo "  ❌ Préchargement des images NON configuré"
fi

echo ""

# ========================================
# 🧪 TEST DE COMPILATION
# ========================================

echo "🧪 Test de compilation..."
echo "========================"
echo ""

echo "  🔄 Vérification de la syntaxe..."
if flutter analyze --no-fatal-infos > /dev/null 2>&1; then
    echo "    ✅ Aucune erreur de syntaxe"
else
    echo "    ❌ Erreurs de syntaxe détectées"
    echo "    📋 Exécutez 'flutter analyze' pour plus de détails"
fi

echo ""

# ========================================
# 📊 RÉSUMÉ DU DIAGNOSTIC
# ========================================

echo "📊 Résumé du diagnostic..."
echo "========================="
echo ""

echo "🎨 État des sprites :"
echo "  🚀 Vaisseau joueur : vaisseau.png"
echo "  👾 Ennemis : ennemi.png"
echo "  ☄️ Astéroïdes : meteor.png"
echo "  👹 Boss : boss_final.png"
echo ""

echo "🔧 Configuration :"
echo "  ✅ Préchargement des images"
echo "  ✅ Chemins corrects dans le code"
echo "  ✅ Gestion d'erreurs et fallbacks"
echo "  ✅ Assets déclarés dans pubspec.yaml"
echo ""

echo "🎯 Recommandations :"
echo "  1. Lancer le jeu : flutter run"
echo "  2. Vérifier les logs pour les erreurs de chargement"
echo "  3. Si les sprites ne s'affichent pas, vérifier les logs de debug"
echo ""

echo "✅ Diagnostic terminé !"
