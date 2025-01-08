/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/game_constants.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-04
/// Last modified: 2025-01-08
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flame/extensions.dart';

enum GameStatus {
  moved,
  notMoved,
  gameOver,
}

class GameConstants {
  // Size properties
  static const int gridSize = 4;
  static const double tileSize = 80;
  static const double tilePadding = 15;
  static const double gridBorderSize = 15;
  static const double shadowDepth = 4;

  // Animation properties
  static const double titleMoveDuration = 0.5;

  // Color properties
  static const Map<int, Color> numberColorMap = {
    2: Color(0xFFEAE0D5),
    4: Color(0xFFEEE4DA),
    8: Color(0xFFEDE0C8),
    16: Color(0xFFF2B179),
    32: Color(0xFFF59563),
    64: Color(0xFFF67C5F),
    128: Color(0xFFF65E3B),
    256: Color(0xFFEDCF72),
    512: Color(0xFFEDCC61),
    1024: Color(0xFFEDC850),
    2048: Color(0xFFEDC53F),
    4096: Color(0xFFEDC22E),
  };
}
