import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Colors;
import '../models/game_state.dart';

class StableGame extends FlameGame {
  StableGame({required this.gameState});
  final GameState gameState;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add background
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2(size.x, size.y),
        paint: Paint()..color = const Color(0xFF0A0A2A),
      ),
    );

    // Add player ship
    add(
      RectangleComponent(
        position: Vector2(size.x / 2 - 20, size.y - 100),
        size: Vector2(40, 40),
        paint: Paint()..color = const Color(0xFF00FF00),
      ),
    );

    // Add stars (fewer to avoid performance issues)
    for (int i = 0; i < 20; i++) {
      add(
        CircleComponent(
          position: Vector2((i * 15) % size.x, (i * 20) % size.y),
          radius: 1,
          paint: Paint()..color = const Color(0xFFFFFFFF),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Simple game logic - add score slowly
    if (!gameState.isPaused) {
      // Add score every second
      gameState.addScore(1);
    }
  }
}
