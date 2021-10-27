import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../translation_menu.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastEdit extends StatelessWidget {
  const LastEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if not updateMode -> nothing show
    if (context.read(TranslationMenu.idProvider).state == -1) {
      return const SizedBox();
    }

    final createFormated =
        dateFormat(context.read(TranslationMenu.createAtProvider).state);
    final updateFormated =
        dateFormat(context.read(TranslationMenu.updateAtProvider).state);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Create: '),
              Text(
                createFormated,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Edit: '),
              Text(
                updateFormated,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime? date) =>
      date == null ? 'null' : DateFormat('yyyy-MM-dd   kk:mm').format(date);
}
