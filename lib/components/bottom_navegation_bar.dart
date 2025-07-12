import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tcc/components/avatar_circle.dart';
import 'package:tcc/components/curved_navbar_clipper.dart';
import 'package:tcc/screens/desabafo/desabafo.dart';
import 'package:tcc/screens/postit/post_it_screen.dart';
import 'package:tcc/screens/widgets/widgets_screen.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20, 
            left: 12, 
            right: 12
          ), // margem inferior
          child: ClipPath(
            clipper: CurvedNavBarClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10, 
                sigmaY: 10
              ), // efeito vidro
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFffd700).withOpacity(0.8),
                      Color(0xFFffe066).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(50), // mais arredondado
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.bubble_chart, 
                        size: 28, 
                        color: Colors.white70
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WidgetsScreen(),
                        ));
                      },
                      tooltip: 'Espaço  widgets',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.group, 
                        size: 24, 
                        color: Colors.white70
                      ),
                      onPressed: () {},
                      tooltip: 'Servidor',
                    ),

                    const SizedBox(width: 60), // espaço pro botão central
                    
                    IconButton(
                      icon: const Icon(
                        Icons.layers, 
                        size: 24, 
                        color: Colors.white70
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PostItScreen(),
                        ));
                      },
                      tooltip: 'Post-it',
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.local_cafe, 
                        size: 24, 
                        color: Colors.white70
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DesabafoScreen(),
                        ));
                      },
                      tooltip: 'Desabafo',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AvatarCircle(),
      ],
    );
  }
}

