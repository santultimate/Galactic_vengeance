import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart' hide Colors;
import '../models/game_state.dart';
import 'components/player_ship.dart';
import 'components/enemy.dart';
import 'components/asteroid.dart';
import 'components/power_up.dart';
import 'components/boss.dart';
import 'components/background.dart';
import 'dart:math';

class GalacticVengeanceGame extends FlameGame with HasCollisionDetection {
  // 3 minutes

  GalacticVengeanceGame({required this.gameState});
  final GameState gameState;
  final Random _random = Random();

  late PlayerShip player;
  late Background background;

  double _lastEnemySpawn = 0;
  double _lastAsteroidSpawn = 0;
  double _lastPowerUpSpawn = 0;
  double _bossSpawnTime = 0;
  bool _bossSpawned = false;

  // Game settings
  static const double enemySpawnInterval = 2.0;
  static const double asteroidSpawnInterval = 1.5;
  static const double powerUpSpawnInterval = 10.0;
  static const double bossSpawnDelay = 180.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add background
    background = Background();
    add(background);

    // Add player
    player = PlayerShip(
      position: Vector2(size.x / 2, size.y - 100),
      gameState: gameState,
    );
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameState.isPaused) return;

    _lastEnemySpawn += dt;
    _lastAsteroidSpawn += dt;
    _lastPowerUpSpawn += dt;
    _bossSpawnTime += dt;

    // Spawn enemies
    if (_lastEnemySpawn >= enemySpawnInterval) {
      _spawnEnemy();
      _lastEnemySpawn = 0;
    }

    // Spawn asteroids
    if (_lastAsteroidSpawn >= asteroidSpawnInterval) {
      _spawnAsteroid();
      _lastAsteroidSpawn = 0;
    }

    // Spawn power-ups
    if (_lastPowerUpSpawn >= powerUpSpawnInterval) {
      _spawnPowerUp();
      _lastPowerUpSpawn = 0;
    }

    // Spawn boss
    if (!_bossSpawned && _bossSpawnTime >= bossSpawnDelay) {
      _spawnBoss();
      _bossSpawned = true;
    }

    // Check for level completion
    _checkLevelCompletion();
  }

  void _spawnEnemy() {
    final enemy = Enemy(
      position: Vector2(_random.nextDouble() * size.x, -50),
      level: gameState.currentLevel,
    );
    add(enemy);
  }

  void _spawnAsteroid() {
    final asteroid = Asteroid(
      position: Vector2(_random.nextDouble() * size.x, -50),
      asteroidSize: _random.nextDouble() * 30 + 20,
      level: gameState.currentLevel,
    );
    add(asteroid);
  }

  void _spawnPowerUp() {
    final powerUpTypes = ['shield', 'rapid_fire', 'laser', 'speed'];
    final randomType = powerUpTypes[_random.nextInt(powerUpTypes.length)];

    final powerUp = PowerUp(
      position: Vector2(_random.nextDouble() * size.x, -50),
      type: randomType,
    );
    add(powerUp);
  }

  void _spawnBoss() {
    final boss = Boss(
      position: Vector2(size.x / 2, -100),
      level: gameState.currentLevel,
    );
    add(boss);
  }

  void _checkLevelCompletion() {
    // Check if all enemies and boss are defeated
    final enemies = children.whereType<Enemy>().toList();
    final bosses = children.whereType<Boss>().toList();

    if (enemies.isEmpty && bosses.isEmpty && _bossSpawned) {
      // Level completed
      gameState.nextLevel();
      gameState.addCoins(100); // Bonus for completing level

      // Reset for next level
      _bossSpawned = false;
      _bossSpawnTime = 0;

      // Show level completion message
      _showLevelComplete();
    }
  }

  void _showLevelComplete() {
    // This would show a level complete overlay
    // For now, we'll just add some particles
    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 50,
          lifespan: 2.0,
          generator: (i) => AcceleratedParticle(
            speed: Vector2(0, -200),
            acceleration: Vector2(0, 100),
            position: Vector2(_random.nextDouble() * size.x, size.y),
            child: CircleParticle(
              radius: 3,
              paint: Paint()..color = const Color(0xFFFFFF00),
            ),
          ),
        ),
      ),
    );
  }

  void addScore(int points) {
    gameState.addScore(points);
  }

  void addCoins(int amount) {
    gameState.addCoins(amount);
  }

  void playerHit() {
    gameState.loseLife();

    // Add explosion effect
    add(
      ParticleSystemComponent(
        particle: Particle.generate(
          count: 20,
          lifespan: 1.0,
          generator: (i) => AcceleratedParticle(
            speed: Vector2(
              (_random.nextDouble() - 0.5) * 200,
              (_random.nextDouble() - 0.5) * 200,
            ),
            acceleration: Vector2(0, 100),
            position: player.position.clone(),
            child: CircleParticle(
              radius: 2,
              paint: Paint()..color = const Color(0xFFFF0000),
            ),
          ),
        ),
      ),
    );
  }
}
