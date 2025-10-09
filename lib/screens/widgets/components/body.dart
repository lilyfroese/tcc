import 'package:flutter/material.dart';
import 'package:tcc/components/bottom_navegation_bar.dart';
import 'package:tcc/components/custom_drawer.dart';
import 'package:tcc/screens/sleep/sleep_screen.dart';
import 'package:tcc/screens/widgets/components/widgets/freud_score_widget.dart';
import 'package:tcc/screens/widgets/components/widgets/mood_widget.dart';
import 'package:tcc/screens/widgets/components/widgets/sleep_regulator_widget.dart';
import 'package:tcc/screens/widgets/components/widgets/widget_water/water_bubble_widget.dart';
import 'package:tcc/screens/water/water_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 40, // Garante espaço extra pra rolar
          child: Stack(
            children: [
              // Fundo da tela
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.brown.shade50,
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 250), // Espaço antes do primeiro grupo

                    // Primeiro grupo de widgets lado a lado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WaterBubbleWidget(
                          totalAtual: 5,
                          totalMeta: 8,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => WaterScreen(),
                            ));
                          },
                        ),
                        const SizedBox(width: 20),
                        SleepRegulatorWidget(
                          sleepTime: TimeOfDay(hour: 23, minute: 0),
                          wakeTime: TimeOfDay(hour: 3, minute: 30),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SleepScreen(),
                            ));
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 10), // Espaço entre os dois Row's

                    // Segundo grupo de widgets lado a lado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoodWidget(
                          mood: "Triste",
                          moodData: [0.2, 0.5, 0.8, 0.4, 0.6, 0.3, 0.7],
                          onTap: () {
                            Navigator.pushNamed(context, '/mood');
                          },
                        ),
                        const SizedBox(width: 20),
                        FreudScoreWidget(
                          score: 72,
                          status: 'Bom',
                          onTap: () {
                            Navigator.pushNamed(context, '/freud');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Espaço no final
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
