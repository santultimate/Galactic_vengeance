import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class FloatingText {
  FloatingText({
    required this.position,
    required this.text,
    required this.color,
    this.life = 2.0,
    this.maxLife = 2.0,
    Vector2? velocity,
    this.fontSize = 16,
  }) : velocity = velocity ?? Vector2(0, -50);
  final Vector2 position;
  final String text;
  final Color color;
  double life;
  final double maxLife;
  final Vector2 velocity;
  final double fontSize;

  void update(double dt) {
    life -= dt;
    position.add(velocity * dt);
  }

  bool isDead() => life <= 0;

  void render(Canvas canvas) {
    final alpha = (life / maxLife).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = color.withOpacity(alpha)
      ..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withOpacity(alpha),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: const Offset(1, 1),
              blurRadius: 2,
              color: const Color(0xFF000000).withOpacity(alpha),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        position.x - textPainter.width / 2,
        position.y - textPainter.height / 2,
      ),
    );
  }
}

class FloatingTextManager {
  final List<FloatingText> _texts = [];

  void addText(
    Vector2 position,
    String text,
    Color color, {
    double fontSize = 16,
  }) {
    _texts.add(
      FloatingText(
        position: Vector2(position.x, position.y),
        text: text,
        color: color,
        fontSize: fontSize,
      ),
    );
  }

  void addScoreText(Vector2 position, int score) {
    addText(
      position,
      '+$score',
      const Color(0xFFFFFF00), // Yellow
      fontSize: 18,
    );
  }

  void addCoinText(Vector2 position, int coins) {
    addText(
      position,
      '+$coins coins',
      const Color(0xFFFFC107), // Amber
      fontSize: 16,
    );
  }

  void update(double dt) {
    for (int i = _texts.length - 1; i >= 0; i--) {
      _texts[i].update(dt);
      if (_texts[i].isDead()) {
        _texts.removeAt(i);
      }
    }
  }

  void render(Canvas canvas) {
    for (final text in _texts) {
      text.render(canvas);
    }
  }
}
