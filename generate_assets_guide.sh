#!/bin/bash

# 🎨 Script de Génération d'Assets - Galactic Vengeance
# Ce script guide la génération et l'organisation des assets visuels

echo "🚀 Guide de Génération d'Assets - Galactic Vengeance"
echo "=================================================="
echo ""

# Créer la structure des dossiers
echo "📁 Création de la structure des dossiers..."
mkdir -p assets/images/sprites
mkdir -p assets/images/backgrounds
mkdir -p assets/images/effects
mkdir -p assets/images/ui
echo "✅ Structure créée !"
echo ""

# Afficher les instructions
echo "🎯 INSTRUCTIONS DE GÉNÉRATION :"
echo "================================"
echo ""
echo "1. Utilisez Stable Diffusion XL 1.0 ou SDXL Turbo"
echo "2. Paramètres recommandés :"
echo "   - Steps: 30-50"
echo "   - CFG Scale: 7-8"
echo "   - Sampler: DPM++ 2M Karras"
echo "   - Size: 512x512 (sprites), 1024x1024 (backgrounds)"
echo ""
echo "3. Post-processing requis :"
echo "   - Supprimer le background (transparence)"
echo "   - Redimensionner aux tailles finales"
echo "   - Sauvegarder en PNG"
echo ""

# Checklist des assets à générer
echo "📋 CHECKLIST DES ASSETS À GÉNÉRER :"
echo "==================================="
echo ""

echo "🚀 SPRITES (assets/images/sprites/) :"
echo "  □ player_ship.png (64x64) - Vaisseau joueur"
echo "  □ enemy_basic.png (48x48) - Ennemi basique"
echo "  □ enemy_advanced.png (48x48) - Ennemi avancé"
echo "  □ asteroid_small.png (32x32) - Petit astéroïde"
echo "  □ asteroid_medium.png (32x32) - Astéroïde moyen"
echo "  □ asteroid_large.png (32x32) - Gros astéroïde"
echo "  □ powerup_shield.png (24x24) - Power-up bouclier"
echo "  □ powerup_rapid_fire.png (24x24) - Power-up tir rapide"
echo "  □ powerup_laser.png (24x24) - Power-up laser"
echo "  □ powerup_speed.png (24x24) - Power-up vitesse"
echo "  □ boss_final.png (128x128) - Boss final"
echo ""

echo "🌌 BACKGROUNDS (assets/images/backgrounds/) :"
echo "  □ space_bg_1.png (1024x1024) - Background espace 1"
echo "  □ space_bg_2.png (1024x1024) - Background espace 2"
echo "  □ space_bg_3.png (1024x1024) - Background espace 3"
echo ""

echo "💥 EFFETS (assets/images/effects/) :"
echo "  □ explosion.png (256x256) - Explosion"
echo "  □ particles.png (256x256) - Particules"
echo "  □ laser_beam.png (256x256) - Laser beam"
echo ""

echo "🎮 UI (assets/images/ui/) :"
echo "  □ button_play.png (256x128) - Bouton play"
echo "  □ button_pause.png (256x128) - Bouton pause"
echo "  □ button_settings.png (256x128) - Bouton settings"
echo ""

# Instructions de post-processing
echo "🔧 POST-PROCESSING :"
echo "==================="
echo ""
echo "1. Supprimer le background :"
echo "   - Utilisez GIMP, Photoshop ou remove.bg"
echo "   - Rendez le background transparent"
echo ""
echo "2. Redimensionner :"
echo "   - Sprites : 64x64, 48x48, 32x32, 24x24"
echo "   - Backgrounds : 1024x1024"
echo "   - Effets : 256x256"
echo "   - UI : 256x128"
echo ""
echo "3. Optimiser :"
echo "   - Format PNG avec transparence"
echo "   - Compression optimale"
echo "   - Palette de couleurs cohérente"
echo ""

# Instructions d'intégration
echo "🎯 INTÉGRATION DANS LE JEU :"
echo "============================"
echo ""
echo "1. Ajouter dans pubspec.yaml :"
echo "   flutter:"
echo "     assets:"
echo "       - assets/images/sprites/"
echo "       - assets/images/backgrounds/"
echo "       - assets/images/effects/"
echo "       - assets/images/ui/"
echo ""
echo "2. Tester dans le jeu :"
echo "   - Vérifier l'affichage"
echo "   - Tester les performances"
echo "   - Ajuster si nécessaire"
echo ""

echo "🎉 BONNE GÉNÉRATION !"
echo "====================="
echo ""
echo "💡 Conseils :"
echo "- Générez plusieurs variantes pour chaque asset"
echo "- Testez dans le jeu avant de finaliser"
echo "- Gardez une palette de couleurs cohérente"
echo "- Optimisez pour les performances"
echo ""
echo "🚀 Prêt à créer des assets de qualité professionnelle !"
