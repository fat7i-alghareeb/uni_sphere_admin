import 'package:flutter/material.dart';

mixin ListAnimationMixin<T extends StatefulWidget> on TickerProviderStateMixin<T> {
  List<AnimationController> controllers = [];
  List<Animation<double>> fadeAnimations = [];
  List<Animation<Offset>> slideAnimations = [];
  List<Animation<double>> scaleAnimations = [];

  void initListAnimations({
    required int itemCount,
    int duration = 500,
    bool haveScaleAnimation = true,
    bool haveSlideAnimation = true,
    bool haveFadeAnimation = true,
    Offset startSlideOffset = const Offset(0, 30),
    double startFade = 0.0,
    double startScale = 0.8,
  }) {
    disposeListAnimations();
    
    controllers = List.generate(
      itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: duration),
      ),
    );

    if (haveFadeAnimation) {
      fadeAnimations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: startFade, end: 1).animate(
          CurvedAnimation(parent: controllers[index], curve: Curves.easeIn),
        ),
      );
    } else {
      fadeAnimations = List.generate(itemCount, (_) => const AlwaysStoppedAnimation(1));
    }

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
      slideAnimations = List.generate(itemCount, (_) => const AlwaysStoppedAnimation(Offset.zero));
    }

    if (haveScaleAnimation) {
      scaleAnimations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: startScale, end: 1).animate(
          CurvedAnimation(parent: controllers[index], curve: Curves.easeInOut),
        ),
      );
    } else {
      scaleAnimations = List.generate(itemCount, (_) => const AlwaysStoppedAnimation(1));
    }

    startListAnimations();
  }

  void startListAnimations() {
    for (int i = 0; i < controllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (controllers[i].status == AnimationStatus.dismissed) {
          controllers[i].reset();
          controllers[i].forward();
        }
      });
    }
  }

  void disposeListAnimations() {
    for (var controller in controllers) {
      controller.dispose();
    }
    controllers.clear();
    fadeAnimations.clear();
    slideAnimations.clear();
    scaleAnimations.clear();
  }
}
