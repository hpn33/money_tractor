import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import 'package:money_tractor/src/panel/translationMenu/switchTypePayment.dart';

import '../panel.dart';

final amoungProvider = StateProvider((ref) => '');

class SubmitButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final db = watch(dbProvider);
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
      onTap: isNotActive
          ? null
          : () async {
              final result = await db.translation.insert(
                Translation(
                  // objectiveId: context.read(selectedObjId).state,
                  amoung: amoungText == '' ? 0 : int.parse(amoungText),
                  type: context.read(typeProvider).state ? 1 : 0,
                ),
              );

              if (result != 0)
                context.read(listProvider).state = await db.translation.all();

              // context.read(selectedObjId).state = -1;
              Navigator.pop(context);
            },
    );
  }

  MaterialColor getTypeColor(watch) =>
      watch(typeProvider).state ? Colors.green : Colors.red;

  bool getActiveButton(String amoungText) =>
      amoungText == '' || amoungText.trim() == '' || amoungText.isEmpty;
}
