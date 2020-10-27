import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/src/panel/translation/TranslationDialog.dart';

class SubmitButton extends ConsumerWidget {
  final void Function(BuildContext) onPress;

  SubmitButton([this.onPress]);

  @override
  Widget build(BuildContext context, watch) {
    final amoungText = watch(TranslationDialog.amoungProvider).state;

    final isNotActive = getActiveButton(amoungText);
    final cColor = getColor(watch);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isNotActive ? cColor[100] : cColor,
        ),
        alignment: Alignment.center,
        height: 52,
        width: double.infinity,
        child: Text(
          'Sumbit',
          style: TextStyle(
            color: isNotActive ? cColor[200] : Colors.white,
          ),
        ),
      ),
      onTap: isNotActive ? null : () => onPress(context),
    );
  }

  MaterialColor getColor(ScopedReader watch) =>
      watch(TranslationDialog.activeProvider).state
          ? watch(TranslationDialog.typeProvider).state
              ? Colors.green
              : Colors.red
          : Colors.grey;

  bool getActiveButton(String amoungText) =>
      amoungText == '' || amoungText.trim() == '' || amoungText.isEmpty;
}
