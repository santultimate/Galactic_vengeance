/// Application constants and configuration values
class AppConstants {
  // App Information
  static const String appName = 'Galactic Vengeance';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Space arcade shooter game';

  // Game Configuration
  static const double playerSpeed = 300.0;
  static const double bulletSpeed = 500.0;
  static const double enemySpeed = 100.0;
  static const double asteroidSpeed = 80.0;
  static const double powerUpSpeed = 60.0;

  // Collision Detection
  static const double playerCollisionRadius = 25.0;
  static const double enemyCollisionRadius = 30.0;
  static const double asteroidCollisionRadius = 25.0;
  static const double bulletCollisionRadius = 5.0;
  static const double powerUpCollisionRadius = 15.0;

  // Game Mechanics
  static const int initialLives = 3;
  static const int initialScore = 0;
  static const int initialCoins = 0;
  static const int initialLevel = 1;

  // Scoring System
  static const int enemyDestroyScore = 10;
  static const int asteroidDestroyScore = 5;
  static const int bossDestroyScore = 100;
  static const int enemyDestroyCoins = 2;
  static const int asteroidDestroyCoins = 1;
  static const int bossDestroyCoins = 20;
  static const int powerUpCoins = 5;

  // Power-up Durations (in seconds)
  static const double shieldDuration = 8.0;
  static const double rapidFireDuration = 10.0;
  static const double laserDuration = 12.0;
  static const double speedBoostDuration = 12.0;
  static const double magnetDuration = 15.0;

  // Spawn Rates
  static const double enemySpawnRate = 0.08;
  static const double asteroidSpawnRate = 0.06;
  static const double powerUpSpawnRate = 0.02;
  static const double bossSpawnTime = 30.0;

  // UI Constants
  static const double hudHeight = 100.0;
  static const double topHudHeight = 80.0;
  static const double buttonHeight = 50.0;
  static const double buttonRadius = 10.0;

  // Colors
  static const int primaryColor = 0xFF1E3A8A; // Blue 800
  static const int secondaryColor = 0xFF059669; // Emerald 600
  static const int accentColor = 0xFFDC2626; // Red 600
  static const int backgroundColor = 0xFF000000; // Black
  static const int textColor = 0xFFFFFFFF; // White

  // Audio
  static const String backgroundMusicPath = 'audio/background_music.mp3';
  static const String shootSoundPath = 'audio/shoot.wav';
  static const String explosionSoundPath = 'audio/explosion.wav';
  static const String powerUpSoundPath = 'audio/powerup.wav';
  static const String bossSoundPath = 'audio/boss.wav';
  static const String buttonSoundPath = 'audio/button_click.wav';

  // Storage Keys
  static const String highScoreKey = 'high_score';
  static const String totalCoinsKey = 'total_coins';
  static const String currentLevelKey = 'current_level';
  static const String unlockedUpgradesKey = 'unlocked_upgrades';
  static const String settingsKey = 'settings';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 1000);

  // Screen Dimensions (for responsive design)
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
