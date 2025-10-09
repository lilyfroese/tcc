import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:math' as math;

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen>
    with SingleTickerProviderStateMixin {
  final double totalMeta = 8; // meta de sono (8h)
  final double totalAtual = 6.5; // horas dormidas
  late AnimationController _controller;
  late Animation<double> _arcAnimation;

  @override
  void initState() {
    super.initState();
    double percent = (totalAtual / totalMeta).clamp(0.0, 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _arcAnimation = Tween<double>(
      begin: 0.0,
      end: percent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String sleepQuality(double progresso) {
    if (progresso >= 1) return "Excelente";
    if (progresso >= 0.8) return "Boa";
    if (progresso >= 0.6) return "Média";
    return "Ruim";
  }

  @override
  Widget build(BuildContext context) {
    final double progresso = totalAtual / totalMeta;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 176, 233),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // TÍTULO
            const Text(
              "Sono",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ANIMAÇÃO DO SONO (arco semicircular)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.25),
              ),
              child: SizedBox(
                width: 140,
                height: 140,
                child: AnimatedBuilder(
                  animation: _arcAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: SleepArcPainter(percent: _arcAnimation.value),
                      child: Center(
                        child: Text(
                          "${totalAtual.toStringAsFixed(1)}h",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TEXTO DE PROGRESSO
            Text(
              "${totalAtual.toStringAsFixed(1)}h / ${totalMeta.toStringAsFixed(0)}h",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Qualidade: ${sleepQuality(progresso)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            // PARTE INFERIOR - INFORMAÇÕES
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoCard(
                      icon: Icons.bedtime,
                      title: "Horário de sono",
                      subtitle: "23:00 às 05:30",
                    ),
                    const SizedBox(height: 15),
                    _infoCard(
                      icon: Icons.bar_chart,
                      title: "Progresso da noite",
                      subtitleWidget: LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: progresso > 1 ? 1 : progresso,
                        backgroundColor: Colors.grey[300],
                        progressColor: const Color.fromARGB(255, 205, 176, 233),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _infoCard(
                      icon: Icons.calendar_today,
                      title: "Histórico semanal",
                      subtitle: "Segunda a Domingo",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? subtitleWidget,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 170, 139, 192),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 179, 139, 192),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  if (subtitleWidget != null) subtitleWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepArcPainter extends CustomPainter {
  final double percent; // 0.0 a 1.0

  SleepArcPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 8.0;

    final Paint backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint arcPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final double radius = (math.min(size.width, size.height) / 2) - strokeWidth;
    final Offset center = Offset(size.width / 2, size.height / 2);

    const double startAngle = math.pi; // começa da esquerda
    const double sweepMax = math.pi; // arco semicircular (180°)

    // arco de fundo
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepMax,
      false,
      backgroundPaint,
    );

    // arco animado (progresso)
    double sweepArc = sweepMax * percent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepArc,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SleepArcPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
