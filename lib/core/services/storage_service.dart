import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

/// Professional storage service for managing persistent data
class StorageService {
  factory StorageService() => _instance;
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();

  late SharedPreferences _prefs;

  /// Initialize the storage service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save high score
  Future<void> saveHighScore(int score) async {
    await _prefs.setInt(AppConstants.highScoreKey, score);
  }

  /// Get high score
  int getHighScore() {
    return _prefs.getInt(AppConstants.highScoreKey) ?? 0;
  }

  /// Save total coins
  Future<void> saveTotalCoins(int coins) async {
    await _prefs.setInt(AppConstants.totalCoinsKey, coins);
  }

  /// Get total coins
  int getTotalCoins() {
    return _prefs.getInt(AppConstants.totalCoinsKey) ?? 0;
  }

  /// Save current level
  Future<void> saveCurrentLevel(int level) async {
    await _prefs.setInt(AppConstants.currentLevelKey, level);
  }

  /// Get current level
  int getCurrentLevel() {
    return _prefs.getInt(AppConstants.currentLevelKey) ?? 1;
  }

  /// Save unlocked upgrades
  Future<void> saveUnlockedUpgrades(List<String> upgrades) async {
    await _prefs.setStringList(AppConstants.unlockedUpgradesKey, upgrades);
  }

  /// Get unlocked upgrades
  List<String> getUnlockedUpgrades() {
    return _prefs.getStringList(AppConstants.unlockedUpgradesKey) ?? [];
  }

  /// Save game settings
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _prefs.setString(AppConstants.settingsKey, jsonEncode(settings));
  }

  /// Get game settings
  Map<String, dynamic> getSettings() {
    final settingsString = _prefs.getString(AppConstants.settingsKey);
    if (settingsString != null) {
      try {
        return jsonDecode(settingsString) as Map<String, dynamic>;
      } catch (e) {
        return _getDefaultSettings();
      }
    }
    return _getDefaultSettings();
  }

  /// Get default settings
  Map<String, dynamic> _getDefaultSettings() {
    return {
      'soundEnabled': true,
      'musicEnabled': true,
      'vibrationEnabled': true,
      'soundVolume': 0.8,
      'musicVolume': 0.6,
      'difficulty': 'normal',
      'showFPS': false,
      'particleEffects': true,
    };
  }

  /// Clear all data
  Future<void> clearAllData() async {
    await _prefs.clear();
  }

  /// Check if first launch
  bool isFirstLaunch() {
    return _prefs.getBool('first_launch') ?? true;
  }

  /// Mark first launch as completed
  Future<void> markFirstLaunchComplete() async {
    await _prefs.setBool('first_launch', false);
  }

  /// Save game statistics
  Future<void> saveGameStats({
    required int gamesPlayed,
    required int totalScore,
    required int totalCoins,
    required int enemiesDestroyed,
    required int asteroidsDestroyed,
    required int bossesDefeated,
    required Duration totalPlayTime,
  }) async {
    final stats = {
      'gamesPlayed': gamesPlayed,
      'totalScore': totalScore,
      'totalCoins': totalCoins,
      'enemiesDestroyed': enemiesDestroyed,
      'asteroidsDestroyed': asteroidsDestroyed,
      'bossesDefeated': bossesDefeated,
      'totalPlayTime': totalPlayTime.inSeconds,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
    await _prefs.setString('game_stats', jsonEncode(stats));
  }

  /// Get game statistics
  Map<String, dynamic> getGameStats() {
    final statsString = _prefs.getString('game_stats');
    if (statsString != null) {
      try {
        return jsonDecode(statsString) as Map<String, dynamic>;
      } catch (e) {
        return _getDefaultGameStats();
      }
    }
    return _getDefaultGameStats();
  }

  /// Get default game statistics
  Map<String, dynamic> _getDefaultGameStats() {
    return {
      'gamesPlayed': 0,
      'totalScore': 0,
      'totalCoins': 0,
      'enemiesDestroyed': 0,
      'asteroidsDestroyed': 0,
      'bossesDefeated': 0,
      'totalPlayTime': 0,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }
}

/// Global storage service instance
final storageService = StorageService();
