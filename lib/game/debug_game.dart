import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Colors;
import '../models/game_state.dart';

class DebugGame extends FlameGame {
  DebugGame({required this.gameState});
  final GameState gameState;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    print('DebugGame: onLoad called, size = $size');

    // Add a bright red background to make sure we can see something
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2(size.x, size.y),
        paint: Paint()..color = const Color(0xFFFF0000),
      ),
    );

    print('DebugGame: Added red background');

    // Add a bright green rectangle in the center
    add(
      RectangleComponent(
        position: Vector2(size.x / 2 - 50, size.y / 2 - 50),
        size: Vector2(100, 100),
        paint: Paint()..color = const Color(0xFF00FF00),
      ),
    );

    print('DebugGame: Added green rectangle');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Add score to show the game is running
    if (!gameState.isPaused) {
      gameState.addScore(1);
    }
  }
}
