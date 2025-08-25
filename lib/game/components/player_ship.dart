import 'dart:math';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:vector_math/vector_math.dart';
import '../../models/game_state.dart';
import 'bullet.dart';
import '../basic_game.dart';
import 'enemy.dart';
import 'asteroid.dart';
import 'power_up.dart';

class PlayerShip extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  PlayerShip({required Vector2 position, required this.gameState})
    : super(
        position: position,
        size: Vector2(40, 50),
      ); // Increased size from default
  final GameState gameState;

  double _targetX = 0;
  bool _isMoving = false;
  double _lastShot = 0;
  bool _isInvulnerable = false;
  double _invulnerabilityTimer = 0;
  static const double _invulnerabilityDuration =
      2.0; // 2 seconds of invulnerability

  @override
  Future<void> onLoad() async {
    // Remove automatic hitbox - use manual collision detection only
    // add(
    //   RectangleHitbox(
    //     size: Vector2(30, 40), // Smaller hitbox for better collision detection
    //     position: Vector2.zero(),
    //   ),
    // );

    // Load player ship sprite
    try {
      sprite = await Sprite.load('sprites/vaisseau.png', images: game.images);
      print('Player ship sprite loaded successfully!');
      print(
        '🚀 Player ship created at position: ${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}',
      );
    } catch (e) {
      print('Failed to load sprites/vaisseau.png: $e');
      // Fallback to colored rectangle
      add(
        RectangleComponent(
          size: size,
          paint: Paint()..color = const Color(0xFF00FF00),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Update invulnerability timer
    if (_isInvulnerable) {
      _invulnerabilityTimer += dt;
      if (_invulnerabilityTimer >= _invulnerabilityDuration) {
        _isInvulnerable = false;
        _invulnerabilityTimer = 0;
        print('🛡️ Player invulnerability ended');
      }
    }

    // Move towards target
    if (_isMoving) {
      final currentX = position.x;
      final distance = _targetX - currentX;
      final moveSpeed = 200 * gameState.speed;

      if (distance.abs() > 5) {
        position.x += distance.sign * moveSpeed * dt;
      } else {
        position.x = _targetX;
        _isMoving = false;
      }
    }

    // Keep ship within bounds
    position.x = position.x.clamp(size.x / 2, game.size.x - size.x / 2);

    // Manual collision check for debugging
    _checkManualCollisions();
  }

  void _checkManualCollisions() {
    // Don't check collisions if game is over or player is invulnerable
    if (game.gameState.lives <= 0 || _isInvulnerable) {
      if (_isInvulnerable) {
        print('🛡️ Player is invulnerable, skipping collision check');
      }
      return;
    }

    // Get all components in the game
    final components = game.children.query<PositionComponent>();
    bool collisionDetected = false;

    for (final component in components) {
      if (component == this || collisionDetected)
        continue; // Skip self or if collision already detected

      // Check if this is an enemy bullet hitting us
      if (component is Bullet && !component.isPlayerBullet) {
        final distance = position.distanceTo(component.position);
        if (distance < 25) {
          // Collision threshold
          print('💥 Manual collision detected! Player hit by enemy bullet');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');

          // Handle collision
          _playerHit();
          component.removeFromParent();
          collisionDetected = true;
          break;
        }
      }

      // Check if this is an enemy hitting us
      if (component is Enemy) {
        final distance = position.distanceTo(component.position);
        if (distance < 30) {
          // Collision threshold
          print('💥 Manual collision detected! Player hit by enemy');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');

          // Handle collision
          _playerHit();
          collisionDetected = true;
          break;
        }
      }

      // Check if this is an asteroid hitting us
      if (component is Asteroid) {
        final distance = position.distanceTo(component.position);
        if (distance < 30) {
          // Collision threshold
          print('💥 Manual collision detected! Player hit by asteroid');
          print('💥 Distance: ${distance.toStringAsFixed(1)}');

          // Handle collision
          _playerHit();
          collisionDetected = true;
          break;
        }
      }

      // Check if this is a power-up to collect
      if (component is PowerUp) {
        final distance = position.distanceTo(component.position);
        if (distance < 35) {
          // Collision threshold for power-up collection
          print('⚡ Manual collision detected! Player collecting power-up');
          print('⚡ Distance: ${distance.toStringAsFixed(1)}');

          // Handle power-up collection
          component.applyPowerUp();
          component.removeFromParent();
          collisionDetected = true;
          break;
        }
      }
    }
  }

  void moveTo(double targetX) {
    _targetX = targetX;
    _isMoving = true;
  }

  void stopMoving() {
    _isMoving = false;
  }

  void shoot() {
    final now = game.currentTime();

    // Check if rapid fire is active
    final fireRate = game.isRapidFireActive
        ? gameState.fireRate *
              3.0 // Increased from 2.0 to 3.0
        : gameState.fireRate;
    final shotInterval = 1.0 / fireRate;

    if (now - _lastShot >= shotInterval) {
      _lastShot = now;

      // Create bullet(s)
      if (game.isLaserActive) {
        // Laser shoots multiple bullets
        for (int i = 0; i < 3; i++) {
          final bullet = Bullet(
            position: Vector2(
              position.x + (i - 1) * 10,
              position.y - size.y / 2,
            ),
            damage: gameState.damage * 1.5,
            isPlayerBullet: true,
          );
          game.add(bullet);
        }
      } else {
        // Normal bullet
        final bullet = Bullet(
          position: Vector2(position.x, position.y - size.y / 2),
          damage: gameState.damage,
          isPlayerBullet: true,
        );
        game.add(bullet);
      }

      // Play shoot sound
      game.audioManager.playShootSound();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    print('💥 Player ship collision detected!');
    print('💥 Collision with: ${other.runtimeType}');

    if (other is Enemy || other is Asteroid) {
      // Player hit by enemy or asteroid
      print('💔 Player hit by ${other.runtimeType}!');
      _playerHit();

      // Remove the enemy/asteroid
      other.removeFromParent();
    }
  }

  void _playerHit() {
    // Don't take damage if already invulnerable or shield is active
    if (_isInvulnerable) {
      print('🛡️ Player is already invulnerable, ignoring hit');
      return;
    }

    if (game.isShieldActive) {
      print('🛡️ Shield protected player from damage!');
      return;
    }

    // Player takes damage
    game.gameState.loseLife();
    print('💔 Player hit! Lives remaining: ${game.gameState.lives}');

    // Activate invulnerability immediately
    _isInvulnerable = true;
    _invulnerabilityTimer = 0;
    print(
      '🛡️ Player invulnerability activated for $_invulnerabilityDuration seconds',
    );

    // Play hit sound
    game.audioManager.playExplosionSound();

    // Visual feedback - flash red
    _flashRed();

    // Check for game over
    if (game.gameState.lives <= 0) {
      game.gameState.endGame();
      print('💀 Game Over!');
    }
  }

  void _flashRed() {
    // Simple visual feedback - could be enhanced with animation
    print('🔴 Player ship flashing red!');
  }
}
