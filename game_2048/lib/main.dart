/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/main.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-15
/// Last modified: 2025-01-02
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:game_2048/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/splash_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game 2048',
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/game": (context) => GameWidget(game: SimpleGame()),
      },
    );
  }
}
