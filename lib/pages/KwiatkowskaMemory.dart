import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../Widgets/FlipCard.dart';

class KwiatkowskaMemory extends StatefulWidget {
  const KwiatkowskaMemory({Key? key}) : super(key: key);

  @override
  _KwiatkowskaMemoryState createState() => _KwiatkowskaMemoryState();
}

class _KwiatkowskaMemoryState extends State<KwiatkowskaMemory> {
  List<String> images = [
    "images/k1.jpg",
    "images/k2.jpg",
    "images/k3.jpg",
    "images/k4.jpg",
    "images/k5.jpg",
    "images/k6.jpg",
  ];

  List<String> gameGrid = [];
  List<bool> cardFlipped = [];
  int? firstIndex;
  int? secondIndex;
  bool waiting = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _showWelcomeDialog);
    _initializeGame();
  }

  void _initializeGame() {
    List<String> pairs = [...images, ...images];
    pairs.shuffle(Random());
    gameGrid = List.from(pairs);
    cardFlipped = List.generate(12, (_) => false);
    firstIndex = null;
    secondIndex = null;
    waiting = false;
  }

  void _showWelcomeDialog() {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      title: 'Witaj w grze Memory!',
      desc: 'Znajdź wszystkie pary, żeby odkryć kolejną literkę!',
      btnOkText: 'Zaczynamy!',
      btnOkOnPress: () {},
    ).show();
  }

  void _flipCard(int index) {
    if (waiting || cardFlipped[index]) return;

    setState(() {
      if (firstIndex == null) {
        firstIndex = index;
      } else if (secondIndex == null) {
        secondIndex = index;
        waiting = true;
        Future.delayed(const Duration(seconds: 1), _checkMatch);
      }
    });
  }

  void _checkMatch() {
    setState(() {
      if (gameGrid[firstIndex!] == gameGrid[secondIndex!]) {
        cardFlipped[firstIndex!] = true;
        cardFlipped[secondIndex!] = true;
      }

      firstIndex = null;
      secondIndex = null;
      waiting = false;

      if (cardFlipped.every((flipped) => flipped)) {
        _showWinDialog();
      }
    });
  }

  void _showWinDialog() {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'Gratulacje!',
      desc: 'Ułożono wszystkie pary!',
      btnOkText: 'Powrót!',
      btnOkOnPress: () {
        Navigator.pop(context, true);
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0c4767),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/hangman_tlo.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                "Memory!",
                style: TextStyle(
                  color: Color(0xff2F3316),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: gameGrid.length,
                  itemBuilder: (context, index) {
                    return FlipCard(
                      flipped: cardFlipped[index] ||
                          index == firstIndex ||
                          index == secondIndex,
                      onTap: () => _flipCard(index),
                      front: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          gameGrid[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF556704),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.question_mark,
                          size: 32,
                          color: Color(0xFFE8F3B2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
