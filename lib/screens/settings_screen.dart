import 'package:flutter/material.dart';
import '../services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _vibrationEnabled = true;
  double _soundVolume = 0.8;
  double _musicVolume = 0.6;
  String _controlType = 'Touch';
  bool _showFPS = false;
  bool _particleEffects = true;
  String _difficulty = 'Normal';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    await SettingsService().loadSettings();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _musicEnabled = prefs.getBool('musicEnabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      _soundVolume = prefs.getDouble('soundVolume') ?? 0.8;
      _musicVolume = prefs.getDouble('musicVolume') ?? 0.6;
      _controlType = prefs.getString('controlType') ?? 'Touch';
      _showFPS = prefs.getBool('showFPS') ?? false;
      _particleEffects = prefs.getBool('particleEffects') ?? true;
      _difficulty = prefs.getString('difficulty') ?? 'Normal';
    });
  }

  void _saveSettings() async {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _resetSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A4A),
        title: const Text(
          'Reset Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to reset all settings to default?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset to default!'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('RESET', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A2A), Color(0xFF1A1A4A), Color(0xFF2A2A6A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'SETTINGS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 50), // Balance the back button
                  ],
                ),
              ),

              // Settings content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('AUDIO'),
                      _buildSwitchTile(
                        'Sound Effects',
                        'Enable sound effects',
                        Icons.volume_up,
                        _soundEnabled,
                        (value) {
                          setState(() => _soundEnabled = value);
                          SettingsService().updateSoundEnabled(value);
                          _saveSettings();
                        },
                      ),
                      _buildSliderTile(
                        'Sound Volume',
                        Icons.volume_up,
                        _soundVolume,
                        (value) {
                          setState(() => _soundVolume = value);
                          SettingsService().updateSoundVolume(value);
                          _saveSettings();
                        },
                      ),
                      _buildSwitchTile(
                        'Background Music',
                        'Enable background music',
                        Icons.music_note,
                        _musicEnabled,
                        (value) {
                          setState(() => _musicEnabled = value);
                          SettingsService().updateMusicEnabled(value);
                          _saveSettings();
                        },
                      ),
                      _buildSliderTile(
                        'Music Volume',
                        Icons.music_note,
                        _musicVolume,
                        (value) {
                          setState(() => _musicVolume = value);
                          SettingsService().updateMusicVolume(value);
                          _saveSettings();
                        },
                      ),
                      _buildSwitchTile(
                        'Vibration',
                        'Enable vibration feedback',
                        Icons.vibration,
                        _vibrationEnabled,
                        (value) {
                          setState(() => _vibrationEnabled = value);
                          SettingsService().updateVibrationEnabled(value);
                          _saveSettings();
                        },
                      ),

                      const SizedBox(height: 30),
                      _buildSectionTitle('CONTROLS'),
                      _buildDropdownTile(
                        'Control Type',
                        'Choose your preferred control method',
                        Icons.gamepad,
                        _controlType,
                        ['Touch', 'Joystick', 'Tilt'],
                        (value) {
                          setState(() => _controlType = value);
                          SettingsService().updateControlType(value);
                          _saveSettings();
                        },
                      ),

                      const SizedBox(height: 30),
                      _buildSectionTitle('GRAPHICS'),
                      _buildSwitchTile(
                        'Show FPS',
                        'Display frames per second',
                        Icons.speed,
                        _showFPS,
                        (value) {
                          setState(() => _showFPS = value);
                          SettingsService().updateShowFPS(value);
                          _saveSettings();
                        },
                      ),
                      _buildSwitchTile(
                        'Particle Effects',
                        'Enable visual particle effects',
                        Icons.blur_on,
                        _particleEffects,
                        (value) {
                          setState(() => _particleEffects = value);
                          SettingsService().updateParticleEffects(value);
                          _saveSettings();
                        },
                      ),

                      const SizedBox(height: 30),
                      _buildSectionTitle('GAMEPLAY'),
                      _buildDropdownTile(
                        'Difficulty',
                        'Set game difficulty level',
                        Icons.trending_up,
                        _difficulty,
                        ['Easy', 'Normal', 'Hard', 'Extreme'],
                        (value) {
                          setState(() => _difficulty = value);
                          SettingsService().updateDifficulty(value);
                          _saveSettings();
                        },
                      ),

                      const SizedBox(height: 30),
                      _buildSectionTitle('GAME DATA'),
                      _buildActionTile(
                        'Reset Progress',
                        'Reset all game progress and scores',
                        Icons.refresh,
                        Colors.red,
                        _resetGameProgress,
                      ),
                      _buildActionTile(
                        'Clear Cache',
                        'Clear game cache and temporary files',
                        Icons.cleaning_services,
                        Colors.orange,
                        _clearCache,
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),

              // Bottom buttons
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _resetSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.2),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.red, width: 2),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'RESET',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          foregroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.cyan,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 24),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.cyan,
          activeTrackColor: Colors.cyan.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    IconData icon,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Text(
                  '${(value * 100).round()}%',
                  style: const TextStyle(color: Colors.cyan, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.cyan,
              inactiveColor: Colors.white.withOpacity(0.3),
              min: 0.0,
              max: 1.0,
              divisions: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 24),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: DropdownButton<String>(
          value: value,
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
          dropdownColor: const Color(0xFF1A1A4A),
          style: const TextStyle(color: Colors.white),
          underline: Container(),
          items: options.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 24),
        title: Text(title, style: TextStyle(color: color, fontSize: 16)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
        onTap: onTap,
      ),
    );
  }

  void _resetGameProgress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A4A),
        title: const Text(
          'Reset Progress',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'This will reset all your progress, scores, and upgrades. This action cannot be undone!',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Reset game progress
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Game progress reset!'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('RESET', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    // TODO: Clear cache implementation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cache cleared!'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
