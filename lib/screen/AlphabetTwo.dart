import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:junior_journey/screen/alphabet_main.dart';

class AlphabetTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlphabetScreen(),
    );
  }
}

class AlphabetScreen extends StatefulWidget {
  @override
  _AlphabetScreenState createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final List<String> alphabets = [
    'A',
    'B',
    'C',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ]; // Add more alphabets as needed
  int currentIndex = 0;
  bool isTapped = false;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startAutomaticProgression();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/green_board.jpg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isTapped)
                Image.asset(
                  'assets/images/${alphabets[currentIndex]}.png',
                  height: 200,
                  width: 200,
                ),
              if (isTapped)
                Image.asset(
                  'assets/images/${alphabets[currentIndex]}1.png',
                  height: 350,
                  width: 500,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _playAudio(String alphabet) async {
    String audioPath = 'audio/${alphabet}.mp3';
    // await audioPlayer.play(AssetSource(audioPath));
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(audioPath));
  }

  void _stopAudio() {
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.stop();
  }

  void _startAutomaticProgression() {
    // Start the automatic progression
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isTapped = true;
      });

      _playAudio(alphabets[currentIndex]);

      Future.delayed(Duration(seconds: 4), () {
        setState(() {
          currentIndex = (currentIndex + 1) % alphabets.length;
          isTapped = false;
        });

        _startAutomaticProgression();
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
