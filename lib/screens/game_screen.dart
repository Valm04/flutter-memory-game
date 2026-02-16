import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../services/sound_service.dart';
import '../widgets/animal_button.dart';
import '../widgets/game_dialog.dart';
import 'home_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameController _game = GameController();
  final SoundService _sound = SoundService();

  List<bool> activeButtons = [false, false, false, false];

  int timeLeft = 10;
  Timer? timer;

  bool showLevelIntro = true;
  int countdown = 3;

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  Future<void> _startLevel() async {
    timer?.cancel();
    setState(() {
      showLevelIntro = true;
      countdown = 3;
      timeLeft = _game.levelTime;
    });

    while (countdown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countdown--;
      });
    }

    setState(() {
      showLevelIntro = false;
    });

    _playSequence();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = _game.levelTime;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
      });

      if (timeLeft <= 0) {
        t.cancel();
        _showFailDialog();
      }
    });
  }

  void _onButtonTap(int index) async {
    if (!_game.inputEnabled) return;

    setState(() => activeButtons[index] = true);
    await _sound.playSound(index);

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => activeButtons[index] = false);
    });

    bool correct = _game.checkPlayerInput(index);

    if (correct) {
      if (_game.isSequenceComplete()) {
        timer?.cancel();
        _game.inputEnabled = false;
        _game.nextLevel();
        Future.delayed(const Duration(milliseconds: 800), _startLevel);
      }
    } else {
      timer?.cancel();
     // _sound.stop();
      _showFailDialog();
    }
  }

  void _playSequence() async {
    _game.inputEnabled = false;

    for (int btn in _game.sequence) {
      setState(() => activeButtons[btn] = true);
      await _sound.playSound(btn);
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => activeButtons[btn] = false);
      await Future.delayed(const Duration(milliseconds: 250));
    }

    _game.inputEnabled = true;
    startTimer();
  }

  void _showFailDialog() {
    timer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => GameDialog(
        level: _game.level,
        onRetry: () {
          Navigator.pop(context);
          _game.retryLevel();
          _startLevel();
        },
        onHome: () {
          Navigator.pop(context);
          _game.resetGame();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: showLevelIntro
        ? _buildIntro()
        //Stack para colocar la imagen de fondo y los botones encima, sin que se superpongan
        : Stack(
          children: [
            Image.asset(
              'assets/animals/background.png', // tu imagen de fondo
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: LinearProgressIndicator(
                      value: timeLeft / _game.levelTime,
                      minHeight: 25,
                      backgroundColor: Colors.white30, // azul pastel de fondo
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 28, 175, 243), // progreso en blanco visible
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        if (orientation == Orientation.portrait) {
                          // Orientación vertical
                          return _buildPortraitLayout();
                        } else {
                          // Orientación horizontal
                          return _buildLandscapeLayout();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFF59D), 
            Color(0xFFFFF176), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nivel ${_game.level}",
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 15,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              countdown > 0 ? "$countdown" : "¡Comienza!",
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Diseño para modo vertical
  Widget _buildPortraitLayout() {
    return Column(
      children: [
        Expanded(
          flex:1,
          child: Center(child: _buildButton(0)),
        ),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(1),
              _buildButton(2),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(child: _buildButton(3)),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(0),
          _buildButton(1),
          _buildButton(2),
          _buildButton(3),
        ],
      ),
    );
  }

  //creamos un metodo para construir cada uno de los botones y no repetir código
  Widget _buildButton(int index) {
    final images = [
      'assets/animals/meducita.png',
      'assets/animals/pinguinito.png',
      'assets/animals/shark.png',
      'assets/animals/tortuguita.png',
    ];

    final colors = [
      Colors.purpleAccent,
      Colors.lightBlueAccent,
      Colors.yellowAccent,
      Colors.greenAccent,
    ];

    return AnimalButton(
      imagePath: images[index],
      isActive: activeButtons[index],
      glowColor: colors[index],
      onTap: () => _onButtonTap(index),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
