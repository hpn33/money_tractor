import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/src/panel/panel.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer timer;

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
                ),
              ),
              AssetIcon(
                loader: dbLoader,
                onComplete: (value) {
                  timer = Timer.periodic(
                    Duration(seconds: 3),
                    (timer) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (c) => Panel()),
                      );
                    },
                  );
                },
              ),
              Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}

final dbLoader = FutureProvider((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return ref.read(dbProvider).open();
});

class AssetIcon extends ConsumerWidget {
  final FutureProvider<bool> loader;
  final void Function(bool) onComplete;

  AssetIcon({this.loader, this.onComplete});

  @override
  Widget build(BuildContext context, watch) {
    return watch(loader).when(
      data: (value) {
        onComplete(value);

        return icon(
          'database',
          value ? Colors.green : Colors.red,
        );
      },
      loading: () => icon('database', Colors.orange),
      error: (Object error, StackTrace stackTrace) =>
          icon('database', Colors.red),
    );
  }

  Widget icon(String title, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.data_usage,
          color: color,
        ),
        Text(title),
      ],
    );
  }
}
