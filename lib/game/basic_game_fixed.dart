import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';
import '../services/settings_service.dart';
import 'dart:math';
import '../models/game_state.dart';
import 'boss_system.dart';
import 'effects_system.dart';
import 'audio_manager.dart';
import 'components/enemy.dart';
import 'components/asteroid.dart';
import 'components/player_ship.dart';
import 'components/bullet.dart';
import 'components/power_up.dart';
import 'floating_text.dart';

enum PowerUpType { shield, rapidFire, laser, speedBoost, magnet }

class BasicGame extends FlameGame {
  BasicGame({required this.gameState});
  final GameState gameState;

  // Player
  late PlayerShip player;

  // Game state
  late EffectsManager effectsManager;
  late AudioManager audioManager;
  late FloatingTextManager floatingTextManager;

  // Timers
  late Timer _scoreTimer;
  late Timer _shootTimer;
  late Timer _powerUpSpawnTimer;
  late Timer _bossSpawnTimer;

  // Power-up states
  bool _shieldActive = false;
  bool _laserActive = false;
  Timer? _shieldTimer;
  Timer? _rapidFireTimer;
  Timer? _laserTimer;
  Timer? _speedBoostTimer;
  Timer? _magnetTimer;

  @override
  Future<void> onLoad() async {
    await SettingsService().loadSettings();

    // Preload images for sprites
    print('🖼️ Preloading images...');
    await images.loadAll([
      'sprites/vaisseau.png',
      'sprites/ennemi.png',
      'sprites/meteor.png',
      'sprites/boss_final.png',
      'sprites/powerup_shield.png',
      'sprites/powerup_rapid_fire.png',
      'sprites/powerup_laser.png',
      'sprites/powerup_speed.png',
    ]);
    print('✅ Images preloaded successfully');

    // Initialize game elements
    effectsManager = EffectsManager();
    audioManager = AudioManager();
    floatingTextManager = FloatingTextManager();

    // Initialize player
    player = PlayerShip(
      position: Vector2(size.x / 2, size.y - 100),
      gameState: gameState,
    );
    add(player);

    // Initialize audio
    print('🎵 Initializing game audio...');
    await audioManager.initialize();
    print('🎵 Starting background music...');
    await audioManager.playBackgroundMusic();
    print('✅ Game audio initialized successfully');

    // Initialize timers
    _scoreTimer = Timer(
      1.0,
      onTick: () {
        gameState.addScore(10);
      },
    );

    _shootTimer = Timer(
      0.2,
      onTick: () {
        if (gameState.isPlaying && !gameState.isPaused) {
          player.shoot();
        }
      },
    );

    _powerUpSpawnTimer = Timer(5.0, onTick: _spawnPowerUp);
    _bossSpawnTimer = Timer(30.0, onTick: _spawnBoss);

    // Start background music
    audioManager.playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameState.isPlaying || gameState.isPaused) return;

    // Update timers
    _scoreTimer.update(dt);
    _shootTimer.update(dt);
    _powerUpSpawnTimer.update(dt);
    _bossSpawnTimer.update(dt);

    // Spawn enemies
    if (Random().nextDouble() < 0.08) {
      final enemyType = Random().nextInt(3);
      final enemy = Enemy(
        position: Vector2(Random().nextDouble() * size.x, 80),
        type: EnemyType.values[enemyType],
      );
      add(enemy);
    }

    // Spawn asteroids
    if (Random().nextDouble() < 0.06) {
      final asteroidSize = 15 + Random().nextDouble() * 20;
      final asteroid = Asteroid(
        position: Vector2(Random().nextDouble() * size.x, 80),
        asteroidSize: asteroidSize,
        level: 1, // Default level
      );
      add(asteroid);
    }

    // Update power-up timers
    _shieldTimer?.update(dt);
    _rapidFireTimer?.update(dt);
    _laserTimer?.update(dt);
    _speedBoostTimer?.update(dt);
    _magnetTimer?.update(dt);

    // Check power-up expiration
    if (_shieldTimer?.isRunning() == false) {
      _shieldActive = false;
      _shieldTimer = null;
    }
  }

  void _spawnPowerUp() {
    if (!gameState.isPlaying || gameState.isPaused) return;

    final powerUpTypes = PowerUpType.values;
    final randomType = powerUpTypes[Random().nextInt(powerUpTypes.length)];

    final powerUp = PowerUp(
      position: Vector2(Random().nextDouble() * size.x, 80),
      type: randomType.toString().split('.').last,
    );

    add(powerUp);
  }

  void _spawnBoss() {
    if (!gameState.isPlaying || gameState.isPaused) return;

    // Boss spawning logic would go here
    print('👹 Boss spawning...');
  }

  void togglePause() {
    if (gameState.isPaused) {
      gameState.resumeGame();
    } else {
      gameState.pauseGame();
    }
    print('Pause toggled: ${gameState.isPaused}');
  }

  void resumeGame() {
    gameState.resumeGame();
  }

  void quitGame() {
    gameState.endGame();
  }

  void movePlayerTo(double x) {
    if (gameState.isPlaying && !gameState.isPaused) {
      player.moveTo(x);
    }
  }

  void startShooting() {
    if (gameState.isPlaying && !gameState.isPaused) {
      player.shoot();
    }
  }

  void stopShooting() {
    // Player stops shooting automatically
  }
}
