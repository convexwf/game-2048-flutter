/// Copyright (c) 2025 convexwf
/// All rights reserved.
///
/// Project: game-2048-flutter
/// File: lib/number_matrix_handler.dart
/// Email: convexwf@gmail.com
/// Created: 2024-01-03
/// Last modified: 2024-01-03
///
/// This code is licensed under MIT license (see LICENSE for details)

enum MoveDirection {
  up,
  down,
  left,
  right,
}

class NumberMatrixHandler {
  final int size;
  final List<List<int>> matrix;
  final List<List<int>> nextMatrix;

  NumberMatrixHandler(this.size, this.matrix)
      : nextMatrix =
            List.generate(size, (index) => List.generate(size, (index) => 0));

  bool move(MoveDirection direction) {
    switch (direction) {
      case MoveDirection.up:
        _moveUp();
      case MoveDirection.down:
        _moveDown();
      case MoveDirection.left:
        _moveLeft();
      case MoveDirection.right:
        _moveRight();
    }
    if (_isDifferent(matrix, nextMatrix)) {
      for (int row = 0; row < size; row++) {
        for (int col = 0; col < size; col++) {
          matrix[row][col] = nextMatrix[row][col];
        }
      }
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
    }
  }

  void _moveDown() {
    for (int col = 0; col < size; col++) {
      final List<int> column =
          List.generate(size, (index) => matrix[index][col]);
      final List<int> newColumn = _moveAndMerge(column.reversed.toList());
      for (int row = 0; row < size; row++) {
        matrix[row][col] = newColumn[size - row - 1];
      }
    }
  }

  void _moveLeft() {
    for (int row = 0; row < size; row++) {
      final List<int> newRow = _moveAndMerge(matrix[row]);
      for (int col = 0; col < size; col++) {
        matrix[row][col] = newRow[col];
      }
    }
  }

  void _moveRight() {
    for (int row = 0; row < size; row++) {
      final List<int> newRow = _moveAndMerge(matrix[row].reversed.toList());
      for (int col = 0; col < size; col++) {
        matrix[row][col] = newRow[size - col - 1];
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
}
