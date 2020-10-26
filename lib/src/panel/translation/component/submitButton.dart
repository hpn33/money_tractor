import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class SubmitButton extends ConsumerWidget {
  final void Function(BuildContext) onPress;
  final StateProvider<String> amoungProvider;
  final StateProvider<bool> typeProvider;

  SubmitButton(this.amoungProvider, this.typeProvider, [this.onPress]);

  @override
  Widget build(BuildContext context, watch) {
    final amoungText = watch(amoungProvider).state;

    final isNotActive = getActiveButton(amoungText);
    final typeColor = getTypeColor(watch);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isNotActive ? typeColor[100] : typeColor,
        ),
        alignment: Alignment.center,
        height: 52,
        width: double.infinity,
        child: Text(
          'Sumbit',
          style: TextStyle(
            color: isNotActive ? typeColor[200] : Colors.white,
          ),
        ),
      ),
      onTap: isNotActive ? null : () => onPress(context),
    );
  }

  MaterialColor getTypeColor(watch) =>
      watch(typeProvider).state ? Colors.green : Colors.red;

  bool getActiveButton(String amoungText) =>
      amoungText == '' || amoungText.trim() == '' || amoungText.isEmpty;
}