import 'dart:math';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:vector_math/vector_math.dart';
import 'bullet.dart';
import '../basic_game.dart';
import 'explosion.dart';

enum EnemyType { basic, fast, tank }

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  Enemy({required Vector2 position, required this.type})
    : health = _getHealthForType(type),
      _currentHealth = _getHealthForType(type),
      shotInterval = _getShotIntervalForType(type),
      super(position: position, size: _getSizeForType(type));
  final EnemyType type;
  final double health;
  double _currentHealth;
  double _lastShot = 0;
  final double shotInterval;
  late Vector2 velocity;
  late Timer _shootTimer;

  static double _getShotIntervalForType(EnemyType type) {
    switch (type) {
      case EnemyType.basic:
        return 1.5; // Faster than before (was 2.0)
      case EnemyType.fast:
        return 1.0; // Much faster for fast enemies
      case EnemyType.tank:
        return 2.5; // Slightly slower for tank enemies
    }
  }

  static double _getHealthForType(EnemyType type) {
    switch (type) {
      case EnemyType.basic:
        return 1; // Reduced to 1 for immediate destruction
      case EnemyType.fast:
        return 1; // Reduced to 1 for immediate destruction
      case EnemyType.tank:
        return 1; // Reduced to 1 for immediate destruction
    }
  }

  static Vector2 _getSizeForType(EnemyType type) {
    switch (type) {
      case EnemyType.basic:
        return Vector2(35, 35); // Increased from 30x30
      case EnemyType.fast:
        return Vector2(30, 30); // Increased from 25x25
      case EnemyType.tank:
        return Vector2(45, 45); // Increased from 40x40
    }
  }

  @override
  Future<void> onLoad() async {
    // Initialize velocity and timer
    velocity = Vector2(0, 50);
    _shootTimer = Timer(shotInterval, repeat: true);

    // Remove automatic hitbox - use manual collision detection only
    // add(
    //   RectangleHitbox(
    //     size: Vector2(20, 20), // Smaller hitbox for better collision detection
    //     position: Vector2.zero(),
    //   ),
    // );

    // Load enemy sprite
    try {
      sprite = await Sprite.load('sprites/ennemi.png', images: game.images);
      print('Enemy sprite loaded successfully!');
      print(
        '👾 Enemy created at position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
      );
    } catch (e) {
      print('Failed to load sprites/ennemi.png: $e');
      // Fallback to colored rectangle
      add(
        RectangleComponent(
          size: size,
          paint: Paint()..color = const Color(0xFFFF0000),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Move enemy
    position += velocity * dt;

    // Manual collision check for debugging
    _checkManualCollisions();

    // Shoot occasionally
    _lastShot += dt;
    if (_lastShot >= shotInterval) {
      _shoot();
      _lastShot = 0;
    }

    // Remove if off screen
    if (position.y > game.size.y + size.y) {
      removeFromParent();
    }
  }

  void _checkManualCollisions() {
    // Get all components in the game
    final components = game.children.query<PositionComponent>();

    for (final component in components) {
      if (component == this) continue; // Skip self

      // Check if this is a bullet hitting us
      if (component is Bullet && component.isPlayerBullet) {
        final distance = position.distanceTo(component.position);
        if (distance < 25) {
          // Collision threshold
          print('💥 Manual collision detected! Enemy hit by bullet');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');
          print(
            '💥 Enemy position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
          );
          print(
            '💥 Bullet position: ${component.position.x.toStringAsFixed(1)}, ${component.position.y.toStringAsFixed(1)}',
          );

          // Handle collision
          takeDamage(component.damage);
          component.removeFromParent();
          break;
        }
      }
    }
  }

  void _shoot() {
    // Don't shoot if game is paused
    if (game.gameState.isPaused) return;

    final bullet = Bullet(
      position: Vector2(position.x, position.y + size.y),
      damage: 10,
      isPlayerBullet: false,
    );
    game.add(bullet);
  }

  void takeDamage(double damage) {
    _currentHealth -= damage;
    print('💥 Enemy hit! Health: $_currentHealth, Damage: $damage');

    if (_currentHealth <= 0) {
      // Enemy destroyed
      print('💀 Enemy destroyed! Removing from game...');
      print(
        '💀 Enemy position before removal: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
      );

      game.gameState.addScore(100);
      game.gameState.addCoins(10);

      // Play explosion sound
      game.audioManager.playExplosionSound();

      // Create explosion effect
      final explosion = Explosion(position: position, size: Vector2(50, 50));
      game.add(explosion);

      // Remove from game immediately
      removeFromParent();
      print('💀 Enemy removed from game successfully');

      // Verify removal
      final remainingEnemies = game.children.query<Enemy>();
      print('💀 Remaining enemies in game: ${remainingEnemies.length}');
    }
  }
}
