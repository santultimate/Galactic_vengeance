import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleApp());
}

class SimpleApp extends StatelessWidget {
  const SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('SimpleApp: build called'); // Debug log
    return MaterialApp(
      title: 'Simple Test',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const SimpleHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimpleHomePage extends StatelessWidget {
  const SimpleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('SimpleHomePage: build called'); // Debug log
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Simple Test'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SIMPLE TEST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'If you see this, Android rendering works!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


