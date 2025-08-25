import 'dart:math';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:vector_math/vector_math.dart';
import 'bullet.dart';
import '../basic_game.dart';
import 'explosion.dart';

class Asteroid extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  Asteroid({
    required Vector2 position,
    required this.asteroidSize,
    required this.level,
  }) : health = 1.0, // Fixed health to 1 for immediate destruction
       super(position: position, size: Vector2(asteroidSize, asteroidSize));
  final int level;
  final double asteroidSize;

  double health;
  late Vector2 velocity;

  @override
  Future<void> onLoad() async {
    final random = Random();
    velocity = Vector2((random.nextDouble() - 0.5) * 100, 100 + (level * 20));

    // Add collision hitbox - simple circle hitbox
    add(CircleHitbox());

    // Load asteroid sprite
    try {
      print('🔍 Loading sprites/meteor.png...');
      print('📁 Current directory: ${Directory.current.path}');
      sprite = await Sprite.load('sprites/meteor.png', images: game.images);
      print('Asteroid sprite loaded successfully!');
    } catch (e) {
      print('Failed to load sprites/meteor.png: $e');
      // Fallback to circle if sprite loading fails
      add(
        CircleComponent(
          radius: asteroidSize / 2,
          paint: Paint()..color = const Color(0xFF8B4513),
        ),
      );
      print('Using fallback circle for asteroid');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Move asteroid
    position += velocity * dt;

    // Manual collision check for debugging
    _checkManualCollisions();

    // Remove if off screen
    if (position.y > game.size.y + asteroidSize) {
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
        if (distance < asteroidSize / 2 + 10) {
          // Collision threshold
          print('💥 Manual collision detected! Asteroid hit by bullet');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');
          print(
            '💥 Asteroid position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
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

  void takeDamage(double damage) {
    health -= damage;
    print('💥 Asteroid hit! Health: $health, Damage: $damage');

    if (health <= 0) {
      // Asteroid destroyed
      print('💀 Asteroid destroyed! Removing from game...');
      print(
        '💀 Asteroid position before removal: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
      );

      game.gameState.addScore(50);
      game.gameState.addCoins(5);

      // Play explosion sound
      game.audioManager.playExplosionSound();

      // Create explosion effect
      final explosion = Explosion(position: position, size: Vector2(40, 40));
      game.add(explosion);

      // Remove from game immediately
      removeFromParent();
      print('💀 Asteroid removed from game successfully');

      // Verify removal
      final remainingAsteroids = game.children.query<Asteroid>();
      print('💀 Remaining asteroids in game: ${remainingAsteroids.length}');
    }
  }
}
