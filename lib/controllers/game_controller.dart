import 'dart:math';

class GameController {
  List<int> sequence = [];
  int playerStep = 0;
  bool inputEnabled = false;
  int level = 1;

  // Tiempo base
  int time = 8; 

  int get levelTime => time + (level - 1) * 2;

  final Random _random = Random();

  GameController() {
    _generateInitialSequence();
  }
  
  void _generateInitialSequence() {
    sequence.clear();
    //generamos una secuencia inicial de 3 pasos
    for (int i = 0; i < 3; i++) {
      sequence.add(_random.nextInt(4));
    }
  }

  
  void _addStepToSequence() {
    // Agrega un nuevo paso aleatorio al final de la secuencia del 0 al 3
    sequence.add(_random.nextInt(4));
  }

  bool checkPlayerInput(int index) {
    // Verifica si el botón presionado por el jugador es correcto
    if (sequence[playerStep] == index) {
      // Si es correcto, avanzamos al siguiente paso
      playerStep++;
      return true;
    } else {
      return false;
    }
  }

  bool isSequenceComplete() {
    return playerStep >= sequence.length;
  }

  void nextLevel() {
    level++;
    playerStep = 0;
    _addStepToSequence(); // Solo agregamos un nuevo paso
  }

  void resetGame() {
    level = 1;
    playerStep = 0;
    _generateInitialSequence(); // Secuencia inicial
  }

  void retryLevel() {
    playerStep = 0; // Mantener la misma secuencia
  }
}
