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
      // check move situation
      expect(handler.moveSituationList.length, 4);
      expect(handler.moveSituationList[0].source, Point(0, 0));
      expect(handler.moveSituationList[0].target, Point(0, 0));
      expect(handler.moveSituationList[0].isMerged, isTrue);
      expect(handler.moveSituationList[0].isRemoved, isFalse);
      expect(handler.moveSituationList[1].source, Point(1, 0));
      expect(handler.moveSituationList[1].target, Point(0, 0));
      expect(handler.moveSituationList[1].isMerged, isFalse);
      expect(handler.moveSituationList[1].isRemoved, isTrue);
      expect(handler.moveSituationList[2].source, Point(0, 3));
      expect(handler.moveSituationList[2].target, Point(0, 3));
      expect(handler.moveSituationList[2].isMerged, isTrue);
      expect(handler.moveSituationList[2].isRemoved, isFalse);
      expect(handler.moveSituationList[3].source, Point(1, 3));
      expect(handler.moveSituationList[3].target, Point(0, 3));
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
      expect(handler.moveSituationList.length, 4);
      expect(handler.moveSituationList[0].source, Point(0, 0));
      expect(handler.moveSituationList[0].target, Point(3, 0));
      expect(handler.moveSituationList[0].isMerged, isFalse);
      expect(handler.moveSituationList[0].isRemoved, isTrue);
      expect(handler.moveSituationList[1].source, Point(1, 0));
      expect(handler.moveSituationList[1].target, Point(3, 0));
      expect(handler.moveSituationList[1].isMerged, isTrue);
      expect(handler.moveSituationList[1].isRemoved, isFalse);
      expect(handler.moveSituationList[2].source, Point(0, 3));
      expect(handler.moveSituationList[2].target, Point(3, 3));
      expect(handler.moveSituationList[2].isMerged, isFalse);
      expect(handler.moveSituationList[2].isRemoved, isTrue);
      expect(handler.moveSituationList[3].source, Point(1, 3));
      expect(handler.moveSituationList[3].target, Point(3, 3));
      expect(handler.moveSituationList[3].isMerged, isTrue);
      expect(handler.moveSituationList[3].isRemoved, isFalse);
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
      expect(handler.moveSituationList.length, 4);
      expect(handler.moveSituationList[0].source, Point(0, 0));
      expect(handler.moveSituationList[0].target, Point(0, 0));
      expect(handler.moveSituationList[0].isMerged, isTrue);
      expect(handler.moveSituationList[0].isRemoved, isFalse);
      expect(handler.moveSituationList[1].source, Point(0, 3));
      expect(handler.moveSituationList[1].target, Point(0, 0));
      expect(handler.moveSituationList[1].isMerged, isFalse);
      expect(handler.moveSituationList[1].isRemoved, isTrue);
      expect(handler.moveSituationList[2].source, Point(1, 0));
      expect(handler.moveSituationList[2].target, Point(1, 0));
      expect(handler.moveSituationList[2].isMerged, isTrue);
      expect(handler.moveSituationList[2].isRemoved, isFalse);
      expect(handler.moveSituationList[3].source, Point(1, 3));
      expect(handler.moveSituationList[3].target, Point(1, 0));
      expect(handler.moveSituationList[1].isMerged, isFalse);
      expect(handler.moveSituationList[1].isRemoved, isTrue);
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
      expect(handler.moveSituationList.length, 4);
      expect(handler.moveSituationList[0].source, Point(0, 0));
      expect(handler.moveSituationList[0].target, Point(0, 3));
      expect(handler.moveSituationList[0].isMerged, isFalse);
      expect(handler.moveSituationList[0].isRemoved, isTrue);
      expect(handler.moveSituationList[1].source, Point(0, 3));
      expect(handler.moveSituationList[1].target, Point(0, 3));
      expect(handler.moveSituationList[1].isMerged, isTrue);
      expect(handler.moveSituationList[1].isRemoved, isFalse);
      expect(handler.moveSituationList[2].source, Point(1, 0));
      expect(handler.moveSituationList[2].target, Point(1, 3));
      expect(handler.moveSituationList[2].isMerged, isFalse);
      expect(handler.moveSituationList[2].isRemoved, isTrue);
      expect(handler.moveSituationList[3].source, Point(1, 3));
      expect(handler.moveSituationList[3].target, Point(1, 3));
      expect(handler.moveSituationList[3].isMerged, isTrue);
      expect(handler.moveSituationList[3].isRemoved, isFalse);
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
