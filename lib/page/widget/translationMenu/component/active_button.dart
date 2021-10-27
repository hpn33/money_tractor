import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../translation_menu.dart';

class ActiveButton extends ConsumerWidget {
  const ActiveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final active = watch(TranslationMenu.activeProvider).state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(active ? 'active' : 'deactive'),
          Switch(
            value: active,
            onChanged: (bool value) {
              context.read(TranslationMenu.activeProvider).state = value;
            },
          ),
        ],
      ),
    );
  }
}
