#!/bin/bash

# Script pour créer la structure des assets visuels pour Galactic Vengeance
# Usage: ./setup_assets_structure.sh

echo "🎨 Configuration de la structure des assets pour Galactic Vengeance"
echo "================================================================"

# Créer les dossiers principaux
echo "📁 Création des dossiers..."
mkdir -p assets/images/sprites
mkdir -p assets/images/backgrounds
mkdir -p assets/images/effects
mkdir -p assets/images/ui/icons

# Créer les fichiers README pour chaque dossier
echo "📝 Création des fichiers README..."

# README pour sprites
cat > assets/images/sprites/README.md << 'EOF'
# Sprites - Galactic Vengeance

## Fichiers Requis

### Vaisseau Joueur
- `player_ship.png` (64x64) - Vaisseau principal du joueur

### Ennemis
- `enemy_basic.png` (48x48) - Ennemi basique
- `enemy_advanced.png` (48x48) - Ennemi avancé
- `enemy_elite.png` (48x48) - Ennemi d'élite

### Astéroïdes
- `asteroid_small.png` (32x32) - Petit astéroïde
- `asteroid_medium.png` (32x32) - Astéroïde moyen
- `asteroid_large.png` (48x48) - Gros astéroïde

### Power-ups
- `powerup_shield.png` (24x24) - Bouclier
- `powerup_rapid_fire.png` (24x24) - Tir rapide
- `powerup_laser.png` (24x24) - Laser
- `powerup_speed.png` (24x24) - Vitesse
- `powerup_magnet.png` (24x24) - Aimant

### Boss
- `boss_basic.png` (128x128) - Boss basique
- `boss_advanced.png` (128x128) - Boss avancé
- `boss_elite.png` (128x128) - Boss d'élite
- `boss_final.png` (128x128) - Boss final

## Spécifications
- Format: PNG avec fond transparent
- Style: Pixel art 8-bit rétro
- Palette: Couleurs vives et néon
EOF

# README pour backgrounds
cat > assets/images/backgrounds/README.md << 'EOF'
# Backgrounds - Galactic Vengeance

## Fichiers Requis

### Backgrounds Spatiaux
- `space_bg_1.png` (1024x1024) - Background bleu/violet
- `space_bg_2.png` (1024x1024) - Background vert/cyan
- `space_bg_3.png` (1024x1024) - Background rouge/orange

## Spécifications
- Format: PNG
- Style: Pixel art spatial rétro
- Contenu: Nébuleuses, étoiles, poussière cosmique
- Palette: Couleurs spatiales vibrantes
EOF

# README pour effects
cat > assets/images/effects/README.md << 'EOF'
# Effets Visuels - Galactic Vengeance

## Fichiers Requis

### Explosions
- `explosion.png` (64x64) - Explosion principale

### Particules
- `particles.png` (16x16) - Particules d'énergie

### Armes
- `laser_beam.png` (32x128) - Rayon laser

## Spécifications
- Format: PNG avec fond transparent
- Style: Pixel art 8-bit rétro
- Palette: Couleurs vives et lumineuses
EOF

# README pour UI
cat > assets/images/ui/README.md << 'EOF'
# Interface Utilisateur - Galactic Vengeance

## Fichiers Requis

### Boutons
- `button.png` (128x64) - Bouton principal

### Icônes (dossier icons/)
- `icon_play.png` (32x32) - Icône jouer
- `icon_pause.png` (32x32) - Icône pause
- `icon_settings.png` (32x32) - Icône paramètres
- `icon_shop.png` (32x32) - Icône boutique

## Spécifications
- Format: PNG avec fond transparent
- Style: Pixel art 8-bit rétro
- Palette: Couleurs néon et cyberpunk
EOF

# Créer un fichier de configuration pour les tailles
cat > assets/images/sizes_config.txt << 'EOF'
# Configuration des tailles d'images pour Galactic Vengeance

## Sprites
player_ship: 64x64
enemy_basic: 48x48
enemy_advanced: 48x48
enemy_elite: 48x48
asteroid_small: 32x32
asteroid_medium: 32x32
asteroid_large: 48x48
powerup_shield: 24x24
powerup_rapid_fire: 24x24
powerup_laser: 24x24
powerup_speed: 24x24
powerup_magnet: 24x24
boss_basic: 128x128
boss_advanced: 128x128
boss_elite: 128x128
boss_final: 128x128

## Backgrounds
space_bg_1: 1024x1024
space_bg_2: 1024x1024
space_bg_3: 1024x1024

## Effects
explosion: 64x64
particles: 16x16
laser_beam: 32x128

## UI
button: 128x64
icon_play: 32x32
icon_pause: 32x32
icon_settings: 32x32
icon_shop: 32x32
EOF

# Créer un script de validation
cat > validate_assets.sh << 'EOF'
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
EOF

chmod +x validate_assets.sh

echo "✅ Structure des assets créée avec succès !"
echo ""
echo "📁 Dossiers créés :"
echo "  - assets/images/sprites/"
echo "  - assets/images/backgrounds/"
echo "  - assets/images/effects/"
echo "  - assets/images/ui/icons/"
echo ""
echo "📝 Fichiers créés :"
echo "  - README.md dans chaque dossier"
echo "  - sizes_config.txt (configuration des tailles)"
echo "  - validate_assets.sh (script de validation)"
echo ""
echo "🎨 Prochaines étapes :"
echo "  1. Utiliser les prompts Stable Diffusion du fichier STABLE_DIFFUSION_PROMPTS.md"
echo "  2. Générer les images avec les tailles spécifiées"
echo "  3. Supprimer les backgrounds et optimiser"
echo "  4. Placer les fichiers dans les bons dossiers"
echo "  5. Exécuter ./validate_assets.sh pour vérifier"
echo ""
echo "🚀 Bonne génération d'assets !"
