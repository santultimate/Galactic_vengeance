import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

enum BossType { basic, advanced, elite, finalBoss }

class Boss {
  Boss({
    required this.type,
    required this.position,
    required this.maxHealth,
    required this.maxPhases,
    required this.attackCooldown,
  }) : health = maxHealth,
       currentPhase = 1,
       attackTimer = 0,
       projectiles = [];
  final BossType type;
  final Vector2 position;
  double health;
  final double maxHealth;
  int currentPhase;
  final int maxPhases;
  double attackTimer;
  final double attackCooldown;
  List<Vector2> projectiles;

  void takeDamage(double damage) {
    health -= damage;
    if (health <= maxHealth * (maxPhases - currentPhase) / maxPhases) {
      currentPhase++;
    }
  }

  bool isDead() => health <= 0;

  void update(double dt, Vector2 playerPosition) {
    // Move with different patterns based on type
    switch (type) {
      case BossType.basic:
        _updateBasicMovement(dt, playerPosition);
        break;
      case BossType.advanced:
        _updateAdvancedMovement(dt, playerPosition);
        break;
      case BossType.elite:
        _updateEliteMovement(dt, playerPosition);
        break;
      case BossType.finalBoss:
        _updateFinalBossMovement(dt, playerPosition);
        break;
    }

    attackTimer += dt;

    // Update projectiles with different speeds based on type
    final projectileSpeed = type == BossType.finalBoss ? 200.0 : 150.0;
    for (int i = projectiles.length - 1; i >= 0; i--) {
      projectiles[i].y += projectileSpeed * dt;
      if (projectiles[i].y > 800) {
        projectiles.removeAt(i);
      }
    }

    // Attack patterns based on type and phase
    if (attackTimer >= attackCooldown) {
      _performAttack(playerPosition);
      attackTimer = 0;
    }
  }

  void _updateBasicMovement(double dt, Vector2 playerPosition) {
    // Simple movement towards player
    final direction = (playerPosition - position).normalized();
    position.add(direction * 50 * dt);
  }

  void _updateAdvancedMovement(double dt, Vector2 playerPosition) {
    // Zigzag movement
    final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final zigzag = sin(time * 2) * 100;
    final targetX = playerPosition.x + zigzag;
    final direction = Vector2(
      targetX - position.x,
      playerPosition.y - position.y,
    ).normalized();
    position.add(direction * 60 * dt);
  }

  void _updateEliteMovement(double dt, Vector2 playerPosition) {
    // Circular movement around player
    final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
    const radius = 150.0;
    final targetX = playerPosition.x + cos(time) * radius;
    final targetY = playerPosition.y + sin(time) * radius;
    final direction = Vector2(
      targetX - position.x,
      targetY - position.y,
    ).normalized();
    position.add(direction * 70 * dt);
  }

  void _updateFinalBossMovement(double dt, Vector2 playerPosition) {
    // Complex movement pattern
    final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final phase = (time / 5.0).floor() % 4; // 4 different phases

    switch (phase) {
      case 0: // Chase player
        final direction = (playerPosition - position).normalized();
        position.add(direction * 80 * dt);
        break;
      case 1: // Move to top
        position.y = lerpDouble(position.y, 50, dt * 2)!;
        break;
      case 2: // Move side to side
        final targetX = 200 + sin(time * 3) * 200;
        position.x = lerpDouble(position.x, targetX, dt * 3)!;
        break;
      case 3: // Retreat
        position.y = lerpDouble(position.y, 100, dt * 2)!;
        break;
    }
  }

  void _performAttack(Vector2 playerPosition) {
    switch (type) {
      case BossType.basic:
        _basicAttack(playerPosition);
        break;
      case BossType.advanced:
        _advancedAttack(playerPosition);
        break;
      case BossType.elite:
        _eliteAttack(playerPosition);
        break;
      case BossType.finalBoss:
        _finalAttack(playerPosition);
        break;
    }
  }

  void _basicAttack(Vector2 playerPosition) {
    // Simple straight projectile
    projectiles.add(Vector2(position.x, position.y + 50));
  }

  void _advancedAttack(Vector2 playerPosition) {
    // Multiple projectiles in a spread pattern
    for (int i = -2; i <= 2; i++) {
      projectiles.add(Vector2(position.x + i * 20, position.y + 50));
    }
  }

  void _eliteAttack(Vector2 playerPosition) {
    // Homing projectiles
    final direction = (playerPosition - position).normalized();
    projectiles.add(
      Vector2(position.x + direction.x * 30, position.y + direction.y * 30),
    );
  }

  void _finalAttack(Vector2 playerPosition) {
    // Complex pattern based on phase
    switch (currentPhase) {
      case 1:
        // Circular pattern
        for (int i = 0; i < 8; i++) {
          final angle = i * pi / 4;
          projectiles.add(
            Vector2(position.x + cos(angle) * 30, position.y + sin(angle) * 30),
          );
        }
        break;
      case 2:
        // Spiral pattern
        for (int i = 0; i < 6; i++) {
          final angle = i * pi / 3 + attackTimer * 2;
          projectiles.add(
            Vector2(position.x + cos(angle) * 40, position.y + sin(angle) * 40),
          );
        }
        break;
      case 3:
        // Cross pattern with homing
        final directions = [
          Vector2(0, 1),
          Vector2(1, 0),
          Vector2(0, -1),
          Vector2(-1, 0),
        ];
        for (final direction in directions) {
          projectiles.add(
            Vector2(
              position.x + direction.x * 30,
              position.y + direction.y * 30,
            ),
          );
        }
        break;
    }
  }

  void render(Canvas canvas) {
    // Draw boss based on type
    final bossPaint = Paint();
    final bossTextPaint = TextPaint(
      textDirection: TextDirection.ltr,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

    switch (type) {
      case BossType.basic:
        bossPaint.color = Colors.red;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(position.x, position.y),
            width: 60,
            height: 60,
          ),
          bossPaint,
        );
        bossTextPaint.render(
          canvas,
          'B1',
          Vector2(position.x - 15, position.y - 10),
        );
        break;
      case BossType.advanced:
        bossPaint.color = Colors.purple;
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset(position.x, position.y),
            width: 80,
            height: 80,
          ),
          bossPaint,
        );
        bossTextPaint.render(
          canvas,
          'B2',
          Vector2(position.x - 15, position.y - 10),
        );
        break;
      case BossType.elite:
        bossPaint.color = Colors.orange;
        canvas.drawCircle(Offset(position.x, position.y), 40, bossPaint);
        bossTextPaint.render(
          canvas,
          'B3',
          Vector2(position.x - 15, position.y - 10),
        );
        break;
      case BossType.finalBoss:
        bossPaint.color = Colors.black;
        canvas.drawCircle(Offset(position.x, position.y), 50, bossPaint);
        final borderPaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
        canvas.drawCircle(Offset(position.x, position.y), 50, borderPaint);
        bossTextPaint.render(
          canvas,
          'BF',
          Vector2(position.x - 15, position.y - 10),
        );
        break;
    }

    // Draw health bar
    const healthBarWidth = 100.0;
    const healthBarHeight = 10.0;
    final healthPercentage = health / maxHealth;

    // Background
    final bgPaint = Paint()..color = Colors.grey;
    canvas.drawRect(
      Rect.fromLTWH(
        position.x - healthBarWidth / 2,
        position.y - 70,
        healthBarWidth,
        healthBarHeight,
      ),
      bgPaint,
    );

    // Health
    final healthPaint = Paint()..color = Colors.green;
    canvas.drawRect(
      Rect.fromLTWH(
        position.x - healthBarWidth / 2,
        position.y - 70,
        healthBarWidth * healthPercentage,
        healthBarHeight,
      ),
      healthPaint,
    );

    // Draw projectiles
    final projectilePaint = Paint()..color = Colors.red;
    for (final projectile in projectiles) {
      canvas.drawCircle(Offset(projectile.x, projectile.y), 5, projectilePaint);
    }
  }
}

class BossFactory {
  static Boss createBoss(BossType type, Vector2 position) {
    switch (type) {
      case BossType.basic:
        return Boss(
          type: type,
          position: position,
          maxHealth: 100,
          maxPhases: 2,
          attackCooldown: 2.0,
        );
      case BossType.advanced:
        return Boss(
          type: type,
          position: position,
          maxHealth: 200,
          maxPhases: 3,
          attackCooldown: 1.5,
        );
      case BossType.elite:
        return Boss(
          type: type,
          position: position,
          maxHealth: 300,
          maxPhases: 3,
          attackCooldown: 1.0,
        );
      case BossType.finalBoss:
        return Boss(
          type: type,
          position: position,
          maxHealth: 500,
          maxPhases: 4,
          attackCooldown: 0.8,
        );
    }
  }
}
