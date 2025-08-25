import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../basic_game.dart';

class Explosion extends SpriteComponent with HasGameReference<BasicGame> {
  Explosion({required Vector2 position, required Vector2 size})
    : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    try {
      // Load explosion sprite
      final sprite = await Sprite.load(
        'sprites/explose.png',
        images: game.images,
      );
      this.sprite = sprite;

      print('💥 Explosion created successfully!');

      // Remove explosion after a short delay
      Future.delayed(const Duration(milliseconds: 800), () {
        removeFromParent();
      });
    } catch (e) {
      print('Failed to load explosion sprite: $e');
      // Fallback to simple circle
      add(
        CircleComponent(
          radius: size.x / 2,
          paint: Paint()..color = Colors.orange,
        ),
      );

      // Remove after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        removeFromParent();
      });
    }
  }
}
