import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Colors;
import '../models/game_state.dart';

class MinimalGame extends FlameGame {
  MinimalGame({required this.gameState});
  final GameState gameState;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    print('MinimalGame: onLoad called');
    print('MinimalGame: size = $size');

    // Add a simple red background
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: Vector2(size.x, size.y),
        paint: Paint()..color = const Color(0xFFFF0000),
      ),
    );

    print('MinimalGame: Added red background');
  }
}
