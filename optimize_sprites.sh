#!/bin/bash

# 🎨 Script d'Optimisation des Sprites - Galactic Vengeance
# Ce script optimise les sprites pour réduire leur taille

echo "🎨 Optimisation des Sprites - Galactic Vengeance"
echo "==============================================="
echo ""

# Vérifier si ImageMagick est installé
if ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick n'est pas installé. Installation..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install imagemagick
    else
        echo "⚠️  Veuillez installer ImageMagick manuellement"
        exit 1
    fi
fi

echo "📁 Création du dossier d'optimisation..."
mkdir -p assets/images/sprites/optimized

echo ""
echo "🔧 Optimisation des sprites..."
echo ""

# Optimiser chaque sprite
sprites=("player_ship.png" "enemy_basic.png" "asteroid_medium.png" "boss_final.png")

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        echo "  🎯 Optimisation de $sprite..."
        
        # Obtenir les dimensions actuelles
        current_size=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        current_filesize=$(ls -lh assets/images/sprites/$sprite | awk '{print $5}')
        
        echo "    📐 Taille actuelle : $current_size"
        echo "    📄 Fichier actuel : $current_filesize"
        
        # Optimiser avec ImageMagick
        magick assets/images/sprites/$sprite -strip -quality 85 assets/images/sprites/optimized/$sprite
        
        # Vérifier la nouvelle taille
        new_filesize=$(ls -lh assets/images/sprites/optimized/$sprite | awk '{print $5}')
        
        echo "    ✅ Optimisé : $new_filesize"
        
        # Calculer la réduction
        if [[ "$current_filesize" == *"K"* ]]; then
            current_kb=$(echo $current_filesize | sed 's/K//')
            new_kb=$(echo $new_filesize | sed 's/K//')
            reduction=$((current_kb - new_kb))
            percentage=$((reduction * 100 / current_kb))
            echo "    📉 Réduction : ${reduction}KB (${percentage}%)"
        fi
        
        echo ""
    else
        echo "  ❌ $sprite non trouvé"
    fi
done

echo "🔄 Remplacement des sprites optimisés..."
echo ""

# Remplacer les sprites originaux par les optimisés
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/optimized/$sprite" ]; then
        echo "  🔄 Remplacement de $sprite..."
        mv assets/images/sprites/optimized/$sprite assets/images/sprites/$sprite
        echo "    ✅ Remplacé"
    fi
done

echo ""
echo "🧹 Nettoyage..."
rmdir assets/images/sprites/optimized

echo ""
echo "📊 Résumé de l'optimisation :"
echo "============================="
echo ""

# Afficher les nouvelles tailles
for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        size=$(file assets/images/sprites/$sprite | grep -o '[0-9]* x [0-9]*' | head -1)
        filesize=$(ls -lh assets/images/sprites/$sprite | awk '{print $5}')
        echo "  ✅ $sprite - Taille: $size, Fichier: $filesize"
    fi
done

echo ""
echo "🎯 Vérification des performances..."
echo "=================================="
echo ""

# Vérifier si les fichiers sont maintenant dans une taille acceptable
acceptable_count=0
total_count=0

for sprite in "${sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        total_count=$((total_count + 1))
        filesize_kb=$(ls -l assets/images/sprites/$sprite | awk '{print $5}' | sed 's/K//')
        if [ "$filesize_kb" -lt 50 ]; then
            acceptable_count=$((acceptable_count + 1))
            echo "  ✅ $sprite : $filesize_kb KB (OK)"
        else
            echo "  ⚠️  $sprite : $filesize_kb KB (Trop grand)"
        fi
    fi
done

echo ""
echo "📈 Résultats :"
echo "=============="
echo ""

if [ $acceptable_count -eq $total_count ]; then
    echo "🎉 SUCCÈS : Tous les sprites sont optimisés !"
    echo "✅ Taille acceptable pour tous les fichiers"
    echo "🚀 Prêt pour le test du jeu"
else
    echo "⚠️  ATTENTION : Certains sprites sont encore trop grands"
    echo "💡 Considérer une optimisation supplémentaire"
fi

echo ""
echo "🧪 Prochaines étapes :"
echo "====================="
echo ""

echo "1. ✅ Sprites optimisés"
echo "2. 🔄 Redémarrer le jeu : flutter run"
echo "3. 🎮 Tester les nouveaux assets"
echo "4. 📊 Vérifier les performances"

echo ""
echo "🎉 Optimisation terminée !"
echo "========================="
