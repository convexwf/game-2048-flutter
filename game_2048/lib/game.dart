/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/game.dart
/// Email: convexwf@gmail.com
/// Created: 2025-01-02
/// Last modified: 2025-01-13
///
/// This code is licensed under MIT license (see LICENSE for details)

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_2048/game_constants.dart';
import 'package:game_2048/number_matrix_handler.dart';
import 'package:game_2048/number_tile.dart';

class SimpleGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: SimpleGame()),
    );
  }
}

class SimpleGame extends FlameGame with KeyboardHandler, DragCallbacks {
  final int gridSize = GameConstants.gridSize;
  final double borderSize = GameConstants.gridBorderSize;
  final double tileSize = GameConstants.tileSize;
  final double tilePadding = GameConstants.tilePadding;

  late List<List<NumberTileComponent?>> grid;
  late NumberMatrixHandler matrixHandler;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // final viewport = FixedResolutionViewport(resolution: Vector2(400, 400));
    // camera.viewport = viewport;

    matrixHandler = NumberMatrixHandler.random(
        randomSeed: DateTime.now().millisecondsSinceEpoch);
    // generate grid according to matrix
    grid = List.generate(
      gridSize,
      (i) => List.generate(
        gridSize,
        (j) {
          final int value = matrixHandler.matrix[i][j];
          if (value == 0) {
            return null;
          }
          final numberTile = NumberTileComponent(
            value,
            Vector2(i.toDouble(), j.toDouble()),
            Offset(
              10 + borderSize,
              10 + borderSize,
            ),
          );
          add(numberTile);
          return numberTile;
        },
      ),
    );

    // add(KeyboardListenerComponent(
    debugPrint(matrixHandler.matrix.toString());

    // ))
  }

  Vector2 dragEvent = Vector2.zero();

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    dragEvent = Vector2.zero();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    dragEvent += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    const double threshold = 20;
    if (dragEvent.length > threshold) {
      if (dragEvent.x.abs() > dragEvent.y.abs()) {
        if (dragEvent.x > 0) {
          debugPrint('received right');
          _move(MoveDirection.right);
        } else {
          debugPrint('received left');
          _move(MoveDirection.left);
        }
      } else {
        if (dragEvent.y > 0) {
          debugPrint('received down');
          _move(MoveDirection.down);
        } else {
          debugPrint('received up');
          _move(MoveDirection.up);
        }
      }
    }
  }

  void _move(MoveDirection direction) {
    if (matrixHandler.move(direction) != GameStatus.moved) {
      return;
    }
    for (int i = 0; i < matrixHandler.moveSituationList.length; i++) {
      final moveSituation = matrixHandler.moveSituationList[i];
      debugPrint('moveSituation: $moveSituation');
      final int row = moveSituation.source.x;
      final int col = moveSituation.source.y;
      final int newRow = moveSituation.target.x;
      final int newCol = moveSituation.target.y;
      final bool isMerged = moveSituation.isMerged;
      final bool isRemoved = moveSituation.isRemoved;

      final NumberTileComponent? numberTile = grid[row][col];
      if (numberTile == null) {
        grid[row][col] = NumberTileComponent(
          matrixHandler.matrix[row][col],
          Vector2(row.toDouble(), col.toDouble()),
          Offset(
            10 + borderSize,
            10 + borderSize,
          ),
        );
        add(grid[row][col]!);
        continue;
      }
      numberTile.moveTo(
        Vector2(newRow.toDouble(), newCol.toDouble()),
        isMerged,
        isRemoved,
      );

      if (isRemoved) {
        grid[row][col] = null;
      } else if (isMerged) {
        grid[row][col] = null;
        grid[newRow][newCol] = numberTile;
      } else {
        grid[row][col] = null;
        grid[newRow][newCol] = numberTile;
      }
    }

    // list all the number handles
    debugPrint('------number handles------');
    debugPrint(matrixHandler.matrix.toString());

    // list all the number tiles
    debugPrint('------number tiles------');
    for (int i = 0; i < grid.length; i++) {
      String info = "";
      for (int j = 0; j < grid[i].length; j++) {
        final NumberTileComponent? numberTile = grid[i][j];
        if (numberTile == null) {
          info += 'null ';
          continue;
        }
        info += '${numberTile.numberValue} ';
      }
      debugPrint(info);
    }
  }

  @override
  void render(Canvas canvas) {
    // canvas.drawColor(currentColor, BlendMode.src);

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
    canvas.drawRRect(backgroundRect, paint..color = const Color(0xFFFFE0B2));

    // Draw the tiles
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            offset.dx + borderSize + j * (tileSize + tilePadding),
            offset.dy + borderSize + i * (tileSize + tilePadding),
            tileSize,
            tileSize,
          ),
          const Radius.circular(10),
        );
        canvas.drawRRect(rect.shift(Offset(shadowDepth, shadowDepth)),
            paint..color = Colors.black.withValues(alpha: 0.2));
        canvas.drawRRect(rect, paint..color = Colors.white);
        // final int value = 32;
        // final textSpan = TextSpan(
        //   text: value.toString(),
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //   ),
        // );
        // final textPainter = TextPainter(
        //   text: textSpan,
        //   textDirection: TextDirection.ltr,
        //   textAlign: TextAlign.center,
        // );
        // textPainter.layout(
        //   minWidth: tileSize,
        //   maxWidth: tileSize,
        // );
        // textPainter.paint(
        //   canvas,
        //   Offset(
        //     offset.dx +
        //         borderSize +
        //         j * (tileSize + tilePadding) +
        //         tileSize / 2 -
        //         textPainter.width / 2,
        //     offset.dy +
        //         borderSize +
        //         i * (tileSize + tilePadding) +
        //         tileSize / 2 -
        //         textPainter.height / 2,
        //   ),
        // );
      }
    }
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // if (isWhite) {
    //   time += dt;
    //   if (time >= duration) {
    //     time = duration;
    //     isWhite = false;
    //   }
    // } else {
    //   time -= dt;
    //   if (time <= 0) {
    //     time = 0;
    //     isWhite = true;
    //   }
    // }
    // currentColor =
    //     Color.lerp(Colors.black, Colors.white, time / duration) ?? Colors.black;
  }
}
