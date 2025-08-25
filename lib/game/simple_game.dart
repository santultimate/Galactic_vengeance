import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Colors;
import '../models/game_state.dart';

class SimpleGame extends FlameGame {
  SimpleGame({required this.gameState});
  final GameState gameState;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add a simple background with explicit position
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2(size.x, size.y),
        paint: Paint()..color = const Color(0xFF0A0A2A),
      ),
    );

    // Add a simple player ship
    add(
      RectangleComponent(
        position: Vector2(size.x / 2 - 20, size.y - 100),
        size: Vector2(40, 40),
        paint: Paint()..color = const Color(0xFF00FF00),
      ),
    );

    // Add some stars
    for (int i = 0; i < 50; i++) {
      add(
        CircleComponent(
          position: Vector2((i * 7) % size.x, (i * 11) % size.y),
          radius: 1,
          paint: Paint()..color = const Color(0xFFFFFFFF),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Simple game logic
    if (gameState.isPaused) return;

    // Add score over time
    gameState.addScore(1);
  }
}
