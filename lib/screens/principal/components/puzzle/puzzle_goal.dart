import 'package:flutter/material.dart';
import 'dart:math';

/// Widget principal que representa o quebra-cabeça completo na tela
class PuzzleGoal extends StatelessWidget {
  final int totalPieces; // Quantidade total de peças no quebra-cabeça
  final void Function(int)? onPieceTap; // Callback chamado ao clicar numa peça
  final double verticalPaddingBottom; // Espaço inferior configurável

  const PuzzleGoal({
    super.key,
    required this.totalPieces,
    this.onPieceTap,
    this.verticalPaddingBottom = 20.0, // valor padrão menor
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = _calculateGridDimensions(totalPieces);
    final rows = dimensions.item1;
    final columns = dimensions.item2;

    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPadding = 20.0;

        // espaço de cima adaptável
        final verticalPaddingTop = max(10.0, 60.0 - rows * 5);

        // Área máxima para o puzzle
        final maxWidthArea = constraints.maxWidth - 2 * horizontalPadding;
        final maxHeightArea = constraints.maxHeight - verticalPaddingTop - verticalPaddingBottom;

        final maxPieceWidth = maxWidthArea / columns;
        final maxPieceHeight = maxHeightArea / rows;

        final pieceSize = min(maxPieceWidth, maxPieceHeight);

        final puzzleWidth = pieceSize * columns;
        final puzzleHeight = pieceSize * rows;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPaddingTop,
            horizontalPadding,
            verticalPaddingBottom,
          ),
          child: Align(
            alignment: Alignment.topCenter, // fixa no topo do retângulo
            child: SizedBox(
              width: puzzleWidth,
              height: puzzleHeight,
              child: Stack(
                children: List.generate(totalPieces, (index) {
                  final row = index ~/ columns;
                  final column = index % columns;

                  final top = row == 0 ? SideType.flat : (row % 2 == 0 ? SideType.outward : SideType.inward);
                  final bottom = row == rows - 1 ? SideType.flat : (row % 2 == 0 ? SideType.inward : SideType.outward);
                  final left = column == 0 ? SideType.flat : (column % 2 == 0 ? SideType.outward : SideType.inward);
                  final right = column == columns - 1 ? SideType.flat : (column % 2 == 0 ? SideType.inward : SideType.outward);

                  return Positioned(
                    left: column * pieceSize,
                    top: row * pieceSize,
                    width: pieceSize,
                    height: pieceSize,
                    child: GestureDetector(
                      onTap: () => onPieceTap?.call(index),
                      child: PuzzlePieceWidget(
                        index: index,
                        row: row,
                        column: column,
                        rows: rows,
                        columns: columns,
                        top: top,
                        bottom: bottom,
                        left: left,
                        right: right,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }

  Tuple2<int, int> _calculateGridDimensions(int count) {
    switch (count) {
      case 2: return Tuple2(2, 1);
      case 4: return Tuple2(2, 2);
      case 6: return Tuple2(3, 2);
      case 8: return Tuple2(4, 2);
      case 10: return Tuple2(5, 2);
      case 12: return Tuple2(4, 3);
      case 14: return Tuple2(7, 2);
      case 16: return Tuple2(4, 4);
      case 18: return Tuple2(6, 3);
      case 20: return Tuple2(5, 4);
      case 24: return Tuple2(6, 4);
      case 28: return Tuple2(7, 4);
      case 30: return Tuple2(6, 5);
      case 32: return Tuple2(8, 4);
      default: return Tuple2(count, 1);
    }
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;
  Tuple2(this.item1, this.item2);
}

class PuzzlePieceWidget extends StatelessWidget {
  final int index;
  final int row, column;
  final int rows, columns;
  final SideType top, bottom, left, right;

  const PuzzlePieceWidget({
    super.key,
    required this.index,
    required this.row,
    required this.column,
    required this.rows,
    required this.columns,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getRandomColor(index);

    return CustomPaint(
      painter: PuzzlePiecePainter(
        color: color,
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: Container(),
    );
  }

  Color _getRandomColor(int seed) {
    final random = Random(seed);
    return Color.fromARGB(
      255,
      150 + random.nextInt(100),
      150 + random.nextInt(100),
      150 + random.nextInt(100),
    );
  }
}

enum SideType { flat, inward, outward }
enum Side { top, bottom, left, right }

class PuzzlePiecePainter extends CustomPainter {
  final Color color;
  final SideType top, bottom, left, right;

  PuzzlePiecePainter({
    required this.color,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    final w = size.width;
    final h = size.height;
    final knobSize = min(w, h) * 0.2;

    path.moveTo(0, 0);
    _drawSide(path, w, 0, Side.top, top, knobSize);
    _drawSide(path, h, w, Side.right, right, knobSize);
    _drawSide(path, w, h, Side.bottom, bottom, knobSize);
    _drawSide(path, h, 0, Side.left, left, knobSize);
    path.close();

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [_darken(color, 0.3), _lighten(color, 0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  Color _darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  Color _lighten(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  void _drawSide(Path path, double length, double offset, Side side, SideType type, double knobSize) {
    double third = length / 3;

    switch (side) {
      case Side.top:
        path.lineTo(third, 0);
        _drawKnob(path, Offset(third, 0), Offset(2 * third, 0), type, true);
        path.lineTo(length, 0);
        break;
      case Side.right:
        path.lineTo(offset, third);
        _drawKnob(path, Offset(offset, third), Offset(offset, 2 * third), type, false);
        path.lineTo(offset, length);
        break;
      case Side.bottom:
        path.lineTo(length - third, offset);
        _drawKnob(path, Offset(length - third, offset), Offset(third, offset), type, true, reverse: true);
        path.lineTo(0, offset);
        break;
      case Side.left:
        path.lineTo(0, length - third);
        _drawKnob(path, Offset(0, length - third), Offset(0, third), type, false, reverse: true);
        path.lineTo(0, 0);
        break;
    }
  }

  void _drawKnob(Path path, Offset from, Offset to, SideType type, bool horizontal, {bool reverse = false}) {
    if (type == SideType.flat) {
      path.lineTo(to.dx, to.dy);
      return;
    }

    final mid = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2);
    final knobRadius = (horizontal ? to.dx - from.dx : to.dy - from.dy) / 1.5;
    final knobDepth = (type == SideType.outward ? 1 : -1) * knobRadius;

    if (horizontal) {
      final direction = reverse ? -1 : 1;
      path.quadraticBezierTo(mid.dx, mid.dy + knobDepth * direction, to.dx, to.dy);
    } else {
      final direction = reverse ? -1 : 1;
      path.quadraticBezierTo(mid.dx + knobDepth * direction, mid.dy, to.dx, to.dy);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
