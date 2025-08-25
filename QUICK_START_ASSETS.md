# 🚀 Guide de Démarrage Rapide - Assets Galactic Vengeance

## 🎯 **Assets Prioritaires (Commencez par ceux-ci)**

### **1. VAISSEAU JOUEUR** (Le plus important !)
```
pixel art spaceship, top-down view, player ship, sci-fi fighter, green and blue color scheme, sleek design, triangular shape, glowing engines, weapon turrets, 64x64 resolution, retro gaming style, arcade shooter, clean lines, sharp edges, transparent background, centered composition, high contrast, neon glow effects, space combat ready, detailed pixel art, 8-bit aesthetic
```

**Paramètres** :
- Taille : 512x512 (redimensionner à 64x64 après)
- Steps : 40
- CFG : 8
- Modèle : Stable Diffusion XL 1.0

---

### **2. ENNEMI BASIQUE** (Pour tester les collisions)
```
pixel art enemy spaceship, top-down view, red triangular fighter, sci-fi enemy, aggressive design, sharp angles, dark red and black color scheme, weapon pods, 48x48 resolution, retro gaming style, arcade shooter, menacing appearance, glowing red eyes, transparent background, centered composition, high contrast, space combat enemy, detailed pixel art, 8-bit aesthetic, simple but recognizable
```

**Paramètres** :
- Taille : 512x512 (redimensionner à 48x48 après)
- Steps : 40
- CFG : 8

---

### **3. ASTÉROÏDE MOYEN** (Pour les obstacles)
```
pixel art asteroid, space rock, brown and gray color scheme, irregular shape, rough surface, crater details, 32x32 resolution, retro gaming style, arcade shooter, natural space object, transparent background, centered composition, high contrast, space debris, detailed pixel art, 8-bit aesthetic, simple geometric shapes, jagged edges
```

**Paramètres** :
- Taille : 512x512 (redimensionner à 32x32 après)
- Steps : 35
- CFG : 7

---

### **4. BACKGROUND SPATIAL** (Pour l'ambiance)
```
pixel art space background, starfield, nebula, cosmic clouds, deep space, blue and purple nebula, sparse starfield, 1024x1024 resolution, retro gaming style, arcade shooter, transparent background, centered composition, high contrast, space environment, detailed pixel art, 8-bit aesthetic, colorful nebula, distant stars, space dust, cosmic atmosphere
```

**Paramètres** :
- Taille : 1024x1024
- Steps : 50
- CFG : 8

---

## 🔧 **Workflow Recommandé**

### **Étape 1 : Test avec le Vaisseau Joueur**
1. Copiez le prompt du vaisseau joueur
2. Générez 3-4 variations
3. Choisissez la meilleure
4. Supprimez le background
5. Redimensionnez à 64x64
6. Testez dans le jeu

### **Étape 2 : Validation du Style**
Si le vaisseau joueur vous plaît :
- Continuez avec les autres sprites
- Gardez les mêmes paramètres
- Ajustez seulement les couleurs

### **Étape 3 : Génération en Lot**
Une fois le style validé, générez tous les autres assets.

---

## 🎨 **Palette de Couleurs Recommandée**

### **Vaisseau Joueur**
- Principal : Vert (#00FF00)
- Secondaire : Bleu (#0080FF)
- Accents : Blanc (#FFFFFF)

### **Ennemis**
- Principal : Rouge (#FF0000)
- Secondaire : Noir (#000000)
- Accents : Rouge foncé (#800000)

### **Astéroïdes**
- Principal : Brun (#8B4513)
- Secondaire : Gris (#808080)
- Accents : Brun foncé (#654321)

### **Power-ups**
- Bouclier : Bleu (#0000FF)
- Tir rapide : Rouge (#FF0000)
- Laser : Cyan (#00FFFF)
- Vitesse : Vert (#00FF00)
- Aimant : Violet (#8000FF)

---

## ⚡ **Prompts Rapides par Catégorie**

### **Power-ups (24x24)**
```
pixel art power-up, floating energy orb, [COULEUR] color, glowing effect, 24x24 resolution, retro gaming style, arcade shooter, transparent background, centered composition, high contrast, space item, detailed pixel art, 8-bit aesthetic, simple geometric shape, bright colors, energy effects
```

### **Boss (128x128)**
```
pixel art boss spaceship, massive enemy, top-down view, sci-fi boss, intimidating design, complex structure, multiple weapon systems, 128x128 resolution, retro gaming style, arcade shooter, transparent background, centered composition, high contrast, space combat boss, detailed pixel art, 8-bit aesthetic, menacing appearance, glowing weapon ports, shield effects
```

### **Effets (64x64)**
```
pixel art explosion, fire and smoke, bright orange and yellow, 64x64 resolution, retro gaming style, arcade shooter, transparent background, centered composition, high contrast, space explosion, detailed pixel art, 8-bit aesthetic, expanding fireball, smoke particles
```

---

## 🛠️ **Outils de Post-Processing**

### **Suppression de Background**
- **En ligne** : remove.bg
- **Logiciel** : GIMP (gratuit)
- **Commandes** : ImageMagick

### **Redimensionnement**
```bash
# Avec ImageMagick
magick input.png -resize 64x64 output.png
```

### **Optimisation**
- **En ligne** : TinyPNG
- **Logiciel** : ImageOptim (Mac)

---

## 📋 **Checklist de Validation**

### **Avant Intégration**
- [ ] Fond transparent
- [ ] Taille correcte
- [ ] Style cohérent
- [ ] Couleurs appropriées
- [ ] Qualité suffisante

### **Après Intégration**
- [ ] Visible dans le jeu
- [ ] Pas de problèmes de performance
- [ ] Collisions correctes
- [ ] Animation fluide

---

## 🎯 **Conseils Pro**

### **Pour de Meilleurs Résultats**
1. **Commencez petit** : Testez avec un sprite avant de tout générer
2. **Générez plusieurs variations** : Choisissez la meilleure
3. **Gardez la cohérence** : Même style pour tous les assets
4. **Optimisez les tailles** : Plus petit = meilleure performance
5. **Testez régulièrement** : Intégrez au fur et à mesure

### **Évitez**
- Les détails trop complexes
- Les couleurs trop sombres
- Les tailles trop grandes
- Les styles réalistes
- Les backgrounds colorés

---

## 🚀 **Prochaines Étapes**

1. **Générez le vaisseau joueur** (priorité absolue)
2. **Testez dans le jeu**
3. **Ajustez le style si nécessaire**
4. **Générez les autres sprites**
5. **Ajoutez les backgrounds**
6. **Intégrez les effets**

**💡 Rappel** : La qualité est plus importante que la quantité. Prenez le temps de bien faire chaque asset !

---

**🎮 Bon développement !**
