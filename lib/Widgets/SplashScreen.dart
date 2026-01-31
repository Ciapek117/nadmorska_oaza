import 'dart:ui';

import 'package:flutter/material.dart';
import 'animations/SplashAssets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // 🟢 TŁO
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, 0.2),
                  radius: 1.1,
                  colors: [
                    Color(0xFF6FAF2E),
                    Color(0xFF3F6E1C),
                  ],
                ),
              ),
            ),

            // 🟢 LOGO NA GÓRZE
            Positioned(
              top: size.height * -0.06, // 🔥 lekko WYCHODZI nad ekran
              left: 0,
              right: 0,
              child: SafeArea( // żeby nie wchodziło w notch / pasek
                bottom: false,
                child: Center(
                  child: Image.asset(
                    SplashAssets.logo,
                    width: size.width * 0.8, // odrobinę mniejsze = wygląda wyżej
                  ),
                ),
              ),
            ),




            // ===== TŁO – DALeki las =====
            tree(
              left: -size.width * 0.10,
              bottom: size.height * 0.48,
              height: size.height * 0.25,
              asset: SplashAssets.trees[2],
              opacity: 0.22,
              blur: 3,
              tint: const Color(0xFF9AC27A),
            ),
            tree(
              left: size.width * 0.28,
              bottom: size.height * 0.50,
              height: size.height * 0.23,
              asset: SplashAssets.trees[0],
              opacity: 0.20,
              blur: 3,
              tint: const Color(0xFF9AC27A),
            ),
            tree(
              right: -size.width * 0.12,
              bottom: size.height * 0.48,
              height: size.height * 0.25,
              asset: SplashAssets.trees[1],
              opacity: 0.22,
              blur: 3,
              tint: const Color(0xFF9AC27A),
            ),



            //1

            // ===== ŚRODEK – ściany lasu =====
            tree(
              left: -size.width * 0.22,
              bottom: size.height * 0.26,
              height: size.height * 0.42,
              asset: SplashAssets.trees[0],
            ),
            tree(
              right: -size.width * 0.22,
              bottom: size.height * 0.26,
              height: size.height * 0.44,
              asset: SplashAssets.trees[1],
            ),


            // ===== PRZÓD – rama =====
            tree(
              left: -size.width * 0.34,
              bottom: size.height * 0.08,
              height: size.height * 0.64,
              asset: SplashAssets.trees[0],
            ),
            tree(
              right: -size.width * 0.30,
              bottom: size.height * 0.10,
              height: size.height * 0.68,
              asset: SplashAssets.trees[1],
            ),


            // 🪵 TABLICZKA = PRZYCISK "WEJDŹ DO GRY"
            Positioned(
              bottom: size.height * 0.03,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: nawigacja do gry
                    // Navigator.pushReplacement(...);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.06,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          SplashAssets.sign,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -30),
                        child: Text(
                          'Wejdź do gry',
                          style: TextStyle(
                            fontSize: size.width * 0.075, // lekko mniejsze = lepiej siada
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEFF7D5),
                            shadows: const [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black54,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),


            // 🌿 TRAWA / KRZAKI (NAJPRZEDNIEJ)
            Positioned(
              bottom: -size.height * 0.01,
              left: -size.width * 0.05,
              right: -size.width * 0.05,
              child: Transform.scale(
                scale: 1.15, // 🔥 tu powiększasz
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  SplashAssets.grass,
                  fit: BoxFit.cover,
                ),
              ),
            ),



            // 🟢 RAMKA / OKRĄG – DODATEK
            // 🟢 RAMKA / ŁUK GÓRNY – DEKORACJA
            Positioned(
              top: -size.height * 0.05,
              left: -size.width * 0.2,
              right: -size.width * 0.2,
              child: Image.asset(
                SplashAssets.frame,
                width: size.width * 1.4,
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.35),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget tree({
  double? left,
  double? right,
  required double bottom,
  required double height,
  required String asset,
  double opacity = 1,
  double blur = 0,
  Color? tint,
}) {
  Widget img = Image.asset(
    asset,
    height: height,
    color: tint,
    colorBlendMode: tint != null ? BlendMode.modulate : null,
  );

  if (blur > 0) {
    img = ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: blur,
        sigmaY: blur,
      ),
      child: img,
    );
  }

  return Positioned(
    left: left,
    right: right,
    bottom: bottom,
    child: Opacity(opacity: opacity, child: img),
  );
}



