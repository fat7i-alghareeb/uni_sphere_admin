import 'package:flutter/material.dart';

mixin GridAnimationMixin<T extends StatefulWidget>
    on TickerProviderStateMixin<T> {
  List<AnimationController> controllers = [];
  List<Animation<double>> fadeAnimations = [];
  List<Animation<Offset>> slideAnimations = [];
  List<Animation<double>> flipAnimations = [];

  void initAnimations({
    required int itemCount,
    int duration = 500,
    bool haveFlipAnimation = true,
    bool haveSlideAnimation = true,
    bool haveFadeAnimation = true,
    Offset startSlideOffset = const Offset(0, 50),
    double startFade = 0.5,
    double startFlip = 0.5,
  }) {
    disposeAnimations();
    controllers = List.generate(
      itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: duration),
      ),
    );

    // Conditionally initialize fade animations
    if (haveFadeAnimation) {
      fadeAnimations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: startFade, end: 1).animate(
          CurvedAnimation(parent: controllers[index], curve: Curves.easeIn),
        ),
      );
    } else {
      fadeAnimations = List.generate(
        itemCount,
        (_) => const AlwaysStoppedAnimation(1), // No fade effect, fully visible
      );
    }

    // Conditionally initialize slide animations
    if (haveSlideAnimation) {
      slideAnimations = List.generate(
        itemCount,
        (index) => Tween<Offset>(
          begin: startSlideOffset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: controllers[index], curve: Curves.easeOut),
        ),
      );
    } else {
      slideAnimations = List.generate(
        itemCount,
        (_) => const AlwaysStoppedAnimation(Offset.zero), // No slide effect
      );
    }

    // Conditionally initialize flip animations
    if (haveFlipAnimation) {
      flipAnimations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: startFlip, end: 1).animate(
          CurvedAnimation(parent: controllers[index], curve: Curves.easeInOut),
        ),
      );
    } else {
      flipAnimations = List.generate(
        itemCount,
        (_) => const AlwaysStoppedAnimation(1), // No flip effect
      );
    }

    startAnimations();
  }

  void startAnimations() {
    for (int i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (controllers[i].status == AnimationStatus.dismissed) {
          controllers[i].reset();
          controllers[i].forward();
        }
      });
    }
  }

  void disposeAnimations() {
    for (var controller in controllers) {
      controller.dispose();
    }
    controllers.clear();
    fadeAnimations.clear();
    slideAnimations.clear();
    flipAnimations.clear();
  }
}
