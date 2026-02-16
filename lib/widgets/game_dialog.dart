import 'package:flutter/material.dart';

class GameDialog extends StatelessWidget {
  final int level;
  final VoidCallback onRetry;
  final VoidCallback onHome;

  const GameDialog({
    super.key,
    required this.level,
    required this.onRetry,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF81D4FA), // azul pastel
              Color(0xFFB2EBF2), // azul aqua suave
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(image:  AssetImage('assets/animals/sad.png'), width: 80, height: 80),
            const SizedBox(height: 10),
            const Text(
              "¡Chispas!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Llegaste al nivel $level",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reintentar"),
                  onPressed: onRetry,
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.home),
                  label: const Text("Inicio"),
                  onPressed: onHome,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
