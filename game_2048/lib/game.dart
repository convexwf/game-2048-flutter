/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/game.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-02
/// Last modified: 2024-01-02
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class SimpleGameScreen extends StatelessWidget {
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
    // canvas.drawColor(currentColor, BlendMode.src);

    final int gridSize = 4;
    final int tileSize = 80;
    final double tilePadding = 15;
    final double borderSize = 15;
    final double shadowDepth = 4;

    final double backgoundRectSize =
        gridSize * (tileSize + tilePadding) - tilePadding + 2 * borderSize;
    Offset offset = Offset(10, 10);

    // Draw the background rect shadow (must paint first)
    final backgroundRectShadow = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx + shadowDepth,
        offset.dy + shadowDepth,
        backgoundRectSize,
        backgoundRectSize,
      ),
      const Radius.circular(15),
    );
    final paint = Paint()..style = PaintingStyle.fill;
    canvas.drawRRect(
        backgroundRectShadow, paint..color = const Color(0xFFCAB28D));
    // Draw the background rect
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        offset.dx,
        offset.dy,
        backgoundRectSize,
        backgoundRectSize,
      ),
      const Radius.circular(15),
    );
    canvas.drawRRect(backgroundRect, paint..color = Colors.orange[100]!);
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
