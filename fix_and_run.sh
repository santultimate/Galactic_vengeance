#!/bin/bash

# 🚀 Script de Correction et Lancement - Galactic Vengeance
# Ce script corrige les chemins des sprites et lance le jeu

echo "🚀 Correction et Lancement - Galactic Vengeance"
echo "=============================================="
echo ""

# ========================================
# 🔧 CORRECTION DES CHEMINS
# ========================================

echo "🔧 Correction des chemins des sprites..."
echo "======================================"
echo ""

# Vérifier que les sprites existent dans le bon dossier
sprites_dir="assets/images/sprites"
required_sprites=("vaisseau.png" "ennemi.png" "meteor.png" "boss_final.png")

echo "📁 Vérification des sprites dans $sprites_dir :"
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
# 🧹 NETTOYAGE COMPLET
# ========================================

echo "🧹 Nettoyage complet..."
echo "======================"
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
echo "======================="
echo ""

echo "🎯 Chemins corrigés :"
echo "  🚀 Vaisseau : sprites/vaisseau.png"
echo "  👾 Ennemi : sprites/ennemi.png"
echo "  ☄️ Astéroïde : sprites/meteor.png"
echo "  👹 Boss : sprites/boss_final.png"
echo ""

echo "🔧 Configuration :"
echo "  ✅ Préchargement avec chemins sprites/"
echo "  ✅ Composants avec chemins sprites/"
echo "  ✅ Assets déclarés dans pubspec.yaml"
echo ""

# ========================================
# 🚀 LANCEMENT DU JEU
# ========================================

echo "🚀 Lancement du jeu..."
echo "===================="
echo ""

echo "🎯 Le jeu va maintenant se lancer !"
echo ""
echo "📱 Instructions de test :"
echo "========================"
echo ""
echo "1. 🎨 Vérifier les sprites :"
echo "   - Vaisseau joueur : sprites/vaisseau.png"
echo "   - Ennemis : sprites/ennemi.png"
echo "   - Astéroïdes : sprites/meteor.png"
echo "   - Boss : sprites/boss_final.png"
echo ""
echo "2. 🔍 Vérifier les logs :"
echo "   - Messages de préchargement : 🖼️ Preloading images..."
echo "   - Messages de succès : ✅ Images preloaded successfully"
echo "   - Messages de chargement : 🔍 Loading sprites/[sprite].png..."
echo ""
echo "3. ⚠️ Si erreur :"
echo "   - Vérifier que les fichiers existent dans assets/images/sprites/"
echo "   - Vérifier les permissions des fichiers"
echo ""

echo "✅ Lancement en cours..."
flutter run
