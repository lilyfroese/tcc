import 'package:flutter/material.dart';
import 'dart:math';

class MoodWidget extends StatelessWidget {
  final String mood;
  final List<double> moodData;
  final VoidCallback onTap;

  const MoodWidget({
    super.key,
    required this.mood,
    required this.moodData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center, // <- CENTRALIZA o widget na horizontal
      child: Container(
        width: (screenWidth / 2) - 24, // metade da tela com margem
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 222, 168, 131),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // <- centraliza conteúdo interno
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 6),
                Text(
                  'Mood',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              mood,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: moodData
                    .map((value) => Container(
                          width: 6,
                          height: max(0, value * 40),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
