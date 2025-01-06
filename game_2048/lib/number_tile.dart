/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/number_tile.dart
/// Email: convexwf@gmail.com
/// Created: 2024-01-04
/// Last modified: 2025-01-06
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/game_constants.dart';

class NumberTileComponent extends PositionComponent {
  int numberValue;
  Vector2 matrixPosition;

  final double tileSize = GameConstants.tileSize;
  final double tilePadding = GameConstants.tilePadding;
  final Offset offset;

  NumberTileComponent(this.numberValue, this.matrixPosition, this.offset);

  @override
  Future<void> onLoad() async {
    position = _translatePosition(matrixPosition);
    debugPrint('NumberTileComponent $matrixPosition, $position');
    size = Vector2(tileSize, tileSize);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, tileSize, tileSize),
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
        tileSize / 2 - textPainter.width / 2,
        tileSize / 2 - textPainter.height / 2,
      ),
    );
  }

  Vector2 _translatePosition(Vector2 position) {
    return Vector2(position.y, position.x) * (tileSize + tilePadding) +
        Vector2(offset.dx, offset.dy);
  }

  void moveTo(Vector2 newPosition, bool isMerged, bool isRemoved) {
    matrixPosition = newPosition;
    final Vector2 newPaintPosition = _translatePosition(newPosition);
    final MoveEffect moveEffect = MoveEffect.to(
        newPaintPosition,
        EffectController(
          duration: 0.5,
        ));
    add(moveEffect);
    moveEffect.onComplete = () {
      if (isMerged) {
        numberValue *= 2;
      }
      if (isRemoved) {
        removeFromParent();
      }
    };
  }
}
