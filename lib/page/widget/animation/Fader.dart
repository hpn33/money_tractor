import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Fader extends HookWidget {
  final Widget child;

  const Fader(this.child, {Key? key}) : super(key: key);

  AnimationController _animationController;

  void show() async => _animationController.forward();

  void hide() async => _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    _animationController = useAnimationController(
      duration: Duration(milliseconds: 350),
    );

    useEffect(() {
      _animationController.forward();

      return () {};
    }, []);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (cx, _) => Opacity(
        opacity: _animationController.value,
        child: child,
      ),
    );
  }
}

class FaderManual extends HookWidget {
  final Widget child;

  final AnimationController controller;
  final double animation;

  FaderManual({Key key, this.controller, this.animation, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (cx, _) => Opacity(
        opacity: animation,
        child: child,
      ),
    );
  }
}
