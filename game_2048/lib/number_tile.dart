/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/number_tile.dart
/// Email: convexwf@gmail.com
/// Created: 2024-01-04
/// Last modified: 2024-01-04
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/game_constants.dart';

class NumberTileComponent extends PositionComponent {
  int numberValue;
  Vector2 matrixPosition;
  late Vector2 paintPosition;

  final double tileSize = GameConstants.tileSize;
  final double tilePadding = GameConstants.tilePadding;
  final Offset offset;

  NumberTileComponent(this.numberValue, this.matrixPosition, this.offset) {
    paintPosition = _translatePosition(matrixPosition);
  }

  @override
  Future<void> onLoad() async {
    size = Vector2(tileSize, tileSize);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(paintPosition.x, paintPosition.y, tileSize, tileSize),
      const Radius.circular(10),
    );

    canvas.drawRRect(rect, paint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: numberValue.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        paintPosition.x + tileSize / 2 - textPainter.width / 2,
        paintPosition.y + tileSize / 2 - textPainter.height / 2,
      ),
    );
  }

  Vector2 _translatePosition(Vector2 position) {
    return position * (tileSize + tilePadding) + Vector2(offset.dx, offset.dy);
  }

  void moveTo(Vector2 newPosition) {
    // final MoveEffect moveEffect = MoveEffect.to(destination, controller)

    // matrixPosition = newPosition;
    // paintPosition = matrixPosition * (tileSize + tilePadding) +
    //     Vector2(offset.dx, offset.dy);
  }
}
