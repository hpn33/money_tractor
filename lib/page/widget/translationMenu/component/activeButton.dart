import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

import '../TranslationMenu.dart';

class ActiveButton extends ConsumerWidget {
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
