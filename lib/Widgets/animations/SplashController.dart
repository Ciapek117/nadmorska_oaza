import 'package:flutter/material.dart';

class SplashController {
  late AnimationController windController;
  late AnimationController enterController;

  late Animation<double> wind;
  late Animation<double> signDrop;
  late Animation<double> zoom;

  SplashController(TickerProvider vsync) {
    windController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );

    enterController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );

    wind = Tween(begin: -0.03, end: 0.03).animate(
      CurvedAnimation(parent: windController, curve: Curves.easeInOut),
    );

    signDrop = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: enterController, curve: Curves.easeIn),
    );

    zoom = Tween(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: enterController, curve: Curves.easeInOut),
    );
  }

  void start() {
    windController.repeat(reverse: true);
    enterController.forward();
  }

  void dispose() {
    windController.dispose();
    enterController.dispose();
  }
}
