import 'package:flutter/material.dart';
import 'package:tcc/components/bottom_navegation_bar.dart';
import 'package:tcc/components/custom_drawer.dart';
import 'package:tcc/screens/principal/components/puzzle/puzzle_goal.dart';

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
                    PuzzleGoal(
                      totalPieces: 4, // Número de peças do quebra-cabeça
                      onPieceTap: (index) {
                        // Ação ao tocar em uma peça
                        print('Peça $index tocada');
                      },
                    ),
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
