import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tcc/screens/water/components/animated_water_bubble.dart';


class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  final double totalMeta = 2000;
  final double totalAtual = 1200;

  @override
  Widget build(BuildContext context) {
    final double progresso = totalAtual / totalMeta;
    final int currentCups = (totalAtual / 250).floor();
    final int goalCups = (totalMeta / 250).floor();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 224, 232),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Título
            const Text(
              "Hidratação",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Bolha animada com borda translúcida
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: AnimatedWaterBubble(
                  currentCups: currentCups,
                  goalCups: goalCups,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Texto de progresso
            Text(
              "${totalAtual.toInt()}ml / ${totalMeta.toInt()}ml",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Continue se hidratando!",
              style: TextStyle(
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
                      icon: Icons.access_time,
                      title: "Última ingestão",
                      subtitle: "09:30 - 300ml",
                    ),
                    const SizedBox(height: 15),
                    _infoCard(
                      icon: Icons.bar_chart,
                      title: "Progresso do dia",
                      subtitleWidget: LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: progresso > 1 ? 1 : progresso,
                        backgroundColor: Colors.grey[300],
                        progressColor: const Color.fromARGB(255, 178, 224, 232),
                      ),
                    ),
                    const SizedBox(height: 15),
                    _infoCard(
                      icon: Icons.calendar_today,
                      title: "Histórico semanal",
                      subtitle: "Domingo a Domingo",
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
              color: Color.fromARGB(255, 127, 174, 183),
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
                      color: Color.fromARGB(255, 127, 174, 183),
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
