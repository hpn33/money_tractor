import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../TranslationMenu.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if not updateMode -> nothing show
    if (context.read(TranslationMenu.idProvider).state == -1) return SizedBox();

    final createDate = context.read(TranslationMenu.createAtProvider).state;
    final createFormated = DateFormat('yyyy-MM-dd   kk:mm').format(createDate);

    final updateDate = context.read(TranslationMenu.updateAtProvider).state;
    final updateFormated = DateFormat('yyyy-MM-dd   kk:mm').format(updateDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Create: '),
              Text(
                createFormated,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Edit: '),
              Text(
                updateFormated,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
