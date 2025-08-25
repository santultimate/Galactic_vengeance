import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../basic_game.dart';

class StarField extends PositionComponent with HasGameReference<BasicGame> {
  final List<Star> stars = [];
  final int starCount = 50; // Reduced from 100 to 50
  final Random random = Random();
  bool _initialized = false;

  @override
  Future<void> onLoad() async {
    // Wait for game to be fully initialized
    await Future.delayed(const Duration(milliseconds: 100));

    // Initialize stars with game size
    _initializeStars();
  }

  void _initializeStars() {
    if (_initialized) return;

    // Use game size or default size
    final gameWidth = (game.size.x > 0 ? game.size.x : 400).toDouble();
    final gameHeight = (game.size.y > 0 ? game.size.y : 800).toDouble();

    // Create stars with different speeds and sizes
    for (int i = 0; i < starCount; i++) {
      stars.add(
        Star(
          position: Vector2(
            random.nextDouble() * gameWidth,
            random.nextDouble() * gameHeight,
          ),
          speed:
              50 +
              random.nextDouble() * 150, // Different speeds for parallax effect
          size: 1 + random.nextDouble() * 3, // Different sizes
          brightness: 0.3 + random.nextDouble() * 0.7, // Different brightness
        ),
      );
    }

    _initialized = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Initialize stars if not done yet
    if (!_initialized) {
      _initializeStars();
    }

    // Don't update if game is paused
    if (game.gameState.isPaused) return;

    // Update star positions
    for (final star in stars) {
      star.position.y += star.speed * dt;

      // Reset star to top when it goes off screen
      if (star.position.y > game.size.y + 10) {
        star.position.y = -10;
        star.position.x = random.nextDouble() * game.size.x;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Use game size or default size
    final gameWidth = (game.size.x > 0 ? game.size.x : 400).toDouble();
    final gameHeight = (game.size.y > 0 ? game.size.y : 800).toDouble();

    // Draw gradient background
    final paint = Paint();
    final rect = Rect.fromLTWH(0, 0, gameWidth, gameHeight);

    // Create space gradient (dark blue to black)
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF0A0A2A), // Dark blue
        const Color(0xFF000011), // Very dark blue
        const Color(0xFF000000), // Black
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw stars
    for (final star in stars) {
      final starPaint = Paint()
        ..color = Colors.white.withOpacity(star.brightness)
        ..style = PaintingStyle.fill;

      // Draw star as a small circle
      canvas.drawCircle(
        Offset(star.position.x, star.position.y),
        star.size,
        starPaint,
      );

      // Add glow effect for brighter stars
      if (star.brightness > 0.6) {
        final glowPaint = Paint()
          ..color = Colors.white.withOpacity(star.brightness * 0.3)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

        canvas.drawCircle(
          Offset(star.position.x, star.position.y),
          star.size * 2,
          glowPaint,
        );
      }
    }

    // Add some nebula-like effects
    _drawNebula(canvas, gameWidth, gameHeight);
  }

  void _drawNebula(Canvas canvas, double width, double height) {
    final nebulaPaint = Paint()
      ..color = const Color(0xFF1A1A4A).withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    // Draw a few nebula patches
    canvas.drawCircle(Offset(width * 0.2, height * 0.3), 100, nebulaPaint);

    canvas.drawCircle(Offset(width * 0.8, height * 0.7), 80, nebulaPaint);

    canvas.drawCircle(Offset(width * 0.5, height * 0.8), 120, nebulaPaint);
  }
}

class Star {
  Vector2 position;
  final double speed;
  final double size;
  final double brightness;

  Star({
    required this.position,
    required this.speed,
    required this.size,
    required this.brightness,
  });
}
