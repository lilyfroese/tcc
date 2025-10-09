import 'dart:math' as math;
import 'package:flutter/material.dart';

class SleepRegulatorWidget extends StatefulWidget {
  final TimeOfDay sleepTime;
  final TimeOfDay wakeTime;
  final VoidCallback? onTap;

  const SleepRegulatorWidget({
    super.key,
    required this.sleepTime,
    required this.wakeTime,
    this.onTap,
  });

  @override
  State<SleepRegulatorWidget> createState() => _SleepRegulatorWidgetState();
}

class _SleepRegulatorWidgetState extends State<SleepRegulatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

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
    _fillAnimation = Tween<double>(begin: 0.0, end: percent).animate(
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

  String getSleepQuality(double hours) {
    if (hours < 4) return 'Péssima';
    if (hours < 6) return 'Ruim';
    if (hours < 8) return 'Boa';
    return 'Excelente';
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hours = _calculateHoursSlept().clamp(0.0, maxHours);
    final quality = getSleepQuality(hours);
    final sleepStr = formatTime(widget.sleepTime);
    final wakeStr = formatTime(widget.wakeTime);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: (screenWidth / 2) - 24,
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFC4B2D7), // Roxo claro da imagem
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Título e ícone
            Positioned(
              top: 6,
              left: 0,
              child: Row(
                children: const [
                  Icon(Icons.bedtime_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 6),
                  Text(
                    'Sono',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Arco + lua + avaliação central
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 90,
                    child: AnimatedBuilder(
                      animation: _fillAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter:
                              SleepArcPainter(percent: _fillAnimation.value),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    quality,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            // Horários nas pontas do arco
            Positioned(
              bottom: 12,
              left: 4,
              child: Text(
                sleepStr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 4,
              child: Text(
                wakeStr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepArcPainter extends CustomPainter {
  final double percent;

  SleepArcPainter({required this.percent});

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

    // Arco (semicírculo virado para cima)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      arcBackground,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * percent,
      false,
      arcFill,
    );

    // Lua amarela (cheia)
    final double angle = math.pi + (math.pi * percent);
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
      oldDelegate.percent != percent;
}
