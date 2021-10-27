import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tractor/page/panel/panel.dart';
import 'package:money_tractor/service/db/model/translation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'translationMenu/translation_menu.dart';

class TranslationDetailDialog extends StatelessWidget {
  final Translation item;

  final bool isIncome;
  final bool isActive;

  TranslationDetailDialog(this.item, {Key? key})
      : isIncome = item.type,
        isActive = item.active,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? isIncome
            ? Colors.green
            : Colors.red
        : Colors.grey;

    print(item);
    return Dialog(
      backgroundColor: color[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                typeInfo(context, color),
                const Divider(),
                amoungInfo(color),
                const Divider(),
                dateInfo(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              height: 3,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Padding dateInfo() {
    final createFormated = item.createAt == null
        ? 'null'
        : DateFormat('yyyy-MM-dd   kk:mm').format(item.createAt);

    final updateFormated = item.updateAt == null
        ? 'null'
        : DateFormat('yyyy-MM-dd   kk:mm').format(item.updateAt);

    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
        left: 8,
        top: 28,
        bottom: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('create'),
              Text(
                createFormated,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('edit'),
              Text(
                updateFormated,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding amoungInfo(MaterialColor color) {
    final sign = isIncome ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'amoung',
            style: TextStyle(
              color: color,
            ),
          ),
          Text(
            '$sign ${item.formatedAmoung}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Row typeInfo(BuildContext context, MaterialColor color) {
    final typeText = isIncome ? 'Add' : 'Sub';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              typeText,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              isActive ? 'Active' : 'DeActive',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                TranslationMenu.setItem(context, item);

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (c) => const TranslationMenu(),
                ).then((value) => context.refresh(Panel.listProvider));
              },
            ),
            const SizedBox(width: 5),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await item.delete(context);
                context.refresh(Panel.listProvider);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
