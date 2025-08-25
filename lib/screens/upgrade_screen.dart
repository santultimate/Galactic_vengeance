import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Expanded(
                      child: Text(
                        'SHOP',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Coins display
              Consumer<GameState>(
                builder: (context, gameState, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.yellow, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${gameState.coins}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Upgrades list
              Expanded(
                child: Consumer<GameState>(
                  builder: (context, gameState, child) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _UpgradeCard(
                          title: 'Fire Rate',
                          description: 'Increase shooting speed',
                          icon: Icons.speed,
                          currentLevel: gameState.fireRateLevel,
                          cost: gameState.getUpgradeCost('fireRate'),
                          canUpgrade: gameState.canUpgrade('fireRate'),
                          onUpgrade: () {
                            if (gameState.upgrade('fireRate')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Fire Rate upgraded!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          color: Colors.red,
                        ),
                        const SizedBox(height: 15),
                        _UpgradeCard(
                          title: 'Damage',
                          description: 'Increase bullet damage',
                          icon: Icons.flash_on,
                          currentLevel: gameState.damageLevel,
                          cost: gameState.getUpgradeCost('damage'),
                          canUpgrade: gameState.canUpgrade('damage'),
                          onUpgrade: () {
                            if (gameState.upgrade('damage')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Damage upgraded!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 15),
                        _UpgradeCard(
                          title: 'Shield',
                          description: 'Increase maximum health',
                          icon: Icons.shield,
                          currentLevel: gameState.shieldLevel,
                          cost: gameState.getUpgradeCost('shield'),
                          canUpgrade: gameState.canUpgrade('shield'),
                          onUpgrade: () {
                            if (gameState.upgrade('shield')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Shield upgraded!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 15),
                        _UpgradeCard(
                          title: 'Speed',
                          description: 'Increase movement speed',
                          icon: Icons.rocket_launch,
                          currentLevel: gameState.speedLevel,
                          cost: gameState.getUpgradeCost('speed'),
                          canUpgrade: gameState.canUpgrade('speed'),
                          onUpgrade: () {
                            if (gameState.upgrade('speed')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Speed upgraded!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          color: Colors.green,
                        ),
                        const SizedBox(height: 15),
                        _UpgradeCard(
                          title: 'Magnet',
                          description: 'Increase power-up attraction radius',
                          icon: Icons.radio_button_checked,
                          currentLevel: gameState.magnetLevel,
                          cost: gameState.getUpgradeCost('magnet'),
                          canUpgrade: gameState.canUpgrade('magnet'),
                          onUpgrade: () {
                            if (gameState.upgrade('magnet')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Magnet upgraded!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          color: Colors.purple,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpgradeCard extends StatelessWidget {
  const _UpgradeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.currentLevel,
    required this.cost,
    required this.canUpgrade,
    required this.onUpgrade,
    required this.color,
  });
  final String title;
  final String description;
  final IconData icon;
  final int currentLevel;
  final int cost;
  final bool canUpgrade;
  final VoidCallback onUpgrade;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A4A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: canUpgrade ? color : Colors.grey, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level $currentLevel',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (cost > 0)
                Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$cost',
                      style: TextStyle(
                        fontSize: 16,
                        color: canUpgrade ? Colors.yellow : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: canUpgrade ? onUpgrade : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canUpgrade
                    ? color.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.3),
                foregroundColor: canUpgrade ? color : Colors.grey,
                side: BorderSide(
                  color: canUpgrade ? color : Colors.grey,
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                cost > 0 ? 'UPGRADE' : 'MAX LEVEL',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
