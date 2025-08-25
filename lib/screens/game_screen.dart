import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../models/game_state.dart';
import '../game/basic_game.dart';
import '../core/services/audio_service.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BasicGame? _game;
  GameState? _gameState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gameState = context.read<GameState>();
      _game = BasicGame(gameState: _gameState!);
      print('🎮 Game initialized, starting game...');
      _gameState!.startGame(); // Start game after initialization
      print('🎮 Game started, isPlaying: ${_gameState!.isPlaying}');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print('GameScreen: build called - integrating Flame');

    if (_game == null || _gameState == null) {
      print('GameScreen: Game or GameState is null, showing loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    print('GameScreen: GameState isPlaying = ${_gameState!.isPlaying}');

    // Show game over screen only if game is actually over (lives <= 0) and not paused
    if (_gameState!.lives <= 0 && !_gameState!.isPaused) {
      print('GameScreen: Game over, showing game over screen');
      return _buildGameOverScreen(context, _gameState!);
    }

    print('GameScreen: Showing Flame game widget');
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A2A),
      body: SafeArea(
        child: Column(
          children: [
            // HUD en haut avec SafeArea
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Score
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      child: Text(
                        'Score: ${_gameState!.score}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Level
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green, width: 1),
                      ),
                      child: Text(
                        'Level: ${_gameState!.currentLevel}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Pause Button
                  GestureDetector(
                    onTap: () {
                      print(
                        'Pause button tapped, current state: ${_gameState!.isPaused}',
                      );
                      _game!.togglePause();
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.purple, width: 1),
                      ),
                      child: Icon(
                        _gameState!.isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Game Widget
            Expanded(
              child: Stack(
                children: [
                  // Game widget
                  GameWidget(
                    game: _game!,
                    overlayBuilderMap: {
                      'pause': (context, game) => _buildPauseMenu(context),
                      'gameOver': (context, game) =>
                          _buildGameOverScreen(context, _gameState!),
                    },
                  ),

                  // Contrôles tactiles pour le vaisseau (seulement si pas en pause)
                  if (!_gameState!.isPaused)
                    Positioned.fill(
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          if (_gameState!.isPlaying && !_gameState!.isPaused) {
                            final localPosition = details.localPosition;
                            _game!.movePlayerTo(
                              localPosition.dx.clamp(
                                25.0,
                                _game!.size.x - 25.0,
                              ),
                            );
                            _game!.startShooting();
                            print(
                              'Pan update - ship moved to ${localPosition.dx}',
                            );
                          }
                        },
                        onPanEnd: (details) {
                          if (_gameState!.isPlaying && !_gameState!.isPaused) {
                            _game!.stopShooting();
                            print('Pan end - stopped shooting');
                          }
                        },
                        onTapDown: (details) {
                          if (_gameState!.isPlaying && !_gameState!.isPaused) {
                            final localPosition = details.localPosition;
                            _game!.movePlayerTo(
                              localPosition.dx.clamp(
                                25.0,
                                _game!.size.x - 25.0,
                              ),
                            );
                            _game!.startShooting();
                            print(
                              'Tap down - ship moved to ${localPosition.dx}',
                            );
                          }
                        },
                        onTapUp: (details) {
                          if (_gameState!.isPlaying && !_gameState!.isPaused) {
                            _game!.stopShooting();
                            print('Tap up - stopped shooting');
                          }
                        },
                        onTapCancel: () {
                          if (_gameState!.isPlaying && !_gameState!.isPaused) {
                            _game!.stopShooting();
                            print('Tap cancel - stopped shooting');
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Bottom HUD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Lives
                  Row(
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.favorite,
                          color: index < _gameState!.lives
                              ? Colors.red
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Coins
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.yellow, width: 1),
                      ),
                      child: Text(
                        '\$ ${_gameState!.coins}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildGameOverScreen(BuildContext context, GameState gameState) {
    return GameOverScreen(
      finalScore: gameState.score,
      level: gameState.currentLevel,
      coins: gameState.coins,
    );
  }

  Widget _buildPauseMenu(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.9),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[300]!, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icône de pause grande et visible
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Icon(
                  Icons.pause_circle_filled,
                  color: Colors.grey[700],
                  size: 80,
                ),
              ),

              // Titre "PAUSE" grand et visible
              const Text(
                'PAUSE',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 50),

              // Score actuel
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Score: ${_gameState!.score}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Bouton REPRENDRE
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    print('🔄 Bouton REPRENDRE pressé');
                    _game!.resumeGame();
                    setState(() {});
                    print(
                      '🔄 GameState après resume: isPlaying=${_gameState!.isPlaying}, isPaused=${_gameState!.isPaused}',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'REPRENDRE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bouton MENU PRINCIPAL
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    print('🏠 Bouton MENU PRINCIPAL pressé');
                    _game!.quitGame();
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'MENU PRINCIPAL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
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
}
