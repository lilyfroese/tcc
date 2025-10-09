import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedSleepArc extends StatefulWidget {
  final TimeOfDay sleepTime;
  final TimeOfDay wakeTime;

  const AnimatedSleepArc({
    super.key,
    required this.sleepTime,
    required this.wakeTime,
  });

  @override
  State<AnimatedSleepArc> createState() => _AnimatedSleepArcState();
}

class _AnimatedSleepArcState extends State<AnimatedSleepArc>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  static const double maxHours = 8.0;

  @override
  void initState() {
    super.initState();
    final hours = _calculateHoursSlept();
    final percent = (hours / maxHours).clamp(0.0, 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: percent).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  double _calculateHoursSlept() {
    final sleepMinutes = widget.sleepTime.hour * 60 + widget.sleepTime.minute;
    final wakeMinutes = widget.wakeTime.hour * 60 + widget.wakeTime.minute;
    int diff = wakeMinutes - sleepMinutes;
    if (diff < 0) diff += 24 * 60;
    return diff / 60.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: SleepArcPainter(progress: _progressAnimation.value),
          );
        },
      ),
    );
  }
}

class SleepArcPainter extends CustomPainter {
  final double progress; // de 0 a 1

  SleepArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final Paint arcBackground = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final Paint arcFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Arco de fundo
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      arcBackground,
    );

    // Arco preenchido conforme progresso
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      arcFill,
    );

    // Lua amarela animada no arco
    final double angle = math.pi + (math.pi * progress);
    final Offset moonCenter = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    const moonRadius = 12.0;

    final Paint moonPaint = Paint()
      ..color = Colors.yellow.shade400
      ..style = PaintingStyle.fill;

    canvas.drawCircle(moonCenter, moonRadius, moonPaint);
  }

  @override
  bool shouldRepaint(covariant SleepArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
