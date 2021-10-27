import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../translation_menu.dart';

class SwitchTypePayment extends ConsumerWidget {
  const SwitchTypePayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final selected = watch(TranslationMenu.typeProvider).state;

    return SizedBox(
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                  color: selected == false ? null : Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: const Text('Sub'),
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
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(10)),
                  color: selected == true ? null : Colors.grey[300],
                ),
                alignment: Alignment.center,
                child: const Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
