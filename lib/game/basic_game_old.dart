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
import 'floating_text.dart';

enum PowerUpType { shield, rapidFire, laser, speedBoost, magnet }

class PowerUp {
  PowerUp({required this.position, required this.type, this.duration = 10.0});
  final Vector2 position;
  final PowerUpType type;
  final double duration;
}

class BasicGame extends FlameGame {
  BasicGame({required this.gameState});
  final GameState gameState;
  late Vector2 playerPosition;
  late List<Vector2> enemies;
  late List<Vector2> asteroids;
  late List<Vector2> bullets;
  late List<PowerUp> powerUps;
  Boss? currentBoss;
  late EffectsManager effectsManager;
  late AudioManager audioManager;
  late StarField starField;
  late FloatingTextManager floatingTextManager;
  late Timer _scoreTimer;
  late Timer _shootTimer;
  late Timer _powerUpSpawnTimer;
  late Timer _bossSpawnTimer;
  bool _isShooting = false;

  // Power-up states (TODO: Implement power-up functionality)
  bool _shieldActive = false;
  // bool _rapidFireActive = false;
  bool _laserActive = false;
  // bool _speedBoostActive = false;
  // bool _magnetActive = false;
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
    playerPosition = Vector2(size.x / 2, size.y - 100);
    enemies = [];
    asteroids = [];
    bullets = [];
    powerUps = [];
    effectsManager = EffectsManager();
    audioManager = AudioManager();
    starField = StarField(size: size);
    floatingTextManager = FloatingTextManager();

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
        gameState.addScore(10); // Add 10 points at once to trigger notification
      },
    );

    _shootTimer = Timer(
      0.2,
      onTick: () {
        // Shoot only when _isShooting is true
        if (_isShooting) {
          bullets.add(Vector2(playerPosition.x, playerPosition.y - 20));
          print(
            '🔫 Bullet fired at position: ${playerPosition.x}, ${playerPosition.y - 20}',
          );
          print('🔫 Playing shoot sound...');
          audioManager.playShootSound();
        }
      },
    );

    _powerUpSpawnTimer = Timer(5.0, onTick: _spawnPowerUp);

    _bossSpawnTimer = Timer(30.0, onTick: _spawnBoss);

    // Start background music
    audioManager.playBackgroundMusic();
  }

  void startShooting() {
    _isShooting = true;
    // Fire immediately when shooting starts
    bullets.add(Vector2(playerPosition.x, playerPosition.y - 20));
    print('Shooting started - bullet fired immediately');
  }

  void stopShooting() {
    _isShooting = false;
    print('Shooting stopped');
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

  void _spawnPowerUp() {
    const types = PowerUpType.values;
    final randomType = types[Random().nextInt(types.length)];

    powerUps.add(
      PowerUp(
        position: Vector2(
          Random().nextDouble() * size.x,
          80,
        ), // Start below top HUD
        type: randomType,
      ),
    );
  }

  void _spawnBoss() {
    if (currentBoss != null) return; // Only one boss at a time

    BossType bossType;
    if (gameState.currentLevel <= 10) {
      bossType = BossType.basic;
    } else if (gameState.currentLevel <= 20) {
      bossType = BossType.advanced;
    } else if (gameState.currentLevel <= 35) {
      bossType = BossType.elite;
    } else {
      bossType = BossType.finalBoss;
    }

    print('👹 Spawning boss: $bossType');
    currentBoss = BossFactory.createBoss(bossType, Vector2(size.x / 2, 100));
    print('👹 Playing boss sound...');
    audioManager.playBossSound();
  }

  void _activatePowerUp(PowerUpType type) {
    switch (type) {
      case PowerUpType.shield:
        _shieldActive = true;
        _shieldTimer?.stop();
        _shieldTimer = Timer(
          10.0,
          onTick: () {
            _shieldActive = false;
          },
        );
        break;
      case PowerUpType.rapidFire:
        // _rapidFireActive = true;
        _rapidFireTimer?.stop();
        _rapidFireTimer = Timer(
          10.0,
          onTick: () {
            // _rapidFireActive = false;
          },
        );
        break;
      case PowerUpType.laser:
        _laserActive = true;
        _laserTimer?.stop();
        _laserTimer = Timer(
          8.0,
          onTick: () {
            _laserActive = false;
          },
        );
        break;
      case PowerUpType.speedBoost:
        // _speedBoostActive = true;
        _speedBoostTimer?.stop();
        _speedBoostTimer = Timer(
          12.0,
          onTick: () {
            // _speedBoostActive = false;
          },
        );
        break;
      case PowerUpType.magnet:
        // _magnetActive = true;
        _magnetTimer?.stop();
        _magnetTimer = Timer(
          15.0,
          onTick: () {
            // _magnetActive = false;
          },
        );
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check if game is paused
    if (gameState.isPaused) {
      return; // Don't update anything if paused
    }

    _scoreTimer.update(dt);
    _shootTimer.update(dt);
    _powerUpSpawnTimer.update(dt);
    _bossSpawnTimer.update(dt);

    // Update effects
    effectsManager.update(dt);

    // Update star field
    starField.update(dt);

    // Update floating text
    floatingTextManager.update(dt);

    // Update power-up timers
    _shieldTimer?.update(dt);
    _rapidFireTimer?.update(dt);
    _laserTimer?.update(dt);
    _speedBoostTimer?.update(dt);
    _magnetTimer?.update(dt);

    // Update bullets
    for (int i = bullets.length - 1; i >= 0; i--) {
    if (bullets.isEmpty) break;
      bullets[i].y -= 300 * dt;
      if (bullets[i].y < 0) {
        bullets.removeAt(i);
      }
    }

    // Debug: print bullet count
    if (bullets.isNotEmpty) {
      print('Bullets active: ${bullets.length}');
    }

    // Update enemies
    for (int i = enemies.length - 1; i >= 0; i--) {
    if (enemies.isEmpty) break;
      enemies[i].y += 100 * dt;
      if (enemies[i].y > size.y - 100) {
        // Stop before HUD
        enemies.removeAt(i);
        if (!_shieldActive) {
          gameState.loseLife();
          // Check for game over
          if (gameState.lives <= 0) {
            gameState.endGame();
            return;
          }
        }
      }
      // Prevent enemies from going above top HUD
      if (enemies[i].y < 80) {
        enemies[i].y = 80;
      }
    }

    // Update asteroids
    for (int i = asteroids.length - 1; i >= 0; i--) {
    if (asteroids.isEmpty) break;
      asteroids[i].y += 80 * dt;
      if (asteroids[i].y > size.y - 100) {
        // Stop before HUD
        asteroids.removeAt(i);
        if (!_shieldActive) {
          gameState.loseLife();
          // Check for game over
          if (gameState.lives <= 0) {
            gameState.endGame();
            return;
          }
        }
      }
      // Prevent asteroids from going above top HUD
      if (asteroids[i].y < 80) {
        asteroids[i].y = 80;
      }
    }

    // Update power-ups
    for (int i = powerUps.length - 1; i >= 0; i--) {
    if (powerUps.isEmpty) break;
      powerUps[i].position.y += 60 * dt;

      // Check collision with player
      if ((powerUps[i].position - playerPosition).length < 35) {
        print('⚡ Power-up collected: ${powerUps[i].type}');
        _activatePowerUp(powerUps[i].type);
        floatingTextManager.addCoinText(powerUps[i].position, 5);
        gameState.addCoins(5);
        print('⚡ Playing power-up sound...');
        audioManager.playPowerUpSound();
        powerUps.removeAt(i);
        continue;
      }

      // Remove if off screen
      if (powerUps[i].position.y > size.y - 100) {
        // Stop before HUD
        powerUps.removeAt(i);
        continue; // Skip to next iteration since we removed an element
      }

      // Prevent power-ups from going above top HUD
      if (powerUps[i].position.y < 80) {
        powerUps[i].position.y = 80;
      }
    }

    // Update boss
    if (currentBoss != null) {
      currentBoss!.update(dt, playerPosition);

      // Check if boss is dead
      if (currentBoss!.isDead()) {
        effectsManager.addExplosion(currentBoss!.position);
        floatingTextManager.addScoreText(currentBoss!.position, 100);
        floatingTextManager.addCoinText(currentBoss!.position, 20);
        gameState.addScore(100);
        gameState.addCoins(20);
        audioManager.playBossSound();
        gameState.nextLevel();
        currentBoss = null;
      }
    }

    // Spawn enemies with different types
    if (Random().nextDouble() < 0.08) {
      final enemyType = Random().nextInt(3);
      final enemy = Enemy(
        position: Vector2(
          Random().nextDouble() * size.x,
          80,
        ), // Start below top HUD
        type: EnemyType.values[enemyType],
      );
      add(enemy); // Add as component instead of storing position
    }

    // Spawn asteroids with different sizes
    if (Random().nextDouble() < 0.06) {
      final asteroidSize = 15 + Random().nextDouble() * 20;
      final asteroid = Asteroid(
        position: Vector2(
          Random().nextDouble() * size.x,
          80,
        ), // Start below top HUD
        size: asteroidSize,
      );
      asteroids.add(asteroid.position);
    }

    // Collision detection
    for (int i = bullets.length - 1; i >= 0; i--) {
    if (bullets.isEmpty) break;
      for (int j = enemies.length - 1; j >= 0; j--) {
        if ((bullets[i] - enemies[j]).length < 30) {
          print('💥 Enemy destroyed at position: ${enemies[j]}');
          bullets.removeAt(i);
          effectsManager.addExplosion(enemies[j]);
          floatingTextManager.addScoreText(enemies[j], 10);
          floatingTextManager.addCoinText(enemies[j], 2);
          enemies.removeAt(j);
          print('💥 Playing explosion sound...');
          audioManager.playExplosionSound();
          print('Adding score: 10, current score: ${gameState.score}');
          gameState.addScore(10);
          print('New score: ${gameState.score}');
          gameState.addCoins(2); // Add coins for destroying enemies
          break;
        }
      }
    }

    for (int i = bullets.length - 1; i >= 0; i--) {
    if (bullets.isEmpty) break;
      for (int j = asteroids.length - 1; j >= 0; j--) {
        if ((bullets[i] - asteroids[j]).length < 25) {
          print('💥 Asteroid destroyed at position: ${asteroids[j]}');
          bullets.removeAt(i);
          effectsManager.addExplosion(asteroids[j]);
          floatingTextManager.addScoreText(asteroids[j], 5);
          floatingTextManager.addCoinText(asteroids[j], 1);
          asteroids.removeAt(j);
          print('💥 Playing explosion sound...');
          audioManager.playExplosionSound();
          gameState.addScore(5);
          gameState.addCoins(1); // Add coins for destroying asteroids
          audioManager.playExplosionSound();
          break;
        }
      }
    }

    // Boss collision detection
    if (currentBoss != null) {
      for (int i = bullets.length - 1; i >= 0; i--) {
    if (bullets.isEmpty) break;
        if ((bullets[i] - currentBoss!.position).length < 40) {
          bullets.removeAt(i);
          currentBoss!.takeDamage(10);
          break;
        }
      }
    }

    // Player collision detection with enemies and asteroids
    if (!_shieldActive) {
      // Check collision with enemies
      for (int i = enemies.length - 1; i >= 0; i--) {
    if (enemies.isEmpty) break;
        if ((playerPosition - enemies[i]).length < 35) {
          effectsManager.addExplosion(enemies[i]);
          enemies.removeAt(i);
          gameState.loseLife();
          audioManager.playExplosionSound();

          // Check for game over
          if (gameState.lives <= 0) {
            gameState.endGame();
            return;
          }
        }
      }

      // Check collision with asteroids
      for (int i = asteroids.length - 1; i >= 0; i--) {
    if (asteroids.isEmpty) break;
        if ((playerPosition - asteroids[i]).length < 35) {
          effectsManager.addExplosion(asteroids[i]);
          asteroids.removeAt(i);
          gameState.loseLife();
          audioManager.playExplosionSound();

          // Check for game over
          if (gameState.lives <= 0) {
            gameState.endGame();
            return;
          }
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw background gradient
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue[900]!, Colors.black],
      ).createShader(Rect.fromLTWH(0, 0, size.x, size.y));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);

    // Draw star field
    starField.render(canvas);

    // Draw player ship using Spaceship component
    final playerShip = Spaceship(
      position: playerPosition,
      hasShield: _shieldActive,
    );
    playerShip.render(canvas);

    // Draw bullets using Bullet component
    for (final bullet in bullets) {
      final bulletComponent = Bullet(position: bullet, isLaser: _laserActive);
      bulletComponent.render(canvas);
    }

    // Draw enemies using Enemy component
    for (final enemyPos in enemies) {
      final enemyType = EnemyType.values[Random().nextInt(3)];
      final enemy = Enemy(position: enemyPos, type: enemyType);
      enemy.render(canvas);
    }

    // Draw asteroids using Asteroid component
    for (final asteroidPos in asteroids) {
      final asteroid = Asteroid(position: asteroidPos, size: 20);
      asteroid.render(canvas);
    }

    // Draw power-ups
    for (final powerUp in powerUps) {
      Color powerUpColor;
      String powerUpText;

      switch (powerUp.type) {
        case PowerUpType.shield:
          powerUpColor = Colors.cyan;
          powerUpText = 'S';
          break;
        case PowerUpType.rapidFire:
          powerUpColor = Colors.orange;
          powerUpText = 'R';
          break;
        case PowerUpType.laser:
          powerUpColor = Colors.red;
          powerUpText = 'L';
          break;
        case PowerUpType.speedBoost:
          powerUpColor = Colors.purple;
          powerUpText = 'B';
          break;
        case PowerUpType.magnet:
          powerUpColor = Colors.yellow;
          powerUpText = 'M';
          break;
      }

      final powerUpPaint = Paint()..color = powerUpColor;
      final powerUpTextPaint = TextPaint(
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

      canvas.drawCircle(
        Offset(powerUp.position.x, powerUp.position.y),
        12,
        powerUpPaint,
      );
      powerUpTextPaint.render(
        canvas,
        powerUpText,
        Vector2(powerUp.position.x - 5, powerUp.position.y - 10),
      );
    }

    // Draw boss
    if (currentBoss != null) {
      currentBoss!.render(canvas);
    }

    // Draw effects
    effectsManager.render(canvas);

    // Draw floating text
    floatingTextManager.render(canvas);
  }
}
