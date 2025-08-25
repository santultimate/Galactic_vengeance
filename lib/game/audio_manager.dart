import 'package:audioplayers/audioplayers.dart';
import '../services/settings_service.dart';

/// Simple audio manager for the game
class AudioManager {
  factory AudioManager() => _instance;
  AudioManager._internal();
  static final AudioManager _instance = AudioManager._internal();

  late AudioPlayer _soundPlayer;
  late AudioPlayer _musicPlayer;
  bool _isInitialized = false;

  /// Initialize the audio manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    print('🎵 Initializing AudioManager...');

    try {
      _soundPlayer = AudioPlayer();
      _musicPlayer = AudioPlayer();

      print('✅ AudioManager initialized successfully');
      print('  📱 Sound Player: ${_soundPlayer.playerId}');
      print('  📱 Music Player: ${_musicPlayer.playerId}');

      _isInitialized = true;
    } catch (e) {
      print('❌ Failed to initialize AudioManager: $e');
    }
  }

  /// Play shoot sound
  Future<void> playShootSound() async {
    if (!SettingsService().soundEnabled) return;
    if (!_isInitialized) {
      print('❌ AudioManager not initialized for shoot sound');
      return;
    }

    try {
      print('🔫 Playing shoot sound...');
      await _soundPlayer.play(AssetSource('audio/sounds/shoot.mp3'));
      print('✅ Shoot sound played successfully');
    } catch (e) {
      print('❌ Failed to play shoot sound: $e');
    }
  }

  /// Play explosion sound
  Future<void> playExplosionSound() async {
    if (!SettingsService().soundEnabled) return;
    if (!_isInitialized) {
      print('❌ AudioManager not initialized for explosion sound');
      return;
    }

    try {
      print('💥 Playing explosion sound...');
      await _soundPlayer.play(AssetSource('audio/sounds/explosion.mp3'));
      print('✅ Explosion sound played successfully');
    } catch (e) {
      print('❌ Failed to play explosion sound: $e');
    }
  }

  /// Play power-up collection sound
  Future<void> playPowerUpSound() async {
    try {
      await _soundPlayer.play(AssetSource('audio/sounds/powerup.mp3'));
    } catch (e) {
      print('Failed to play power-up sound: $e');
    }
  }

  /// Play coin sound
  Future<void> playCoinSound() async {
    if (!SettingsService().soundEnabled) return;
    if (!_isInitialized) {
      print('❌ AudioManager not initialized for coin sound');
      return;
    }

    try {
      print('🪙 Playing coin sound...');
      await _soundPlayer.play(AssetSource('audio/sounds/coin.mp3'));
      print('✅ Coin sound played successfully');
    } catch (e) {
      print('❌ Failed to play coin sound: $e');
    }
  }

  /// Play game over sound
  Future<void> playGameOverSound() async {
    if (!_isInitialized) return;

    try {
      await _soundPlayer.play(AssetSource('audio/sounds/game_over.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play victory sound
  Future<void> playVictorySound() async {
    if (!_isInitialized) return;

    try {
      await _soundPlayer.play(AssetSource('audio/sounds/victory.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play boss sound
  Future<void> playBossSound() async {
    if (!SettingsService().soundEnabled) return;
    if (!_isInitialized) {
      print('❌ AudioManager not initialized for boss sound');
      return;
    }

    try {
      print('👹 Playing boss sound...');
      await _soundPlayer.play(AssetSource('audio/sounds/boss.mp3'));
      print('✅ Boss sound played successfully');
    } catch (e) {
      print('❌ Failed to play boss sound: $e');
    }
  }

  /// Play background music
  Future<void> playBackgroundMusic() async {
    if (!SettingsService().musicEnabled) return;
    if (!_isInitialized) {
      print('❌ AudioManager not initialized for background music');
      return;
    }

    try {
      print('🎵 Playing background music...');
      await _musicPlayer.play(AssetSource('audio/music/background_music.mp3'));
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      print('✅ Background music started successfully (loop mode)');
    } catch (e) {
      print('❌ Failed to play background music: $e');
    }
  }

  /// Play boss music
  Future<void> playBossMusic() async {
    if (!_isInitialized) return;

    try {
      await _musicPlayer.stop();
      await _musicPlayer.play(AssetSource('audio/music/boss_music.mp3'));
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Stop music
  Future<void> stopMusic() async {
    if (!_isInitialized) return;

    try {
      await _musicPlayer.stop();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Pause music
  Future<void> pauseMusic() async {
    if (!_isInitialized) return;

    try {
      await _musicPlayer.pause();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Resume music
  Future<void> resumeMusic() async {
    if (!_isInitialized) return;

    try {
      await _musicPlayer.resume();
    } catch (e) {
      // Handle error silently
    }
  }
}
