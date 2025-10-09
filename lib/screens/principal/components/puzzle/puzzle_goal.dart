import 'package:flutter/material.dart';
import 'dart:math';

/// Widget principal que representa o quebra-cabeça completo na tela
class PuzzleGoal extends StatelessWidget {
  final int totalPieces; // Quantidade total de peças no quebra-cabeça
  final void Function(int)? onPieceTap; // Callback chamado ao clicar numa peça, recebe o índice da peça
  final double verticalPaddingBottom; // Espaço inferior configurável para o layout

  const PuzzleGoal({
    super.key,
    required this.totalPieces,
    this.onPieceTap,
    this.verticalPaddingBottom = 20.0, // valor padrão para padding inferior
  });

  @override
  Widget build(BuildContext context) {
    // Calcula as dimensões da grade do quebra-cabeça (linhas e colunas) baseando-se no total de peças
    final dimensions = _calculateGridDimensions(totalPieces);
    final rows = dimensions.item1;
    final columns = dimensions.item2;

    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPadding = 20.0; // Espaçamento horizontal fixo nas laterais

        // Espaço superior que se adapta ao número de linhas (mais linhas, menos espaço superior)
        final verticalPaddingTop = max(10.0, 60.0 - rows * 5);

        // Calcula o espaço máximo disponível para o quebra-cabeça dentro das restrições do LayoutBuilder
        final maxWidthArea = constraints.maxWidth - 2 * horizontalPadding;
        final maxHeightArea = constraints.maxHeight - verticalPaddingTop - verticalPaddingBottom;

        // Calcula o tamanho máximo possível para cada peça, para caber na área disponível
        final maxPieceWidth = maxWidthArea / columns;
        final maxPieceHeight = maxHeightArea / rows;

        // Define o tamanho da peça como o menor valor entre largura e altura para manter formato quadrado
        final pieceSize = min(maxPieceWidth, maxPieceHeight);

        // Calcula a largura e altura totais do quebra-cabeça (baseado no tamanho da peça)
        final puzzleWidth = pieceSize * columns;
        final puzzleHeight = pieceSize * rows;

        return Padding(
          // Define o padding total da área do quebra-cabeça
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPaddingTop,
            horizontalPadding,
            verticalPaddingBottom,
          ),
          child: Align(
            alignment: Alignment.topCenter, // Alinha o quebra-cabeça no topo e centro horizontalmente
            child: SizedBox(
              width: puzzleWidth,
              height: puzzleHeight,
              child: Stack(
                // Cria todas as peças do quebra-cabeça como widgets posicionados dentro do Stack
                children: List.generate(totalPieces, (index) {
                  // Calcula a linha e coluna da peça atual
                  final row = index ~/ columns;
                  final column = index % columns;

                  // Define o tipo das bordas da peça (flat, inward ou outward), para formar encaixes corretos
                  final top = row == 0 ? SideType.flat : (row % 2 == 0 ? SideType.outward : SideType.inward);
                  final bottom = row == rows - 1 ? SideType.flat : (row % 2 == 0 ? SideType.inward : SideType.outward);
                  final left = column == 0 ? SideType.flat : (column % 2 == 0 ? SideType.outward : SideType.inward);
                  final right = column == columns - 1 ? SideType.flat : (column % 2 == 0 ? SideType.inward : SideType.outward);

                  return Positioned(
                    left: column * pieceSize, // posição horizontal da peça no quebra-cabeça
                    top: row * pieceSize, // posição vertical da peça
                    width: pieceSize,
                    height: pieceSize,
                    child: GestureDetector(
                      // Detecta toque na peça e chama o callback onPieceTap com o índice da peça
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

  /// Método privado que calcula o número de linhas e colunas na grade do quebra-cabeça
  /// baseado no total de peças, retornando uma Tuple2 com linhas e colunas.
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
      default: return Tuple2(count, 1); // Para números não tratados, cria uma única linha
    }
  }
}

/// Classe simples para armazenar dois valores (linhas e colunas)
class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;
  Tuple2(this.item1, this.item2);
}

/// Widget que representa uma única peça do quebra-cabeça
class PuzzlePieceWidget extends StatelessWidget {
  final int index;
  final int row, column;
  final int rows, columns;
  final SideType top, bottom, left, right; // Tipo das bordas da peça

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
    // Gera uma cor aleatória mas consistente para cada peça, usando o índice como semente
    final color = _getRandomColor(index);

    return CustomPaint(
      // Desenha a peça usando o PuzzlePiecePainter, que cria os encaixes e a forma visual
      painter: PuzzlePiecePainter(
        color: color,
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: Container(), // Container vazio apenas para ocupar espaço no CustomPaint
    );
  }

  /// Método que gera uma cor aleatória consistente com base em uma semente (index da peça)
  Color _getRandomColor(int seed) {
    final random = Random(seed);
    return Color.fromARGB(
      255,
      150 + random.nextInt(100), // tons médios claros para evitar cores muito escuras
      150 + random.nextInt(100),
      150 + random.nextInt(100),
    );
  }
}

/// Enum que define o tipo da borda da peça do quebra-cabeça
enum SideType { flat, inward, outward }

/// Enum para identificar os lados da peça
enum Side { top, bottom, left, right }

/// CustomPainter que desenha a forma da peça do quebra-cabeça, com encaixes (knobs) nas bordas
class PuzzlePiecePainter extends CustomPainter {
  final Color color; // Cor da peça
  final SideType top, bottom, left, right; // Tipos das bordas

  PuzzlePiecePainter({
    required this.color,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path(); // Path que define a forma da peça

    final w = size.width;
    final h = size.height;
    final knobSize = min(w, h) * 0.2; // tamanho dos encaixes, proporcional ao tamanho da peça

    path.moveTo(0, 0); // ponto inicial no canto superior esquerdo

    // Desenha cada lado da peça, com o tipo de borda e encaixe correspondente
    _drawSide(path, w, 0, Side.top, top, knobSize);
    _drawSide(path, h, w, Side.right, right, knobSize);
    _drawSide(path, w, h, Side.bottom, bottom, knobSize);
    _drawSide(path, h, 0, Side.left, left, knobSize);

    path.close(); // fecha o caminho

    // Define um gradiente linear para dar profundidade e sombreamento à peça
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [_darken(color, 0.3), _lighten(color, 0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Desenha a forma da peça no canvas com a pintura configurada
    canvas.drawPath(path, paint);
  }

  /// Escurece uma cor diminuindo sua luminosidade no espaço HSL
  Color _darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }

  /// Clareia uma cor aumentando sua luminosidade no espaço HSL
  Color _lighten(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  /// Método que desenha um lado da peça, com seu respectivo encaixe (knob)
  void _drawSide(Path path, double length, double offset, Side side, SideType type, double knobSize) {
    double third = length / 3; // divide o lado em três partes para encaixe no meio

    switch (side) {
      case Side.top:
        path.lineTo(third, 0); // linha até 1/3 da largura
        _drawKnob(path, Offset(third, 0), Offset(2 * third, 0), type, true); // desenha encaixe no meio
        path.lineTo(length, 0); // linha até o fim do lado
        break;
      case Side.right:
        path.lineTo(offset, third); // linha até 1/3 da altura
        _drawKnob(path, Offset(offset, third), Offset(offset, 2 * third), type, false); // encaixe vertical
        path.lineTo(offset, length); // linha até o fim do lado
        break;
      case Side.bottom:
        path.lineTo(length - third, offset); // linha até 2/3 da largura (invertido pois desenha no sentido oposto)
        _drawKnob(path, Offset(length - third, offset), Offset(third, offset), type, true, reverse: true); // encaixe invertido
        path.lineTo(0, offset); // linha até o começo do lado
        break;
      case Side.left:
        path.lineTo(0, length - third); // linha até 2/3 da altura
        _drawKnob(path, Offset(0, length - third), Offset(0, third), type, false, reverse: true); // encaixe invertido vertical
        path.lineTo(0, 0); // linha até o início do lado
        break;
    }
  }

  /// Método que desenha o encaixe (knob) da peça entre dois pontos
  /// Pode ser horizontal ou vertical e pode estar invertido (reverse)
  void _drawKnob(Path path, Offset from, Offset to, SideType type, bool horizontal, {bool reverse = false}) {
    if (type == SideType.flat) {
      // Se a borda for flat, apenas linha reta
      path.lineTo(to.dx, to.dy);
      return;
    }

    final mid = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2); // ponto médio entre from e to
    final knobRadius = (horizontal ? to.dx - from.dx : to.dy - from.dy) / 1.5; // raio do knob
    final knobDepth = (type == SideType.outward ? 1 : -1) * knobRadius; // profundidade do knob (para dentro ou para fora)

    if (horizontal) {
      // Desenha curva quadrática para encaixe horizontal
      final direction = reverse ? -1 : 1;
      path.quadraticBezierTo(mid.dx, mid.dy + knobDepth * direction, to.dx, to.dy);
    } else {
      // Desenha curva quadrática para encaixe vertical
      final direction = reverse ? -1 : 1;
      path.quadraticBezierTo(mid.dx + knobDepth * direction, mid.dy, to.dx, to.dy);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true; // Sempre redesenha (pode ser otimizado)
}
