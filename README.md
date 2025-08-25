# 🚀 Galactic Vengeance

A professional space arcade shooter game built with Flutter and Flame engine.

## 📱 Features

### 🎮 Core Gameplay
- **Space Combat**: Intense arcade-style shooting action
- **Progressive Levels**: 50 levels with increasing difficulty
- **Boss Battles**: Unique alien bosses with complex attack patterns
- **Power-ups**: Real-time power-ups (Shield, Rapid Fire, Laser, Speed Boost, Magnet)
- **RPG Elements**: Ship upgrades and progression system

### 🎯 Game Mechanics
- **Touch Controls**: Intuitive touch and drag controls
- **Collision Detection**: Precise collision system
- **Scoring System**: Dynamic scoring with multipliers
- **Life System**: Heart-based health system
- **Coin Collection**: In-game currency system

### 🎨 Visual & Audio
- **Particle Effects**: Stunning visual effects
- **Background Music**: Immersive space-themed soundtrack
- **Sound Effects**: High-quality audio feedback
- **Responsive Design**: Optimized for all screen sizes

### ⚙️ Technical Features
- **State Management**: Provider-based architecture
- **Data Persistence**: Local save system
- **Performance Optimized**: 60 FPS gameplay
- **Cross-Platform**: iOS, Android, Web, Desktop support

## 🛠️ Technology Stack

- **Framework**: Flutter 3.32+
- **Game Engine**: Flame 1.16+
- **State Management**: Provider 6.1+
- **Audio**: AudioPlayers 6.5+
- **Storage**: SharedPreferences 2.2+
- **UI**: Material Design 3
- **Code Quality**: Flutter Lints 6.0+

## 📋 Requirements

- Flutter SDK: ^3.8.1
- Dart SDK: ^3.8.1
- Android: API 21+ (Android 5.0+)
- iOS: 12.0+
- Web: Modern browsers
- Desktop: Windows 10+, macOS 10.14+, Linux

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/galactic-vengeance.git
   cd galactic-vengeance
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the game**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── services/
│   │   ├── audio_service.dart
│   │   ├── storage_service.dart
│   │   └── logger_service.dart
│   └── utils/
│       └── device_utils.dart
├── game/
│   ├── components/
│   │   ├── player_ship.dart
│   │   ├── enemy.dart
│   │   ├── asteroid.dart
│   │   ├── bullet.dart
│   │   ├── power_up.dart
│   │   └── boss.dart
│   ├── basic_game.dart
│   ├── boss_system.dart
│   └── floating_text.dart
├── models/
│   └── game_state.dart
├── screens/
│   ├── main_menu_screen.dart
│   ├── game_screen.dart
│   ├── game_over_screen.dart
│   ├── upgrade_screen.dart
│   ├── settings_screen.dart
│   └── about_screen.dart
└── main.dart
```

## 🎮 Game Controls

- **Move Ship**: Touch and drag on screen
- **Shoot**: Automatically shoots while touching
- **Pause**: Tap pause button in top-right corner
- **Resume**: Tap "REPRENDRE" in pause menu
- **Quit**: Tap "QUITTER" in pause menu

## 🏆 Scoring System

- **Enemy Destroyed**: +10 points, +2 coins
- **Asteroid Destroyed**: +5 points, +1 coin
- **Boss Defeated**: +100 points, +20 coins
- **Power-up Collected**: +5 coins
- **Survival Bonus**: +1 point per second

## 🔧 Configuration

### Game Settings
- **Sound Effects**: Enable/disable sound effects
- **Background Music**: Enable/disable background music
- **Vibration**: Enable/disable haptic feedback
- **Volume Control**: Adjust sound and music volume
- **Difficulty**: Easy, Normal, Hard modes
- **Graphics**: FPS display, particle effects toggle

### Performance Settings
- **Target FPS**: 60 FPS
- **Particle Limit**: Configurable particle count
- **Audio Quality**: High-quality audio processing
- **Memory Management**: Automatic resource cleanup

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Performance Testing
```bash
flutter run --profile
```

## 📦 Building

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## 🔄 Development Workflow

1. **Feature Development**
   - Create feature branch from `main`
   - Implement feature with tests
   - Run linting and tests
   - Create pull request

2. **Code Quality**
   - Follow Dart/Flutter style guide
   - Use meaningful commit messages
   - Add documentation for new features
   - Maintain test coverage

3. **Release Process**
   - Update version in `pubspec.yaml`
   - Update changelog
   - Create release tag
   - Build and distribute

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flame Engine**: For the excellent 2D game engine
- **Flutter Team**: For the amazing cross-platform framework
- **Community**: For feedback and contributions

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/galactic-vengeance/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/galactic-vengeance/discussions)
- **Email**: support@galacticvengeance.com

## 📈 Roadmap

### Version 1.1
- [ ] Multiplayer support
- [ ] Leaderboards
- [ ] Achievements system
- [ ] More boss types

### Version 1.2
- [ ] Story mode
- [ ] Character customization
- [ ] Weapon upgrades
- [ ] Special abilities

### Version 2.0
- [ ] 3D graphics
- [ ] VR support
- [ ] Cross-platform multiplayer
- [ ] Modding support

---

**Made with ❤️ using Flutter and Flame**
