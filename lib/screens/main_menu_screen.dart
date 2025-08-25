import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../core/services/audio_service.dart';
import 'dart:math';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _menuController;
  late AnimationController _starController;

  late Animation<double> _titleAnimation;
  late Animation<Offset> _menuAnimation;
  late Animation<double> _starAnimation;

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _menuController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _starController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.elasticOut),
    );

    _menuAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _menuController, curve: Curves.easeOutBack),
        );

    _starAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _titleController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _menuController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _starController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _menuController.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        title: const Text(
          'GALACTIC VENGEANCE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AudioService().playButtonSound();
              Navigator.pushNamed(context, '/upgrades');
            },
            icon: const Icon(Icons.shopping_cart, color: Colors.blue, size: 24),
            tooltip: 'Shop',
          ),
          IconButton(
            onPressed: () {
              AudioService().playButtonSound();
              _showHighScores(context);
            },
            icon: const Icon(Icons.leaderboard, color: Colors.yellow, size: 24),
            tooltip: 'High Scores',
          ),
          IconButton(
            onPressed: () {
              AudioService().playButtonSound();
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings, color: Colors.purple, size: 24),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {
              AudioService().playButtonSound();
              Navigator.pushNamed(context, '/about');
            },
            icon: const Icon(Icons.info, color: Colors.cyan, size: 24),
            tooltip: 'À propos',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A2A),
              Color(0xFF1A1A4A),
              Color(0xFF2A2A6A),
              Color(0xFF1A1A4A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated stars background
            ...List.generate(50, _buildStar),

            SafeArea(
              child: Column(
                children: [
                  // Title section
                  Expanded(
                    flex: 2,
                    child: FadeTransition(
                      opacity: _titleAnimation,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Game title
                            const Text(
                              'GALACTIC',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Orbitron',
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'VENGEANCE',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                                fontFamily: 'Orbitron',
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Animated spaceship icon
                            AnimatedBuilder(
                              animation: _starAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                    0,
                                    5 * sin(_starAnimation.value * 2 * 3.14159),
                                  ),
                                  child: const Icon(
                                    Icons.rocket_launch,
                                    size: 50,
                                    color: Colors.orange,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Play button
                  Expanded(
                    flex: 1,
                    child: SlideTransition(
                      position: _menuAnimation,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: _buildMenuButton(
                          'PLAY GAME',
                          Icons.play_arrow,
                          Colors.green,
                          () {
                            AudioService().playButtonSound();
                            Navigator.pushNamed(context, '/game');
                          },
                        ),
                      ),
                    ),
                  ),

                  // Footer
                  Expanded(
                    flex: 1,
                    child: FadeTransition(
                      opacity: _titleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Defend the Galaxy',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(int index) {
    final random = Random(index);
    final x = random.nextDouble() * MediaQuery.of(context).size.width;
    final y = random.nextDouble() * MediaQuery.of(context).size.height;
    final size = 1 + random.nextDouble() * 2;
    final delay = random.nextDouble() * 2;

    return AnimatedBuilder(
      animation: _starAnimation,
      builder: (context, child) {
        final opacity =
            (0.3 + 0.7 * sin((_starAnimation.value * 2 * 3.14159) + delay))
                .clamp(0.0, 1.0);
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.2),
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: color, width: 2),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showHighScores(BuildContext context) {
    final gameState = context.read<GameState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A4A),
        title: const Text(
          'HIGH SCORES',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Best Score: ${gameState.highScore}',
              style: const TextStyle(color: Colors.yellow, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Current Level: ${gameState.currentLevel}',
              style: const TextStyle(color: Colors.cyan, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Coins: ${gameState.coins}',
              style: const TextStyle(color: Colors.orange, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
