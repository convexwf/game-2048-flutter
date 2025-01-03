import 'package:flutter_test/flutter_test.dart';
import 'package:game_2048/number_matrix_handler.dart';

void main() {
  group('NumberMatrixHandler', () {
    test('move up', () {
      final handler = NumberMatrixHandler(4, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);

      final moved = handler.move(MoveDirection.up);

      expect(moved, isTrue);
      expect(handler.matrix, [
        [4, 0, 0, 4],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
    });

    test('move down', () {
      final handler = NumberMatrixHandler(4, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);

      final moved = handler.move(MoveDirection.down);

      expect(moved, isTrue);
      expect(handler.matrix, [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [4, 0, 0, 4],
      ]);
    });

    test('move left', () {
      final handler = NumberMatrixHandler(4, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);

      final moved = handler.move(MoveDirection.left);

      expect(moved, isTrue);
      expect(handler.matrix, [
        [4, 0, 0, 0],
        [4, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
    });

    test('move right', () {
      final handler = NumberMatrixHandler(4, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);

      final moved = handler.move(MoveDirection.right);

      expect(moved, isTrue);
      expect(handler.matrix, [
        [0, 0, 0, 4],
        [0, 0, 0, 4],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
    });

    test('no move', () {
      final handler = NumberMatrixHandler(4, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);

      final moved = handler.move(MoveDirection.up);

      expect(moved, isFalse);
      expect(handler.matrix, [
        [2, 0, 0, 2],
        [2, 0, 0, 2],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
    });
  });
}
