import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:money_tractor/src/panel/panel.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => Panel()),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Center(
                    child: Text(
                      'Money Tractor',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              )),
              Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
