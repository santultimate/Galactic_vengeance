import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:math';

class Particle {
  Particle({
    required this.position,
    required this.velocity,
    required this.maxLife,
    required this.color,
    required this.size,
  }) : life = maxLife;
  Vector2 position;
  Vector2 velocity;
  double life;
  final double maxLife;
  final Color color;
  final double size;

  bool isDead() => life <= 0;

  void update(double dt) {
    position += velocity * dt;
    velocity *= 0.98; // Friction
    life -= dt;
  }

  void render(Canvas canvas) {
    final alpha = (life / maxLife).clamp(0.0, 1.0);
    final paint = Paint()..color = color.withOpacity(alpha);

    canvas.drawCircle(
      Offset(position.x, position.y),
      size * (life / maxLife),
      paint,
    );
  }
}

class Explosion {
  Explosion({required this.position, this.duration = 1.0}) : particles = [];
  List<Particle> particles;
  Vector2 position;
  double duration;

  void createParticles() {
    final random = Random();
    final particleCount = 15 + random.nextInt(10);

    for (int i = 0; i < particleCount; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final speed = 50 + random.nextDouble() * 100;
      final velocity = Vector2(cos(angle) * speed, sin(angle) * speed);

      final colors = [Colors.orange, Colors.red, Colors.yellow, Colors.white];

      particles.add(
        Particle(
          position: Vector2(position.x, position.y),
          velocity: velocity,
          maxLife: 0.5 + random.nextDouble() * 0.5,
          color: colors[random.nextInt(colors.length)],
          size: 3 + random.nextDouble() * 5,
        ),
      );
    }
  }

  void update(double dt) {
    for (int i = particles.length - 1; i >= 0; i--) {
      particles[i].update(dt);
      if (particles[i].isDead()) {
        particles.removeAt(i);
      }
    }
  }

  bool isDead() => particles.isEmpty;

  void render(Canvas canvas) {
    for (final particle in particles) {
      particle.render(canvas);
    }
  }
}

class EffectsManager {
  List<Explosion> explosions = [];

  void addExplosion(Vector2 position) {
    final explosion = Explosion(position: position);
    explosion.createParticles();
    explosions.add(explosion);
  }

  void update(double dt) {
    for (int i = explosions.length - 1; i >= 0; i--) {
      explosions[i].update(dt);
      if (explosions[i].isDead()) {
        explosions.removeAt(i);
      }
    }
  }

  void render(Canvas canvas) {
    for (final explosion in explosions) {
      explosion.render(canvas);
    }
  }
}
