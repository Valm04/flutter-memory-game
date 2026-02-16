import 'package:flutter/material.dart';

class AnimalButton extends StatelessWidget {
  final String imagePath;
  final bool isActive;
  final VoidCallback onTap;
  final Color glowColor; 

  const AnimalButton({
    super.key,
    required this.imagePath,
    required this.isActive,
    required this.onTap,
    required this.glowColor, 
  });

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 190 : 170,   
      height: isActive ? 190 : 170,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, 
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: glowColor,
              blurRadius: 60,
              spreadRadius: 12,
            ),
        ],
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: isActive ? 130 : 115, 
        ),
      ),
    ),
  );
}

}
