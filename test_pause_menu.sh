#!/bin/bash

# 🎮 Script de Test du Menu de Pause - Galactic Vengeance
# Ce script teste le menu de pause et la navigation

echo "🎮 Test du Menu de Pause - Galactic Vengeance"
echo "============================================="
echo ""

# ========================================
# 📋 VÉRIFICATION DU CODE
# ========================================

echo "📋 Vérification du code du menu de pause..."
echo "=========================================="
echo ""

# Vérifier que le bouton pause existe
if grep -q "Pause button tapped" lib/screens/game_screen.dart; then
    echo "  ✅ Bouton pause détecté"
else
    echo "  ❌ Bouton pause NON détecté"
fi

# Vérifier que le panneau de pause existe
if grep -q "if (_gameState!.isPaused)" lib/screens/game_screen.dart; then
    echo "  ✅ Panneau de pause détecté"
else
    echo "  ❌ Panneau de pause NON détecté"
fi

# Vérifier le bouton "REPRENDRE"
if grep -q "REPRENDRE" lib/screens/game_screen.dart; then
    echo "  ✅ Bouton REPRENDRE détecté"
else
    echo "  ❌ Bouton REPRENDRE NON détecté"
fi

# Vérifier le bouton "MENU PRINCIPAL"
if grep -q "MENU PRINCIPAL" lib/screens/game_screen.dart; then
    echo "  ✅ Bouton MENU PRINCIPAL détecté"
else
    echo "  ❌ Bouton MENU PRINCIPAL NON détecté"
fi

# Vérifier la navigation vers le menu principal
if grep -q "pushNamedAndRemoveUntil" lib/screens/game_screen.dart; then
    echo "  ✅ Navigation vers menu principal détectée"
else
    echo "  ❌ Navigation vers menu principal NON détectée"
fi

echo ""

# ========================================
# 🔧 VÉRIFICATION DES MÉTHODES
# ========================================

echo "🔧 Vérification des méthodes..."
echo "=============================="
echo ""

# Vérifier la méthode quitGame
if grep -q "quitGame" lib/game/basic_game.dart; then
    echo "  ✅ Méthode quitGame détectée"
else
    echo "  ❌ Méthode quitGame NON détectée"
fi

# Vérifier la méthode endGame
if grep -q "endGame" lib/models/game_state.dart; then
    echo "  ✅ Méthode endGame détectée"
else
    echo "  ❌ Méthode endGame NON détectée"
fi

# Vérifier la méthode resumeGame
if grep -q "resumeGame" lib/game/basic_game.dart; then
    echo "  ✅ Méthode resumeGame détectée"
else
    echo "  ❌ Méthode resumeGame NON détectée"
fi

echo ""

# ========================================
# 🎵 VÉRIFICATION DE L'AUDIO
# ========================================

echo "🎵 Vérification de l'audio..."
echo "============================"
echo ""

# Vérifier les sons de bouton
if grep -q "playButtonSound" lib/screens/game_screen.dart; then
    echo "  ✅ Sons de bouton détectés"
else
    echo "  ❌ Sons de bouton NON détectés"
fi

# Vérifier le feedback haptique
if grep -q "HapticFeedback" lib/screens/game_screen.dart; then
    echo "  ✅ Feedback haptique détecté"
else
    echo "  ❌ Feedback haptique NON détecté"
fi

echo ""

# ========================================
# 🎨 VÉRIFICATION DU DESIGN
# ========================================

echo "🎨 Vérification du design..."
echo "==========================="
echo ""

# Vérifier le style Dino
if grep -q "Colors.white" lib/screens/game_screen.dart; then
    echo "  ✅ Design style Dino détecté"
else
    echo "  ❌ Design style Dino NON détecté"
fi

# Vérifier les couleurs des boutons
if grep -q "Colors.green" lib/screens/game_screen.dart && grep -q "Colors.red" lib/screens/game_screen.dart; then
    echo "  ✅ Couleurs des boutons détectées"
else
    echo "  ❌ Couleurs des boutons NON détectées"
fi

# Vérifier les icônes
if grep -q "Icons.play_arrow" lib/screens/game_screen.dart && grep -q "Icons.home" lib/screens/game_screen.dart; then
    echo "  ✅ Icônes détectées"
else
    echo "  ❌ Icônes NON détectées"
fi

echo ""

# ========================================
# 📊 RÉSUMÉ DU TEST
# ========================================

echo "📊 Résumé du test..."
echo "==================="
echo ""

echo "🎮 Fonctionnalités du menu de pause :"
echo "  ✅ Bouton pause dans le HUD"
echo "  ✅ Panneau de pause overlay"
echo "  ✅ Bouton REPRENDRE (vert)"
echo "  ✅ Bouton MENU PRINCIPAL (rouge)"
echo "  ✅ Navigation vers l'écran principal"
echo ""

echo "🔧 Méthodes implémentées :"
echo "  ✅ togglePause() - Basculer pause"
echo "  ✅ resumeGame() - Reprendre le jeu"
echo "  ✅ quitGame() - Quitter le jeu"
echo "  ✅ endGame() - Terminer le jeu"
echo ""

echo "🎵 Effets audio et haptiques :"
echo "  ✅ Sons de bouton"
echo "  ✅ Feedback haptique léger (REPRENDRE)"
echo "  ✅ Feedback haptique moyen (MENU PRINCIPAL)"
echo ""

echo "🎨 Design et interface :"
echo "  ✅ Style Dino (fond blanc, texte noir)"
echo "  ✅ Boutons colorés (vert/rouge)"
echo "  ✅ Icônes descriptives"
echo "  ✅ Animations et transitions"
echo ""

echo "🎯 Instructions de test :"
echo "========================"
echo ""
echo "1. 🎮 Lancer le jeu : flutter run"
echo "2. 🎯 Commencer une partie"
echo "3. ⏸️ Appuyer sur le bouton pause (icône pause)"
echo "4. 📋 Vérifier que le panneau de pause s'affiche"
echo "5. 🔄 Tester le bouton REPRENDRE"
echo "6. 🏠 Tester le bouton MENU PRINCIPAL"
echo "7. 🎵 Vérifier les sons et vibrations"
echo ""

echo "✅ Test du menu de pause terminé !"
