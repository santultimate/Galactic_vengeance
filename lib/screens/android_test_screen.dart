import 'package:flutter/material.dart';

class AndroidTestScreen extends StatelessWidget {
  const AndroidTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('AndroidTestScreen: build called'); // Debug log

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Android Test'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ANDROID TEST',
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
      ),
    );
  }
}


