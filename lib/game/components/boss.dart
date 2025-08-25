import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:vector_math/vector_math.dart';
import 'bullet.dart';
import '../basic_game.dart';

class Boss extends SpriteComponent
    with CollisionCallbacks, HasGameReference<BasicGame> {
  Boss({required Vector2 position, required this.level})
    : health = 100 + (level * 50),
      super(position: position, size: Vector2(80, 80));
  final int level;

  double health;
  double _lastShot = 0;
  final double shotInterval = 1.0;

  @override
  Future<void> onLoad() async {
    // Add collision hitbox
    add(RectangleHitbox());

    // Load boss sprite
    try {
      print('Loading sprites/sprites/boss_final.png...');
      sprite = await Sprite.load(
        'sprites/sprites/boss_final.png',
        images: game.images,
      );
      print('Boss sprite loaded successfully!');
    } catch (e) {
      print('Failed to load sprites/sprites/boss_final.png: $e');
      // Fallback to rectangle if sprite loading fails
      add(
        RectangleComponent(
          size: size,
          paint: Paint()..color = const Color(0xFFFF00FF),
        ),
      );
      print('Using fallback rectangle for boss');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move down slowly
    position.y += 20 * dt;

    // Stop at certain position
    if (position.y > 150) {
      position.y = 150;
    }

    // Shoot frequently
    _lastShot += dt;
    if (_lastShot >= shotInterval) {
      _shoot();
      _lastShot = 0;
    }
  }

  void _shoot() {
    // Shoot multiple bullets in a pattern
    for (int i = 0; i < 3; i++) {
      final bullet = Bullet(
        position: Vector2(position.x + (i - 1) * 20, position.y + size.y / 2),
        damage: 2.0,
        isPlayerBullet: false,
      );

      game.add(bullet);
    }
  }

  void takeDamage(double damage) {
    health -= damage;

    if (health <= 0) {
      // Boss defeated
      // gameRef.addScore(1000);
      // gameRef.addCoins(100);
      removeFromParent();
    }
  }
}
