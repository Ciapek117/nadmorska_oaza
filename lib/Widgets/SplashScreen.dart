import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mala_atlantyda/auth/UserPage.dart';
import 'animations/SplashAssets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoOffset;

  late Animation<double> _signOpacity;
  late Animation<Offset> _signOffset;

  late AnimationController _exitController;

  late Animation<double> _signExitOpacity;
  late Animation<Offset> _signExitOffset;
  late Animation<double> _signPressScale;
  late Animation<double> _sceneZoom;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut)),
    );

    _logoOffset = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );

    _signOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );

    _signOffset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.elasticOut)),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });

    _signExitOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _exitController, curve: const Interval(0.0, 0.4)),
    );

    _signExitOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.2),
    ).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInBack),
    );

    _sceneZoom = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _signPressScale = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(
        parent: _exitController,
        curve: const Interval(0.0, 0.15, curve: Curves.easeOut),
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ScaleTransition(
        scale: _sceneZoom,
        child: SizedBox.expand(
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
                top: size.height * -0.06,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: FadeTransition(
                    opacity: _logoOpacity,
                    child: SlideTransition(
                      position: _logoOffset,
                      child: Center(
                        child: Image.asset(
                          SplashAssets.logo,
                          width: size.width * 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
        
        
        
        
              // ===== TŁO – DALeki las =====
        
              tree(
                left: size.width * 0.28,
                bottom: size.height * 0.50,
                height: size.height * 0.23,
                asset: SplashAssets.trees[0],
                opacity: 0.30,
                blur: 3,
                tint: const Color(0xFF9AC27A),
              ),
              tree(
                right: -size.width * 0.17,
                bottom: size.height * 0.46,
                height: size.height * 0.30,
                asset: SplashAssets.trees[2],
                opacity: 0.40,
                blur: 3,
                tint: const Color(0xFF9AC27A),
              ),
        
        
        
              //1
        
              // ===== ŚRODEK – ściany lasu =====
              tree(
                left: -size.width * 0.12,
                bottom: size.height * 0.45,
                height: size.height * 0.30,
                asset: SplashAssets.trees[2],
                opacity: 0.8,
                blur: 2,
                tint: const Color(0xFF9AC27A),
              ),
              tree(
                left: -size.width * 0.22,
                bottom: size.height * 0.26,
                height: size.height * 0.42,
                opacity: 0.7,
                asset: SplashAssets.trees[0],
              ),
              tree(
                right: -size.width * 0.02,
                bottom: size.height * 0.26,
                height: size.height * 0.44,
                opacity: 0.80,
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
                right: -size.width * 0.45,
                bottom: size.height * 0.10,
                height: size.height * 0.68,
                asset: SplashAssets.trees[1],
              ),
        
        
              // 🪵 TABLICZKA = PRZYCISK "WEJDŹ DO GRY"
              Positioned(
                bottom: size.height * 0.03,
                left: 0,
                right: 0,
                child: FadeTransition(            // 🟢 INTRO
                  opacity: _signOpacity,
                  child: SlideTransition(
                    position: _signOffset,
                    child: FadeTransition(        // 🔵 EXIT
                      opacity: _signExitOpacity,
                      child: SlideTransition(
                        position: _signExitOffset,
                        child: ScaleTransition(
                          scale: _signPressScale,
                          child: Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                if (_exitController.isAnimating) return;

                                await _exitController.forward();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UserPage(),
                                  ),
                                );
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

                                  // 🎯 PRZYCISK NA ŚRODKU SZERSZEJ DESKI
                                  Positioned.fill(
                                    child: Align(
                                      alignment: const Alignment(0, -0.15), // ← TYM STERUJESZ
                                      child: Text(
                                        'Wejdź do gry',
                                        style: TextStyle(
                                          fontSize: size.width * 0.075,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // 🌿 TRAWA / KRZAKI (NAJPRZEDNIEJ)
              Positioned(
                bottom: -size.height * 0.01,
                left: -size.width * 0.05,
                right: -size.width * 0.05,
                child: IgnorePointer(
                  ignoring: true,
                  child: Transform.scale(
                    scale: 1.15, // 🔥 tu powiększasz
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      SplashAssets.grass,
                      fit: BoxFit.cover,
                    ),
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



