import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameState extends ChangeNotifier {
  GameState() {
    // Load data without notifying initially
    _loadGameDataSilent();
  }
  // Player stats
  int _currentLevel = 1;
  int _score = 0;
  int _highScore = 0;
  int _lives = 3;
  int _coins = 0;

  // Ship upgrades
  int _fireRateLevel = 1;
  int _damageLevel = 1;
  int _shieldLevel = 1;
  int _speedLevel = 1;
  int _magnetLevel = 1;

  // Game state
  bool _isPlaying = false;
  bool _isPaused = false;

  // Getters
  int get currentLevel => _currentLevel;
  int get score => _score;
  int get highScore => _highScore;
  int get lives => _lives;
  int get coins => _coins;
  int get fireRateLevel => _fireRateLevel;
  int get damageLevel => _damageLevel;
  int get shieldLevel => _shieldLevel;
  int get speedLevel => _speedLevel;
  int get magnetLevel => _magnetLevel;
  bool get isPlaying => _isPlaying;
  bool get isPaused => _isPaused;

  // Upgrade costs
  static const Map<String, List<int>> _upgradeCosts = {
    'fireRate': [100, 200, 400, 800, 1600],
    'damage': [150, 300, 600, 1200, 2400],
    'shield': [200, 400, 800, 1600, 3200],
    'speed': [100, 200, 400, 800, 1600],
    'magnet': [50, 100, 200, 400, 800],
  };

  // Load saved game data silently (without notifications)
  Future<void> _loadGameDataSilent() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLevel = prefs.getInt('currentLevel') ?? 1;
    _highScore = prefs.getInt('highScore') ?? 0;
    _coins = prefs.getInt('coins') ?? 0;
    _fireRateLevel = prefs.getInt('fireRateLevel') ?? 1;
    _damageLevel = prefs.getInt('damageLevel') ?? 1;
    _shieldLevel = prefs.getInt('shieldLevel') ?? 1;
    _speedLevel = prefs.getInt('speedLevel') ?? 1;
    _magnetLevel = prefs.getInt('magnetLevel') ?? 1;
  }

  // Load saved game data with notifications
  Future<void> _loadGameData() async {
    await _loadGameDataSilent();
    notifyListeners();
  }

  // Save game data
  Future<void> _saveGameData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLevel', _currentLevel);
    await prefs.setInt('highScore', _highScore);
    await prefs.setInt('coins', _coins);
    await prefs.setInt('fireRateLevel', _fireRateLevel);
    await prefs.setInt('damageLevel', _damageLevel);
    await prefs.setInt('shieldLevel', _shieldLevel);
    await prefs.setInt('speedLevel', _speedLevel);
    await prefs.setInt('magnetLevel', _magnetLevel);
  }

  // Game control methods
  void startGame() {
    print('🎮 startGame() called - setting isPlaying=true, isPaused=false');
    _isPlaying = true;
    _isPaused = false;
    _lives = 3;
    _score = 0;
    print(
      '🎮 Game state after startGame: isPlaying=$_isPlaying, isPaused=$_isPaused',
    );
    notifyListeners();
  }

  void pauseGame() {
    print('⏸️ pauseGame() called - setting isPaused=true');
    _isPaused = true;
    notifyListeners();
  }

  void resumeGame() {
    print('▶️ resumeGame() called - setting isPaused=false');
    _isPaused = false;
    notifyListeners();
  }

  void endGame() {
    print('💀 endGame() called - setting isPlaying=false, isPaused=false');
    _isPlaying = false;
    _isPaused = false;
    if (_score > _highScore) {
      _highScore = _score;
    }
    _saveGameData();
    notifyListeners();
  }

  // Score and progression methods
  void addScore(int points) {
    _score += points;
    // Notify immediately for better responsiveness
    notifyListeners();
  }

  void addCoins(int amount) {
    _coins += amount;
    _saveGameData();
    notifyListeners();
  }

  void loseLife() {
    _lives--;
    if (_lives <= 0) {
      endGame();
    }
    notifyListeners();
  }

  void nextLevel() {
    _currentLevel++;
    _saveGameData();
    notifyListeners();
  }

  // Upgrade methods
  bool canUpgrade(String upgradeType) {
    final costs = _upgradeCosts[upgradeType];
    if (costs == null) return false;

    int currentLevel;
    switch (upgradeType) {
      case 'fireRate':
        currentLevel = _fireRateLevel;
        break;
      case 'damage':
        currentLevel = _damageLevel;
        break;
      case 'shield':
        currentLevel = _shieldLevel;
        break;
      case 'speed':
        currentLevel = _speedLevel;
        break;
      case 'magnet':
        currentLevel = _magnetLevel;
        break;
      default:
        return false;
    }

    if (currentLevel >= costs.length) return false;
    return _coins >= costs[currentLevel - 1];
  }

  bool upgrade(String upgradeType) {
    if (!canUpgrade(upgradeType)) return false;

    final costs = _upgradeCosts[upgradeType]!;
    int currentLevel;

    switch (upgradeType) {
      case 'fireRate':
        currentLevel = _fireRateLevel;
        _fireRateLevel++;
        break;
      case 'damage':
        currentLevel = _damageLevel;
        _damageLevel++;
        break;
      case 'shield':
        currentLevel = _shieldLevel;
        _shieldLevel++;
        break;
      case 'speed':
        currentLevel = _speedLevel;
        _speedLevel++;
        break;
      case 'magnet':
        currentLevel = _magnetLevel;
        _magnetLevel++;
        break;
      default:
        return false;
    }

    _coins -= costs[currentLevel - 1];
    _saveGameData();
    notifyListeners();
    return true;
  }

  // Get upgrade cost
  int getUpgradeCost(String upgradeType) {
    final costs = _upgradeCosts[upgradeType];
    if (costs == null) return 0;

    int currentLevel;
    switch (upgradeType) {
      case 'fireRate':
        currentLevel = _fireRateLevel;
        break;
      case 'damage':
        currentLevel = _damageLevel;
        break;
      case 'shield':
        currentLevel = _shieldLevel;
        break;
      case 'speed':
        currentLevel = _speedLevel;
        break;
      case 'magnet':
        currentLevel = _magnetLevel;
        break;
      default:
        return 0;
    }

    if (currentLevel >= costs.length) return 0;
    return costs[currentLevel - 1];
  }

  // Get current stats
  double get fireRate => 1.0 + (_fireRateLevel - 1) * 0.2;
  double get damage => 1.0 + (_damageLevel - 1) * 0.3;
  int get maxHealth => 3 + (_shieldLevel - 1) * 2;
  double get speed => 1.0 + (_speedLevel - 1) * 0.15;
  double get magnetRadius => 50.0 + (_magnetLevel - 1) * 20.0;
}
