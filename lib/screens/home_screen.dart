import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF81D4FA), // azul pastel
              Color(0xFFB2EBF2), // azul aqua suave
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80), // radio grande para suavizar
                  child: Image.asset(
                    'assets/animals/background.png',
                    width: 150, 
                    height: 150,            
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Animal Memory',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Recuerda la secuencia de animalitos 🐢🐧',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  elevation: 8,
                  disabledBackgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    //mandamos a llamar a la pantalla del juego
                    MaterialPageRoute(builder: (_) => const GameScreen()),
                  );
                },
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
