#!/bin/bash

# Script de validation des assets
echo "🔍 Validation des assets..."

# Vérifier les sprites requis
echo "📋 Vérification des sprites..."
required_sprites=(
    "player_ship.png"
    "enemy_basic.png"
    "enemy_advanced.png"
    "enemy_elite.png"
    "asteroid_small.png"
    "asteroid_medium.png"
    "asteroid_large.png"
    "powerup_shield.png"
    "powerup_rapid_fire.png"
    "powerup_laser.png"
    "powerup_speed.png"
    "powerup_magnet.png"
    "boss_basic.png"
    "boss_advanced.png"
    "boss_elite.png"
    "boss_final.png"
)

for sprite in "${required_sprites[@]}"; do
    if [ -f "assets/images/sprites/$sprite" ]; then
        echo "✅ $sprite"
    else
        echo "❌ $sprite - MANQUANT"
    fi
done

# Vérifier les backgrounds
echo "📋 Vérification des backgrounds..."
for i in {1..3}; do
    if [ -f "assets/images/backgrounds/space_bg_$i.png" ]; then
        echo "✅ space_bg_$i.png"
    else
        echo "❌ space_bg_$i.png - MANQUANT"
    fi
done

# Vérifier les effets
echo "📋 Vérification des effets..."
required_effects=(
    "explosion.png"
    "particles.png"
    "laser_beam.png"
)

for effect in "${required_effects[@]}"; do
    if [ -f "assets/images/effects/$effect" ]; then
        echo "✅ $effect"
    else
        echo "❌ $effect - MANQUANT"
    fi
done

echo "🎯 Validation terminée !"
