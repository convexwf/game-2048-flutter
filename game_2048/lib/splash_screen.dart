/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/splash_screen.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-02
/// Last modified: 2025-01-02
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme.dark,
        showBefore: (BuildContext context) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Text(
                'Game 2048',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          );
        },
        onFinish: (BuildContext context) {
          Navigator.of(context).pushReplacementNamed('/game');
        },
      ),
    );
  }
}
