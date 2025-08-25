import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  factory SettingsService() => _instance;
  SettingsService._internal();
  static final SettingsService _instance = SettingsService._internal();

  // Settings par défaut
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _vibrationEnabled = true;
  double _soundVolume = 0.8;
  double _musicVolume = 0.6;
  String _controlType = 'Touch';
  bool _showFPS = false;
  bool _particleEffects = true;
  String _difficulty = 'Normal';

  // Getters
  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  double get soundVolume => _soundVolume;
  double get musicVolume => _musicVolume;
  String get controlType => _controlType;
  bool get showFPS => _showFPS;
  bool get particleEffects => _particleEffects;
  String get difficulty => _difficulty;

  // Charger les settings
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      _soundVolume = prefs.getDouble('soundVolume') ?? 0.8;
      _musicVolume = prefs.getDouble('musicVolume') ?? 0.6;
      _controlType = prefs.getString('controlType') ?? 'Touch';
      _showFPS = prefs.getBool('showFPS') ?? false;
      _particleEffects = prefs.getBool('particleEffects') ?? true;
      _difficulty = prefs.getString('difficulty') ?? 'Normal';

      print('🎛️ Settings chargés:');
      print('  🔊 Sound: $_soundEnabled (vol: $_soundVolume)');
      print('  🎵 Music: $_musicEnabled (vol: $_musicVolume)');
      print('  📳 Vibration: $_vibrationEnabled');
      print('  🎮 Control: $_controlType');
      print('  📊 Show FPS: $_showFPS');
      print('  ✨ Particles: $_particleEffects');
      print('  🎯 Difficulty: $_difficulty');
    } catch (e) {
      print('❌ Erreur lors du chargement des settings: $e');
    }
  }

  // Sauvegarder les settings
  Future<void> saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('soundEnabled', _soundEnabled);
      await prefs.setBool('musicEnabled', _musicEnabled);
      await prefs.setBool('vibrationEnabled', _vibrationEnabled);
      await prefs.setDouble('soundVolume', _soundVolume);
      await prefs.setDouble('musicVolume', _musicVolume);
      await prefs.setString('controlType', _controlType);
      await prefs.setBool('showFPS', _showFPS);
      await prefs.setBool('particleEffects', _particleEffects);
      await prefs.setString('difficulty', _difficulty);

      print('💾 Settings sauvegardés');
    } catch (e) {
      print('❌ Erreur lors de la sauvegarde des settings: $e');
    }
  }

  // Mettre à jour les settings
  void updateSoundEnabled(bool value) {
    _soundEnabled = value;
    saveSettings();
  }

  void updateMusicEnabled(bool value) {
    _musicEnabled = value;
    saveSettings();
  }

  void updateVibrationEnabled(bool value) {
    _vibrationEnabled = value;
    saveSettings();
  }

  void updateSoundVolume(double value) {
    _soundVolume = value;
    saveSettings();
  }

  void updateMusicVolume(double value) {
    _musicVolume = value;
    saveSettings();
  }

  void updateControlType(String value) {
    _controlType = value;
    saveSettings();
  }

  void updateShowFPS(bool value) {
    _showFPS = value;
    saveSettings();
  }

  void updateParticleEffects(bool value) {
    _particleEffects = value;
    saveSettings();
  }

  void updateDifficulty(String value) {
    _difficulty = value;
    saveSettings();
  }

  // Obtenir les paramètres de difficulté
  Map<String, dynamic> getDifficultySettings() {
    switch (_difficulty) {
      case 'Easy':
        return {
          'enemySpeed': 0.5,
          'enemySpawnRate': 0.7,
          'asteroidSpeed': 0.6,
          'asteroidSpawnRate': 0.8,
          'bossHealth': 50,
        };
      case 'Normal':
        return {
          'enemySpeed': 1.0,
          'enemySpawnRate': 1.0,
          'asteroidSpeed': 1.0,
          'asteroidSpawnRate': 1.0,
          'bossHealth': 100,
        };
      case 'Hard':
        return {
          'enemySpeed': 1.5,
          'enemySpawnRate': 1.3,
          'asteroidSpeed': 1.4,
          'asteroidSpawnRate': 1.2,
          'bossHealth': 150,
        };
      case 'Extreme':
        return {
          'enemySpeed': 2.0,
          'enemySpawnRate': 1.6,
          'asteroidSpeed': 1.8,
          'asteroidSpawnRate': 1.4,
          'bossHealth': 200,
        };
      default:
        return {
          'enemySpeed': 1.0,
          'enemySpawnRate': 1.0,
          'asteroidSpeed': 1.0,
          'asteroidSpawnRate': 1.0,
          'bossHealth': 100,
        };
    }
  }
}
