import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/game_state.dart';
import 'screens/about_screen.dart';
import 'screens/game_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/upgrade_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Flame
  await Flame.device.setPortrait();

  runApp(const GalacticVengeanceApp());
}

class GalacticVengeanceApp extends StatelessWidget {
  const GalacticVengeanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'Galactic Vengeance',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          fontFamily: 'Orbitron',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainMenuScreen(),
          '/game': (context) => const GameScreen(),
          '/upgrades': (context) => const UpgradeScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/about': (context) => const AboutScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
