import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hooks_riverpod/all.dart';

import '../TranslationMenu.dart';

class AmoungInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialValue =
        double.parse(context.read(TranslationMenu.amoungProvider).state);
    final lowPrice = MoneyMaskedTextController(
      initialValue: initialValue,
      precision: 0,
      decimalSeparator: '',
    );

    return TextField(
      controller: lowPrice,
      onChanged: (text) {
        context.read(TranslationMenu.amoungProvider).state =
            lowPrice.numberValue.toInt().toString();
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(labelText: 'amoung'),
    );
  }
}
