import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaterBubbleWidget extends StatefulWidget {
  final double totalAtual;
  final double totalMeta;
  final VoidCallback? onTap;

  const WaterBubbleWidget({
    super.key,
    required this.totalAtual,
    required this.totalMeta,
    this.onTap,
  });

  @override
  State<WaterBubbleWidget> createState() => _WaterBubbleWidgetState();
}

class _WaterBubbleWidgetState extends State<WaterBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  late int currentCups;
  late int goalCups;
  late double percent;

  @override
  void initState() {
    super.initState();
    currentCups = (widget.totalAtual / 250).round();
    goalCups = (widget.totalMeta / 250).round();
    percent = widget.totalAtual / widget.totalMeta;

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
  void didUpdateWidget(WaterBubbleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalAtual != widget.totalAtual ||
        oldWidget.totalMeta != widget.totalMeta) {
      setState(() {
        currentCups = (widget.totalAtual / 250).round();
        goalCups = (widget.totalMeta / 250).round();
        percent = widget.totalAtual / widget.totalMeta;
      });

      _fillAnimation = Tween<double>(
        begin: _fillAnimation.value,
        end: percent.clamp(0.0, 1.0),
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: (screenWidth / 2) - 24,
          height: 180,
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 178, 224, 232),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.water_drop, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'Hidratação',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _fillAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: BubblePainter(percent: _fillAnimation.value),
                            child: const SizedBox(
                              width: 80,
                              height: 80,
                            ),
                          );
                        },
                      ),
                      Text(
                        "${widget.totalAtual.toInt()}ml",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
