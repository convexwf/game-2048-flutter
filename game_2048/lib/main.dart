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

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class SimpleGame extends FlameGame {
  late Color currentColor = Colors.black;

  double time = 0.0;
  bool isWhite = false;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawColor(Colors.black, BlendMode.src);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isWhite) {
      time += dt;
      if (time >= 3) {
        time = 0;
        isWhite = false;
      }
      currentColor =
          Color.lerp(Colors.black, Colors.white, time / 3) ?? Colors.black;
    } else {
      time += dt;
      if (time >= 3) {
        time = 0;
        isWhite = true;
      }
      currentColor =
          Color.lerp(Colors.white, Colors.black, time / 3) ?? Colors.black;
    }
  }
}

void main() {
  runApp(GameWidget(game: SimpleGame()));
}
