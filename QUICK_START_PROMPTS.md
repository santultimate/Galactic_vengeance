# 🚀 Prompts Rapides - Démarrage Immédiat

## 🎯 **Configuration de Base**
```
Model: Stable Diffusion XL 1.0
Steps: 40
CFG Scale: 7.5
Sampler: DPM++ 2M Karras
Size: 512x512 (sprites), 1024x1024 (backgrounds)
```

## 🚀 **1. VAISSEAU JOUEUR (Priorité 1)**

### **Prompt Positif**
```
masterpiece, best quality, ultra detailed, pixel art style, 8-bit game sprite, spaceship, fighter jet, sleek design, metallic blue and silver, glowing engine trails, futuristic cockpit, sharp angles, aerodynamic shape, top-down view, centered composition, clean lines, vibrant colors, game asset, transparent background, isolated on transparent background, high contrast, bold outlines, retro gaming aesthetic, sci-fi spaceship design, military grade, advanced technology, smooth surfaces, reflective metal, energy core visible, weapon systems integrated, navigation lights, thrusters, space combat ready
```

### **Prompt Négatif**
```
blurry, low quality, realistic, photographic, 3d render, complex background, text, watermark, signature, noise, grain, dark, shadow, realistic lighting, human, face, hands, organic, natural, earth, clouds, sky, buildings, landscape, photorealistic, detailed background, busy composition, multiple objects, cluttered, messy, dirty, worn, damaged, broken, cartoon, anime, hand drawn, sketch, painting, oil painting, watercolor, abstract, modern art, contemporary, minimalist, simple, plain, boring, dull, monochrome, black and white, grayscale
```

**Taille finale** : 64x64 pixels

---

## 👾 **2. ENNEMI BASIQUE (Priorité 2)**

### **Prompt Positif**
```
masterpiece, best quality, ultra detailed, pixel art style, 8-bit game sprite, alien spaceship, enemy fighter, aggressive design, red and black color scheme, sharp spikes, menacing appearance, triangular shape, top-down view, centered composition, clean lines, vibrant colors, game asset, transparent background, isolated on transparent background, high contrast, bold outlines, retro gaming aesthetic, hostile alien craft, weapon pods, energy shields, dark metallic finish, angular design, threat indicators, combat ready, space invader style, classic arcade enemy
```

**Taille finale** : 48x48 pixels

---

## ☄️ **3. ASTÉROÏDE (Priorité 3)**

### **Prompt Positif**
```
masterpiece, best quality, ultra detailed, pixel art style, 8-bit game sprite, asteroid, space rock, irregular shape, brown and gray, cratered surface, rough texture, floating debris, top-down view, centered composition, clean lines, vibrant colors, game asset, transparent background, isolated on transparent background, high contrast, bold outlines, retro gaming aesthetic, space debris, meteor, cosmic rock, natural formation, jagged edges, weathered surface, space environment, celestial body, orbital debris, collision hazard
```

**Taille finale** : 32x32 pixels

---

## ⚡ **4. POWER-UP BOUCLIER (Priorité 4)**

### **Prompt Positif**
```
masterpiece, best quality, ultra detailed, pixel art style, 8-bit game sprite, shield power-up, energy shield, blue glowing orb, protective barrier, hexagonal design, energy field, top-down view, centered composition, clean lines, vibrant colors, game asset, transparent background, isolated on transparent background, high contrast, bold outlines, retro gaming aesthetic, defensive item, protective power, energy core, shield generator, defensive technology, power-up item, collectible, game enhancement, protective aura, energy shield
```

**Taille finale** : 24x24 pixels

---

## 🌌 **5. BACKGROUND ESPACE (Priorité 5)**

### **Prompt Positif**
```
masterpiece, best quality, ultra detailed, space background, starfield, nebula, cosmic clouds, deep space, distant stars, colorful nebula, space environment, cosmic dust, stellar nursery, interstellar medium, space scene, cosmic landscape, stellar background, space vista, cosmic panorama, interstellar space, deep space environment, cosmic atmosphere, space setting, stellar environment, cosmic backdrop, space landscape, interstellar vista, cosmic scene, space panorama, stellar vista, cosmic environment
```

**Taille finale** : 1024x1024 pixels

---

## 🔧 **Post-Processing Rapide**

### **Étapes Essentielles**
1. **Supprimer le background** : Utilisez remove.bg ou GIMP
2. **Redimensionner** : Aux tailles finales spécifiées
3. **Sauvegarder** : Format PNG avec transparence

### **Outils Recommandés**
- **remove.bg** : Suppression automatique du background
- **GIMP** : Édition et redimensionnement gratuits
- **ImageMagick** : Redimensionnement en ligne de commande

---

## 📋 **Ordre de Génération Recommandé**

1. **Vaisseau joueur** (test du style)
2. **Ennemi basique** (validation du style ennemi)
3. **Astéroïde** (test des objets naturels)
4. **Power-up** (test des objets magiques)
5. **Background** (test des environnements)

---

## 💡 **Conseils Rapides**

- **Générez 3-5 variantes** pour chaque asset
- **Testez dans le jeu** après chaque génération
- **Gardez une palette cohérente** : Bleu/Silver pour le joueur, Rouge/Noir pour les ennemis
- **Priorisez la lisibilité** sur la complexité
- **Optimisez pour les petites tailles** (les détails se perdent)

---

**🎯 Commencez par le vaisseau joueur pour valider le style global !**
