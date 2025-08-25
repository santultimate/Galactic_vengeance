import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({
    super.key,
    required this.finalScore,
    required this.level,
    required this.coins,
  });
  final int finalScore;
  final int level;
  final int coins;

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

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
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Game Over Title
                    Container(
                      height: 200,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'GAME OVER',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 10,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: const Icon(
                                      Icons.rocket_launch,
                                      size: 60,
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

                    // Statistics
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildStatCard(
                            'Final Score',
                            widget.finalScore.toString(),
                            Icons.star,
                            Colors.yellow,
                          ),
                          const SizedBox(height: 10),
                          _buildStatCard(
                            'Level Reached',
                            'Level ${widget.level}',
                            Icons.trending_up,
                            Colors.green,
                          ),
                          const SizedBox(height: 10),
                          _buildStatCard(
                            'Coins Earned',
                            widget.coins.toString(),
                            Icons.monetization_on,
                            Colors.orange,
                          ),
                          const SizedBox(height: 10),
                          _buildHighScoreCard(),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildActionButton(
                            'Play Again',
                            Icons.replay,
                            Colors.green,
                            _restartGame,
                          ),
                          const SizedBox(height: 15),
                          _buildActionButton(
                            'Shop',
                            Icons.shopping_cart,
                            Colors.orange,
                            _openShop,
                          ),
                          const SizedBox(height: 15),
                          _buildActionButton(
                            'Main Menu',
                            Icons.home,
                            Colors.blue,
                            _goToMainMenu,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighScoreCard() {
    final gameState = context.read<GameState>();
    final isNewHighScore = widget.finalScore > gameState.highScore;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: isNewHighScore
            ? Colors.amber.withOpacity(0.3)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isNewHighScore ? Colors.amber : Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isNewHighScore ? Icons.emoji_events : Icons.leaderboard,
            color: isNewHighScore ? Colors.amber : Colors.white,
            size: 30,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNewHighScore ? 'NEW HIGH SCORE!' : 'High Score',
                  style: TextStyle(
                    color: isNewHighScore ? Colors.amber : Colors.white70,
                    fontSize: 14,
                    fontWeight: isNewHighScore
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                Text(
                  gameState.highScore.toString(),
                  style: TextStyle(
                    color: isNewHighScore ? Colors.amber : Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _restartGame() {
    final gameState = context.read<GameState>();
    gameState.startGame();
    Navigator.of(context).pushReplacementNamed('/game');
  }

  void _openShop() {
    Navigator.of(context).pushNamed('/upgrades');
  }

  void _goToMainMenu() {
    Navigator.of(context).pushReplacementNamed('/');
  }
}
