import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:vector_math/vector_math.dart';
import 'dart:math';
import '../basic_game.dart';
import 'enemy.dart';
import 'asteroid.dart';
import 'player_ship.dart';

class Bullet extends PositionComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  Bullet({
    required Vector2 position,
    required this.damage,
    required this.isPlayerBullet,
  }) : velocity = Vector2(0, isPlayerBullet ? -300 : 200),
       super(
         position: position,
         size: Vector2(6, 16),
       ); // Increased size from 4x12
  final double damage;
  final bool isPlayerBullet;
  final Vector2 velocity;

  @override
  Future<void> onLoad() async {
    // Remove automatic hitbox - use manual collision detection only
    // add(
    //   RectangleHitbox(
    //     size: Vector2(4, 8), // Smaller hitbox for better collision detection
    //     position: Vector2.zero(),
    //   ),
    // );

    // Create bullet visual
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = isPlayerBullet
              ? const Color(0xFF0000FF)
              : const Color(0xFFFF0000),
      ),
    );

    print(
      '🔫 Bullet created at position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Move bullet
    position += velocity * dt;

    // Manual collision check for debugging
    _checkManualCollisions();

    // Debug: Log bullet position occasionally
    if (Random().nextDouble() < 0.01) {
      // 1% chance to log
      print(
        '🔍 Bullet position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
      );
    }

    // Remove if off screen (use actual game size)
    if (position.y < -size.y || position.y > game.size.y + size.y) {
      removeFromParent();
    }
  }

  void _checkManualCollisions() {
    // Get all components in the game
    final components = game.children.query<PositionComponent>();

    for (final component in components) {
      if (component == this) continue; // Skip self

      // Check if this is a potential collision target
      if (isPlayerBullet && (component is Enemy || component is Asteroid)) {
        // Check distance-based collision
        final distance = position.distanceTo(component.position);
        if (distance < 30) {
          // Collision threshold
          print(
            '💥 Manual collision detected! Bullet with ${component.runtimeType}',
          );
          print('💥 Distance: ${distance.toStringAsFixed(1)}');

          // Handle collision
          if (component is Enemy) {
            component.takeDamage(damage);
            removeFromParent();
            break;
          } else if (component is Asteroid) {
            component.takeDamage(damage);
            removeFromParent();
            break;
          }
        }
      } else if (!isPlayerBullet && component is PlayerShip) {
        // Enemy bullet hitting player
        final distance = position.distanceTo(component.position);
        if (distance < 30) {
          // Collision threshold
          print('💥 Manual collision detected! Enemy bullet with player');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');
          removeFromParent();
          break;
        }
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    print(
      '💥 Bullet collision detected! Bullet type: ${isPlayerBullet ? "Player" : "Enemy"}',
    );
    print('💥 Collision with: ${other.runtimeType}');

    // Handle collisions based on bullet type
    if (isPlayerBullet) {
      // Player bullet hits enemy/asteroid
      if (other is Enemy) {
        print('🎯 Player bullet hit enemy!');
        other.takeDamage(damage);
        removeFromParent();
      } else if (other is Asteroid) {
        print('🎯 Player bullet hit asteroid!');
        other.takeDamage(damage);
        removeFromParent();
      }
    } else {
      // Enemy bullet hits player
      if (other is PlayerShip) {
        print('🎯 Enemy bullet hit player!');
        // gameRef.playerHit(); // TODO: Implement in BasicGame
        removeFromParent();
      }
    }
  }
}
