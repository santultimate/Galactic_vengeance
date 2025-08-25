import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/input.dart';
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
import 'components/boss.dart';
import 'components/background.dart';

enum PowerUpType { shield, rapidFire, laser, speedBoost, magnet }

class BasicGame extends FlameGame with CollisionCallbacks {
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

  // Getters for power-up states
  bool get isShieldActive => _shieldActive;
  bool get isLaserActive => _laserActive;
  bool get isRapidFireActive =>
      _rapidFireTimer != null && _rapidFireTimer!.isRunning();
  bool get isSpeedBoostActive =>
      _speedBoostTimer != null && _speedBoostTimer!.isRunning();
  bool get isMagnetActive => _magnetTimer != null && _magnetTimer!.isRunning();

  @override
  Future<void> onLoad() async {
    await SettingsService().loadSettings();

    // Enable collision detection
    debugMode = true; // Enable debug mode to see hitboxes

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
      'sprites/explose.png',
    ]);
    print('✅ Images preloaded successfully');

    // Initialize game elements
    effectsManager = EffectsManager();
    audioManager = AudioManager();
    floatingTextManager = FloatingTextManager();

    // Add starfield background
    add(StarField());

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
      0.15,
      onTick: () {
        if (gameState.isPlaying && !gameState.isPaused) {
          // Auto-shoot always, but faster if rapid fire is active
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

    // Debug: Log game state occasionally
    if (Random().nextDouble() < 0.01) {
      // 1% chance to log
      print(
        '🎮 Game state - isPlaying: ${gameState.isPlaying}, isPaused: ${gameState.isPaused}',
      );
    }

    // Always update timers to prevent them from getting stuck
    _scoreTimer.update(dt);
    _shootTimer.update(dt);
    _powerUpSpawnTimer.update(dt);
    _bossSpawnTimer.update(dt);

    // Update power-up timers
    _shieldTimer?.update(dt);
    _rapidFireTimer?.update(dt);
    _laserTimer?.update(dt);
    _speedBoostTimer?.update(dt);
    _magnetTimer?.update(dt);

    // Check for game over first
    if (gameState.lives <= 0 && gameState.isPlaying) {
      print('💀 Game over detected');
      gameState.endGame();
      return;
    }

    // Only run game logic if game is playing and not paused
    if (!gameState.isPlaying || gameState.isPaused) {
      print('⏸️ Game paused or not playing - skipping game logic');
      return;
    }

    // Spawn enemies
    if (Random().nextDouble() < 0.08) {
      print('🎲 Attempting to spawn enemy...');
      _spawnEnemy();
    }

    // Spawn asteroids
    if (Random().nextDouble() < 0.06) {
      print('🎲 Attempting to spawn asteroid...');
      _spawnAsteroid();
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
      overlays.remove('pause');
    } else {
      gameState.pauseGame();
      overlays.add('pause');
    }
    print('Pause toggled: ${gameState.isPaused}');
  }

  void resumeGame() {
    // If game is over (lives <= 0), restart the game
    if (gameState.lives <= 0) {
      print('🔄 Game over detected, restarting game...');
      gameState.startGame();
    } else {
      // Just resume the paused game
      print('▶️ Resuming paused game...');
      gameState.resumeGame();
    }
    overlays.remove('pause');
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
      // Start continuous shooting immediately
      player.shoot();

      // Set up continuous shooting timer
      _shootTimer = Timer(
        0.05, // Fast shooting when player is touching
        onTick: () {
          if (gameState.isPlaying && !gameState.isPaused) {
            player.shoot();
          }
        },
      );
    }
  }

  void stopShooting() {
    // Reset to normal shooting timer
    _shootTimer = Timer(
      0.15, // Normal shooting rate (was 0.03)
      onTick: () {
        if (gameState.isPlaying && !gameState.isPaused) {
          // Auto-shoot always, but faster if rapid fire is active
          player.shoot();
        }
      },
    );
  }

  // Power-up activation methods
  void activateShield() {
    _shieldActive = true;
    _shieldTimer = Timer(
      8.0,
      onTick: () {
        _shieldActive = false;
        _shieldTimer = null;
      },
    );
    print('🛡️ Shield activated for 8 seconds');
  }

  void activateRapidFire() {
    // Increase fire rate temporarily
    _rapidFireTimer = Timer(
      10.0,
      onTick: () {
        _rapidFireTimer = null;
        print('⚡ Rapid fire deactivated');
      },
    );
    print('⚡ Rapid fire activated for 10 seconds');
  }

  void activateLaser() {
    _laserActive = true;
    _laserTimer = Timer(
      12.0,
      onTick: () {
        _laserActive = false;
        _laserTimer = null;
      },
    );
    print('🔫 Laser activated for 12 seconds');
  }

  void activateSpeedBoost() {
    _speedBoostTimer = Timer(
      12.0,
      onTick: () {
        _speedBoostTimer = null;
      },
    );
    print('🏃 Speed boost activated for 12 seconds');
  }

  void _spawnEnemy() {
    final random = Random();
    final x = random.nextDouble() * (size.x - 50) + 25;
    final enemyType = EnemyType.values[random.nextInt(EnemyType.values.length)];

    final enemy = Enemy(position: Vector2(x, -50), type: enemyType);

    add(enemy);
    print('👾 Enemy spawned at x: ${x.toStringAsFixed(1)}, type: $enemyType');
  }

  void _spawnAsteroid() {
    final random = Random();
    final x = random.nextDouble() * (size.x - 50) + 25;
    final asteroidSize = random.nextDouble() * 30 + 20; // 20-50 pixels

    final asteroid = Asteroid(
      position: Vector2(x, -50),
      asteroidSize: asteroidSize,
      level: 1,
    );

    add(asteroid);
    print(
      '☄️ Asteroid spawned at x: ${x.toStringAsFixed(1)}, size: ${asteroidSize.toStringAsFixed(1)}',
    );
  }
}
