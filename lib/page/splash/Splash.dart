import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_tractor/page/panel/panel.dart';
import 'package:money_tractor/page/widget/animation/fader.dart';
import 'package:money_tractor/service/db/db_helper.dart';

class Splash extends HookWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1350),
    );

    final animation = useAnimation(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.1,
          0.300,
          curve: Curves.easeInOut,
        ),
      ),
    );

    final fade1 = useAnimation(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.5,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );
    final fade2 = useAnimation(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.9,
          curve: Curves.easeInOut,
        ),
      ),
    );
    final fade3 = useAnimation(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.7,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );
    void loadToGo() {
      if (animationController.isCompleted) {
        loading.value = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (c) => const Panel()),
        );
      }
    }

    useEffect(() {
      animationController.addListener(loadToGo);
      animationController.forward();

      return () {
        animationController.removeListener(loadToGo);
      };
    });

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: title(animationController, animation),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          FaderManual(
                            controller: animationController,
                            animation: fade1,
                            child: const AssetIcon(),
                          ),
                          FaderManual(
                            controller: animationController,
                            animation: fade2,
                            child: const AssetIcon(),
                          ),
                          FaderManual(
                            controller: animationController,
                            animation: fade3,
                            child: const AssetIcon(),
                          ),
                        ],
                      ),
                    ),
                    loading.value
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedBuilder title(
      AnimationController animationController, double animation) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        print(animation);

        return Column(
          children: [
            const Spacer(flex: 3),
            Center(
              child: Transform.translate(
                offset: Offset(0, -100 * (1 - animation)),
                child: Fader(
                  Text(
                    'Money Tractor',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}

// final dbLoader = FutureProvider((ref) async => ref.read(dbProvider).open());

class AssetIcon extends HookWidget {
  final FutureProvider<bool>? loader;
  final void Function(bool)? onComplete;

  const AssetIcon({this.loader, this.onComplete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon(),
        const Text('database'),
      ],
    );
  }

  Widget icon() {
    return FutureBuilder(
      future: useProvider(dbProvider).open(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return iconTemp(Colors.orange);
        }

        if (snapshot.hasError) return iconTemp(Colors.red);

        return iconTemp(snapshot.data != null && snapshot.data!
            ? Colors.green
            : Colors.red);
      },
    );
  }

  Widget iconTemp(Color color) => Icon(Icons.data_usage, color: color);
}
