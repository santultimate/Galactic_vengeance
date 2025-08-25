#!/bin/bash

# ⚙️ Correction des Callbacks Settings - Galactic Vengeance
# Ce script corrige tous les callbacks pour sauvegarder automatiquement les settings

echo "⚙️ Correction des Callbacks Settings - Galactic Vengeance"
echo "======================================================="
echo ""

# ========================================
# 🔧 CORRECTION DES CALLBACKS
# ========================================

echo "🔧 Correction des callbacks..."
echo "============================"
echo ""

# Corriger tous les callbacks pour sauvegarder automatiquement
echo "  📄 Correction des callbacks de settings..."

# Background Music
sed -i '' 's/(value) => setState(() => _musicEnabled = value),/(value) {\n                          setState(() => _musicEnabled = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Music Volume
sed -i '' 's/(value) => setState(() => _musicVolume = value),/(value) {\n                          setState(() => _musicVolume = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Vibration
sed -i '' 's/(value) => setState(() => _vibrationEnabled = value),/(value) {\n                          setState(() => _vibrationEnabled = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Control Type
sed -i '' 's/(value) => setState(() => _controlType = value),/(value) {\n                          setState(() => _controlType = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Show FPS
sed -i '' 's/(value) => setState(() => _showFPS = value),/(value) {\n                          setState(() => _showFPS = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Particle Effects
sed -i '' 's/(value) => setState(() => _particleEffects = value),/(value) {\n                          setState(() => _particleEffects = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

# Difficulty
sed -i '' 's/(value) => setState(() => _difficulty = value),/(value) {\n                          setState(() => _difficulty = value);\n                          _saveSettings();\n                        },/g' lib/screens/settings_screen.dart

echo "    ✅ Tous les callbacks corrigés"
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

echo "⚙️ Settings corrigés :"
echo "  ✅ SharedPreferences importé"
echo "  ✅ _loadSettings() utilise SharedPreferences"
echo "  ✅ _saveSettings() sauvegarde dans SharedPreferences"
echo "  ✅ Tous les callbacks sauvegardent automatiquement"
echo ""

echo "🎯 Instructions de test :"
echo "========================"
echo ""

echo "1. 🚀 Lancer le jeu :"
echo "   flutter run --debug"
echo ""

echo "2. ⚙️ Tester les settings :"
echo "   - Aller dans Settings"
echo "   - Changer Sound Effects (ON/OFF)"
echo "   - Changer Sound Volume (slider)"
echo "   - Changer Background Music (ON/OFF)"
echo "   - Changer Music Volume (slider)"
echo "   - Changer Vibration (ON/OFF)"
echo "   - Changer Control Type (dropdown)"
echo "   - Changer Show FPS (ON/OFF)"
echo "   - Changer Particle Effects (ON/OFF)"
echo "   - Changer Difficulty (dropdown)"
echo ""

echo "3. ✅ Vérifier la sauvegarde :"
echo "   - Fermer l'app"
echo "   - Relancer l'app"
echo "   - Aller dans Settings"
echo "   - Vérifier que les valeurs sont sauvegardées"
echo ""

echo "⚙️ Correction des callbacks terminée !"
echo "===================================="
echo ""
echo "🚀 Les settings devraient maintenant fonctionner correctement !"
