/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/game.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-02
/// Last modified: 2025-01-02
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class SimpleGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: SimpleGame()),
    );
  }
}

class SimpleGame extends FlameGame {
  late Color currentColor = Colors.black;

  double duration = 3.0;
  double time = 0.0;
  bool isWhite = false;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawColor(currentColor, BlendMode.src);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isWhite) {
      time += dt;
      if (time >= duration) {
        time = duration;
        isWhite = false;
      }
    } else {
      time -= dt;
      if (time <= 0) {
        time = 0;
        isWhite = true;
      }
    }
    currentColor =
        Color.lerp(Colors.black, Colors.white, time / duration) ?? Colors.black;
  }
}
