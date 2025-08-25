import 'package:audioplayers/audioplayers.dart';
import '../constants/app_constants.dart';

/// Professional audio service for managing game sounds and music
class AudioService {
  factory AudioService() => _instance;
  AudioService._internal();
  static final AudioService _instance = AudioService._internal();

  late AudioPlayer _backgroundMusicPlayer;
  late AudioPlayer _soundEffectsPlayer;

  bool _isInitialized = false;
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  double _soundVolume = 0.8;
  double _musicVolume = 0.6;

  /// Initialize the audio service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _backgroundMusicPlayer = AudioPlayer();
    _soundEffectsPlayer = AudioPlayer();

    // Load settings
    _loadAudioSettings();

    _isInitialized = true;
  }

  /// Load audio settings from storage
  void _loadAudioSettings() {
    // This would typically load from a settings service
    // For now, using default values
    _soundEnabled = true;
    _musicEnabled = true;
    _soundVolume = 0.8;
    _musicVolume = 0.6;
  }

  /// Play background music
  Future<void> playBackgroundMusic() async {
    if (!_isInitialized || !_musicEnabled) return;

    try {
      await _backgroundMusicPlayer.play(
        AssetSource('audio/music/background_music.mp3'),
      );
      await _backgroundMusicPlayer.setVolume(_musicVolume);
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      // Handle error silently in production
      // In debug, you might want to log this
    }
  }

  /// Stop background music
  Future<void> stopBackgroundMusic() async {
    if (!_isInitialized) return;

    try {
      await _backgroundMusicPlayer.stop();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Pause background music
  Future<void> pauseBackgroundMusic() async {
    if (!_isInitialized) return;

    try {
      await _backgroundMusicPlayer.pause();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Resume background music
  Future<void> resumeBackgroundMusic() async {
    if (!_isInitialized || !_musicEnabled) return;

    try {
      await _backgroundMusicPlayer.resume();
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play shoot sound
  Future<void> playShootSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/shoot.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play explosion sound
  Future<void> playExplosionSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/explosion.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play power-up sound
  Future<void> playPowerUpSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/powerup.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play boss sound
  Future<void> playBossSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/boss.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play button click sound
  Future<void> playButtonSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(
        AssetSource('audio/sounds/button_click.mp3'),
      );
      await _soundEffectsPlayer.setVolume(
        _soundVolume * 0.5,
      ); // Lower volume for UI sounds
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play coin sound
  Future<void> playCoinSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/coin.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play game over sound
  Future<void> playGameOverSound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/game_over.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play victory sound
  Future<void> playVictorySound() async {
    if (!_isInitialized || !_soundEnabled) return;

    try {
      await _soundEffectsPlayer.play(AssetSource('audio/sounds/victory.mp3'));
      await _soundEffectsPlayer.setVolume(_soundVolume);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play boss music
  Future<void> playBossMusic() async {
    if (!_isInitialized || !_musicEnabled) return;

    try {
      await _backgroundMusicPlayer.stop();
      await _backgroundMusicPlayer.play(
        AssetSource('audio/music/boss_music.mp3'),
      );
      await _backgroundMusicPlayer.setVolume(_musicVolume);
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play menu music
  Future<void> playMenuMusic() async {
    if (!_isInitialized || !_musicEnabled) return;

    try {
      await _backgroundMusicPlayer.stop();
      await _backgroundMusicPlayer.play(
        AssetSource('audio/music/menu_music.mp3'),
      );
      await _backgroundMusicPlayer.setVolume(_musicVolume);
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Set sound enabled/disabled
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    // Save to settings
  }

  /// Set music enabled/disabled
  void setMusicEnabled(bool enabled) {
    _musicEnabled = enabled;
    if (!enabled) {
      pauseBackgroundMusic();
    } else {
      resumeBackgroundMusic();
    }
    // Save to settings
  }

  /// Set sound volume
  void setSoundVolume(double volume) {
    _soundVolume = volume.clamp(0.0, 1.0);
    // Save to settings
  }

  /// Set music volume
  void setMusicVolume(double volume) {
    _musicVolume = volume.clamp(0.0, 1.0);
    if (_isInitialized) {
      _backgroundMusicPlayer.setVolume(_musicVolume);
    }
    // Save to settings
  }

  /// Get current sound volume
  double get soundVolume => _soundVolume;

  /// Get current music volume
  double get musicVolume => _musicVolume;

  /// Check if sound is enabled
  bool get isSoundEnabled => _soundEnabled;

  /// Check if music is enabled
  bool get isMusicEnabled => _musicEnabled;

  /// Dispose resources
  Future<void> dispose() async {
    if (_isInitialized) {
      await _backgroundMusicPlayer.dispose();
      await _soundEffectsPlayer.dispose();
      _isInitialized = false;
    }
  }
}

/// Global audio service instance
final audioService = AudioService();
