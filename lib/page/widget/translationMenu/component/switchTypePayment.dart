import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../TranslationMenu.dart';

class SwitchTypePayment extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final selected = watch(TranslationMenu.typeProvider).state;

    return Container(
      height: 52,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read(TranslationMenu.typeProvider).state = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                  color: selected == false ? null : Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: Text('Sub'),
              ),
            ),
          ),
          Container(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read(TranslationMenu.typeProvider).state = true;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                  ),
                  color: selected == true ? null : Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Add',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
