import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A2A), Color(0xFF1A1A4A), Color(0xFF2A2A6A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'À PROPOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 50), // Balance the back button
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game Logo
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.cyan, width: 2),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.rocket_launch,
                                size: 60,
                                color: Colors.orange,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'GALACTIC VENGEANCE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SpaceFont',
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Version 1.0.0',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Game Description
                      _buildSection(
                        'Description',
                        Icons.info,
                        'Galactic Vengeance est un jeu d\'arcade spatial captivant où vous devez défendre la galaxie contre des vagues d\'ennemis et d\'astéroïdes. Améliorez votre vaisseau, collectez des power-ups et affrontez des boss redoutables dans cette aventure spatiale épique !',
                      ),

                      const SizedBox(height: 20),

                      // Features
                      _buildSection(
                        'Fonctionnalités',
                        Icons.star,
                        '• 50 niveaux progressifs\n• Système d\'amélioration RPG\n• Power-ups en temps réel\n• Boss uniques avec patterns variés\n• Effets visuels et sonores\n• Sauvegarde automatique',
                      ),

                      const SizedBox(height: 20),

                      // Controls
                      _buildSection(
                        'Contrôles',
                        Icons.gamepad,
                        '• Touchez l\'écran pour déplacer le vaisseau\n• Les tirs sont automatiques\n• Évitez les ennemis et astéroïdes\n• Collectez les power-ups pour des bonus',
                      ),

                      const SizedBox(height: 20),

                      // Development
                      _buildSection(
                        'Développement',
                        Icons.code,
                        'Développé avec Flutter et Flame\nMoteur de jeu 2D puissant\nInterface utilisateur moderne\nOptimisé pour mobile',
                      ),

                      const SizedBox(height: 20),

                      // Credits
                      _buildSection(
                        'Crédits',
                        Icons.person,
                        'Développeur: Yacouba Santara\nTechnologies: Flutter, Flame\nDesign: Interface moderne\nAudio: Effets sonores immersifs',
                      ),

                      const SizedBox(height: 20),

                      // Contact
                      _buildSection(
                        'Contact',
                        Icons.email,
                        'Pour toute question ou suggestion, n\'hésitez pas à nous contacter.\n\nMerci de jouer à Galactic Vengeance !',
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.cyan, size: 24),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
