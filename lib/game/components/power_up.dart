import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import '../basic_game.dart';
import 'player_ship.dart';

class PowerUp extends PositionComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  PowerUp({required Vector2 position, required this.type})
    : super(position: position, size: Vector2(25, 25)); // Increased from 20x20
  final String type;
  SpriteComponent? spriteComponent;

  @override
  Future<void> onLoad() async {
    // Add collision hitbox - positioned correctly
    add(RectangleHitbox(size: Vector2(25, 25), position: Vector2.zero()));

    // Load power-up sprite
    try {
      print('🔍 Loading sprites/powerup_${type}.png...');
      final sprite = await Sprite.load(
        'sprites/powerup_${type}.png',
        images: game.images,
      );
      spriteComponent = SpriteComponent(
        sprite: sprite,
        size: Vector2(25, 25), // Explicit size for power-up
        position: Vector2.zero(),
      );
      add(spriteComponent!);
      print(
        'Power-up sprite loaded successfully! Size: ${spriteComponent!.size}',
      );
    } catch (e) {
      print('Failed to load sprites/powerup_${type}.png: $e');
      // Fallback to colored rectangle with explicit size
      add(
        RectangleComponent(
          size: Vector2(25, 25), // Explicit size for fallback
          paint: Paint()..color = _getColor(),
        ),
      );
      print('Using fallback rectangle for power-up');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Move down slowly
    position.y += 50 * dt;

    // Remove if off screen (use actual game size)
    if (position.y > game.size.y + size.y) {
      removeFromParent();
    }
  }

  Color _getColor() {
    switch (type) {
      case 'shield':
        return const Color(0xFF0000FF);
      case 'rapid_fire':
        return const Color(0xFFFF0000);
      case 'laser':
        return const Color(0xFF00FFFF);
      case 'speed':
        return const Color(0xFF00FF00);
      default:
        return const Color(0xFFFFFF00);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    print('💥 Power-up collision detected!');
    print('💥 Collision with: ${other.runtimeType}');

    // Handle power-up collection
    if (other is PlayerShip) {
      print('⚡ Power-up collected by player!');
      // Apply power-up effect
      applyPowerUp();
      removeFromParent();
    }
  }

  void applyPowerUp() {
    print('⚡ Power-up collected: $type');

    switch (type) {
      case 'shield':
        game.activateShield();
        break;
      case 'rapid_fire':
        game.activateRapidFire();
        break;
      case 'laser':
        game.activateLaser();
        break;
      case 'speed':
        game.activateSpeedBoost();
        break;
    }

    // Add coins and score
    game.gameState.addCoins(5);
    game.gameState.addScore(50);

    // Play power-up sound
    game.audioManager.playPowerUpSound();
  }
}
