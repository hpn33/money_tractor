import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Timer useTimerPeriodic({
  required Duration duration,
  required void Function(Timer) callback,
}) {
  return use(
    _TimerPeriodicHook(
      duration: duration,
      callback: callback,
    ),
  );
}

class _TimerPeriodicHook extends Hook<Timer> {
  const _TimerPeriodicHook({
    required this.duration,
    required this.callback,
  });

  final Duration duration;
  final void Function(Timer) callback;

  @override
  _TimerPeriodicHookState createState() => _TimerPeriodicHookState();
}

class _TimerPeriodicHookState extends HookState<Timer, _TimerPeriodicHook> {
  Timer? timer;

  @override
  void initHook() {
    super.initHook();
    timer = Timer.periodic(hook.duration, hook.callback);
  }

  @override
  Timer build(BuildContext context) => timer!;

  @override
  void dispose() {
    timer!.cancel();
    timer = null;
  }

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useAnimationController';
}
