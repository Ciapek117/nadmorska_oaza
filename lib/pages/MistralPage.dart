import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class MistralPage extends StatefulWidget {
  @override
  _MistralPageState createState() => _MistralPageState();
}

class _MistralPageState extends State<MistralPage> {
  final List<String> questions = [
    "Co jest flagowym produktem Mistrala?",
    "Jaka jest pełna nazwa mistrala?",
    "Ile jest w Ustce punktów firmy Mistral?"
  ];
  final List<String> answers = ["Krówka", "Cafe Mistral", "3"];
  List<TextEditingController> controllers =
  List.generate(3, (index) => TextEditingController());
  List<bool> isCorrect = [false, false, false];
  int currentIndex = 0;
  bool allCorrect = false;
  Color containerColor = Colors.black.withOpacity(0.5);

  void checkAllCorrect() {
    allCorrect = isCorrect.every((correct) => correct);
  }

  void _showWrongAnswerEffect() {
    setState(() {
      containerColor = Colors.red.withOpacity(0.7);
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        containerColor = Colors.black.withOpacity(0.5);
      });
    });
  }

  void checkAnswer() {
    setState(() {
      if (controllers[currentIndex].text.trim().toLowerCase() ==
          answers[currentIndex].toLowerCase()) {
        isCorrect[currentIndex] = true;
      } else {
        _showWrongAnswerEffect();
      }
      checkAllCorrect();
    });
  }

  @override
  Widget build(BuildContext context) {
      if (allCorrect) {
        Future.delayed(Duration.zero, () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Gratulacje!',
            desc: 'Udało się poprawnie odpowiedzieć na pytanie!',
            btnOkText: 'Powrót',
            btnOkOnPress: () {
              Navigator.pop(context, true);
            },
            dismissOnTouchOutside: false,
          ).show();
        });
      }

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "images/question_tlo.png",
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                width: 300,
                height: 500,
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCorrect[currentIndex]
                      ? Colors.green.withOpacity(0.7)
                      : containerColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      questions[currentIndex],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0XffE8F3B2),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: controllers[currentIndex],
                      enabled: !isCorrect[currentIndex],
                      style: TextStyle(color: Color(0xFFE8F3B2)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE8F3B2).withOpacity(0.3),

                        // normalna ramka
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE8F3B2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        // 🔥 ramka gdy TextField jest aktywny
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE8F3B2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        hintStyle: TextStyle(color: Color(0xFFE8F3B2)),
                      ),

                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "images/arrow_left.png",
                            width: 30,
                            color: currentIndex > 0 ? Color(0xFFE8F3B2) : Colors.grey,
                          ),
                          onPressed: currentIndex > 0
                              ? () => setState(() => currentIndex--)
                              : null,
                        ),
                        ElevatedButton(
                          onPressed: isCorrect[currentIndex] ? null : checkAnswer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFB2D102).withOpacity(0.8),
                          ),
                          child: Text("Sprawdź", style: TextStyle(color: Colors.white)),
                        ),
                        IconButton(
                          icon: Image.asset(
                            "images/arrow_right.png",
                            width: 30,
                            color: currentIndex < questions.length - 1 ? Color(0xFFE8F3B2) : Colors.grey,
                          ),
                          onPressed: currentIndex < questions.length - 1
                              ? () => setState(() => currentIndex++)
                              : null,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

