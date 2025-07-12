import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedWaterBubble extends StatefulWidget {
  final int currentCups;
  final int goalCups;

  const AnimatedWaterBubble({
    super.key,
    required this.currentCups,
    required this.goalCups,
  });

  @override
  State<AnimatedWaterBubble> createState() => _AnimatedWaterBubbleState();
}

class _AnimatedWaterBubbleState extends State<AnimatedWaterBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    double percent = widget.currentCups / widget.goalCups;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fillAnimation = Tween<double>(
      begin: 0.0,
      end: percent.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedWaterBubble oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentCups != widget.currentCups ||
        oldWidget.goalCups != widget.goalCups) {
      double newPercent =
          (widget.currentCups / widget.goalCups).clamp(0.0, 1.0);

      _fillAnimation = Tween<double>(
        begin: _fillAnimation.value,
        end: newPercent,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fillAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: BubblePainter(percent: _fillAnimation.value),
          size: const Size(120, 120),
        );
      },
    );
  }
}

class BubblePainter extends CustomPainter {
  final double percent;

  BubblePainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final Paint fillPaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final double radius = math.min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Path clipPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.save();
    canvas.clipPath(clipPath);

    final Path wavePath = Path();
    final double waveHeight = 6;
    final double fillLevel = size.height * (1 - percent);

    wavePath.moveTo(0, fillLevel);
    for (double x = 0.0; x <= size.width; x++) {
      double y = fillLevel +
          math.sin((x / size.width * 2 * math.pi) + percent * 2 * math.pi) *
              waveHeight;
      wavePath.lineTo(x, y);
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.drawPath(wavePath, fillPaint);
    canvas.restore();

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
