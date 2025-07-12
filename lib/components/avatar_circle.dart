import 'package:flutter/material.dart';
import 'profile_menu_bottom_sheet.dart'; // importa o novo widget do menu

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key});

  void _openBottomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ProfileMenuBottomSheet(), // usa o novo widget aqui
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: const Offset(0, -65),
        child: GestureDetector(
          onTap: () => _openBottomMenu(context),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[400],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white38,
                size: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
