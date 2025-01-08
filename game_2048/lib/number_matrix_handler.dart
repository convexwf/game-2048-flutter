import 'dart:math';

import 'package:flame/game.dart';

/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/number_matrix_handler.dart
/// Email: convexwf@gmail.com
/// Created: 2024-01-03
/// Last modified: 2025-01-08
///
/// This code is licensed under MIT license (see LICENSE for details)

enum MoveDirection {
  up,
  down,
  left,
  right,
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  String toString() {
    return '($x, $y)';
  }

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class MoveSituation {
  final Point source;
  final Point target;
  final bool isMerged;
  final bool isRemoved;

  MoveSituation(this.source, this.target, this.isMerged, this.isRemoved);

  @override
  String toString() {
    return 'source: $source, target: $target, isMerged: $isMerged, isRemoved: $isRemoved';
  }
}

class NumberMatrixHandler {
  final int randomSeed;
  final int size;
  final List<List<int>> matrix;
  final List<List<int>> nextMatrix;
  final List<MoveSituation> moveSituationList;
  int moveCount = 0;

  NumberMatrixHandler.fromMatrix(this.matrix, {this.randomSeed = 0})
      : size = matrix.length,
        nextMatrix = List.generate(matrix.length,
            (index) => List.generate(matrix.length, (index) => 0)),
        moveSituationList = [];

  NumberMatrixHandler.random({this.size = 4, this.randomSeed = 0})
      : matrix =
            List.generate(size, (index) => List.generate(size, (index) => 0)),
        nextMatrix =
            List.generate(size, (index) => List.generate(size, (index) => 0)),
        moveSituationList = [] {
    _initRandomMatrix();
  }

  void _initRandomMatrix() {
    final random = Random(randomSeed);
    final int putCount = random.nextInt(2) + 4;
    List<int> numberList = List.generate(size * size, (index) => index);
    numberList.shuffle(random);
    for (int i = 0; i < putCount; i++) {
      final int number = numberList[i];
      final int row = number ~/ size;
      final int col = number % size;
      final putNumber = random.nextInt(3) == 0 ? 4 : 2;
      matrix[row][col] = putNumber;
    }
  }

  void _addRandomNumber(MoveDirection direction) {
    moveCount++;
    final random = Random(randomSeed + moveCount);
    int putPosition = random.nextInt(size - 1);
    final putNumber = random.nextInt(3) == 0 ? 4 : 2;
    switch (direction) {
      case MoveDirection.up:
        while (matrix[size - 1][putPosition] != 0) {
          putPosition = (putPosition + 1) % size;
        }
        matrix[size - 1][putPosition] = putNumber;
        moveSituationList.add(MoveSituation(Point(size - 1, putPosition),
            Point(size - 1, putPosition), false, false));
        break;
      case MoveDirection.down:
        while (matrix[0][putPosition] != 0) {
          putPosition = (putPosition + 1) % size;
        }
        matrix[0][putPosition] = putNumber;
        moveSituationList.add(MoveSituation(
            Point(0, putPosition), Point(0, putPosition), false, false));
        break;
      case MoveDirection.left:
        while (matrix[putPosition][size - 1] != 0) {
          putPosition = (putPosition + 1) % size;
        }
        matrix[putPosition][size - 1] = putNumber;
        moveSituationList.add(MoveSituation(Point(putPosition, size - 1),
            Point(putPosition, size - 1), false, false));
        break;
      case MoveDirection.right:
        while (matrix[putPosition][0] != 0) {
          putPosition = (putPosition + 1) % size;
        }
        matrix[putPosition][0] = putNumber;
        moveSituationList.add(MoveSituation(
            Point(putPosition, 0), Point(putPosition, 0), false, false));
        break;
    }
  }

  bool move(MoveDirection direction) {
    moveSituationList.clear();
    switch (direction) {
      case MoveDirection.up:
        _moveUp();
        break;
      case MoveDirection.down:
        _moveDown();
        break;
      case MoveDirection.left:
        _moveLeft();
        break;
      case MoveDirection.right:
        _moveRight();
        break;
    }
    if (_isDifferent(matrix, nextMatrix)) {
      for (int row = 0; row < size; row++) {
        for (int col = 0; col < size; col++) {
          matrix[row][col] = nextMatrix[row][col];
        }
      }
      _addRandomNumber(direction);
      return true;
    }
    return false;
  }

  bool _isDifferent(List<List<int>> matrix1, List<List<int>> matrix2) {
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (matrix1[row][col] != matrix2[row][col]) {
          return true;
        }
      }
    }
    return false;
  }

  void _moveUp() {
    for (int col = 0; col < size; col++) {
      final List<int> column =
          List.generate(size, (index) => matrix[index][col]);
      final List<int> newColumn = _moveAndMerge(column);
      for (int row = 0; row < size; row++) {
        nextMatrix[row][col] = newColumn[row];
      }
      List<List<int>> movePositions =
          _determineMovePositions(column, newColumn);
      for (int i = 0; i < movePositions.length; i++) {
        List<int> movePosition = movePositions[i];
        final int source = movePosition[0];
        final int target = movePosition[1];
        final bool isMerged = movePosition[2] == 1;
        final bool isRemoved = movePosition[3] == 1;
        moveSituationList.add(MoveSituation(
            Point(source, col), Point(target, col), isMerged, isRemoved));
      }
    }
  }

  void _moveDown() {
    for (int col = 0; col < size; col++) {
      final List<int> column =
          List.generate(size, (index) => matrix[index][col]);
      final List<int> newColumn = _moveAndMerge(column.reversed.toList());
      for (int row = 0; row < size; row++) {
        nextMatrix[row][col] = newColumn[size - row - 1];
      }
      List<List<int>> movePositions =
          _determineMovePositions(column.reversed.toList(), newColumn);
      for (int i = 0; i < movePositions.length; i++) {
        List<int> movePosition = movePositions[i];
        final int source = movePosition[0];
        final int target = movePosition[1];
        final bool isMerged = movePosition[2] == 1;
        final bool isRemoved = movePosition[3] == 1;
        moveSituationList.add(MoveSituation(Point(size - source - 1, col),
            Point(size - target - 1, col), isMerged, isRemoved));
      }
    }
  }

  void _moveLeft() {
    for (int row = 0; row < size; row++) {
      final List<int> newRow = _moveAndMerge(matrix[row]);
      for (int col = 0; col < size; col++) {
        nextMatrix[row][col] = newRow[col];
      }
      List<List<int>> movePositions =
          _determineMovePositions(matrix[row], newRow);
      for (int i = 0; i < movePositions.length; i++) {
        List<int> movePosition = movePositions[i];
        final int source = movePosition[0];
        final int target = movePosition[1];
        final bool isMerged = movePosition[2] == 1;
        final bool isRemoved = movePosition[3] == 1;
        moveSituationList.add(MoveSituation(
            Point(row, source), Point(row, target), isMerged, isRemoved));
      }
    }
  }

  void _moveRight() {
    for (int row = 0; row < size; row++) {
      final List<int> newRow = _moveAndMerge(matrix[row].reversed.toList());
      for (int col = 0; col < size; col++) {
        nextMatrix[row][col] = newRow[size - col - 1];
      }
      List<List<int>> movePositions =
          _determineMovePositions(matrix[row].reversed.toList(), newRow);
      for (int i = 0; i < movePositions.length; i++) {
        List<int> movePosition = movePositions[i];
        final int source = movePosition[0];
        final int target = movePosition[1];
        final bool isMerged = movePosition[2] == 1;
        final bool isRemoved = movePosition[3] == 1;
        moveSituationList.add(MoveSituation(Point(row, size - source - 1),
            Point(row, size - target - 1), isMerged, isRemoved));
      }
    }
  }

  List<int> _moveAndMerge(List<int> array) {
    final List<int> newRow = List.generate(size, (index) => 0);
    int index = 0;
    for (int i = 0; i < size; i++) {
      if (array[i] != 0) {
        if (newRow[index] == 0) {
          newRow[index] = array[i];
        } else if (newRow[index] == array[i]) {
          newRow[index] *= 2;
          index++;
        } else {
          index++;
          newRow[index] = array[i];
        }
      }
    }
    return newRow;
  }

  // originalArray: [0, 2, 0, 2]
  // targetArray: [4, 0, 0, 0]
  // return: [ [1, 0, 1, 0], [3, 0, 0, 1] ]
  List<List<int>> _determineMovePositions(
      List<int> originalArray, List<int> targetArray) {
    // return: source, target, isMerged, isRemoved
    List<List<int>> movePositions = [];
    int index = 0;
    for (int i = 0; i < originalArray.length; i++) {
      if (originalArray[i] == 0) continue;
      if (originalArray[i] == targetArray[index]) {
        movePositions.add([i, index, 0, 0]);
        index++;
      } else {
        movePositions.add([i++, index, 1, 0]);
        while (i < originalArray.length && originalArray[i] == 0) {
          i++;
        }
        movePositions.add([i, index, 0, 1]);
        index++;
      }
    }
    return movePositions;
  }
}
