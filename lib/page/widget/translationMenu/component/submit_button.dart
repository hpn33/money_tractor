import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_tractor/page/panel/panel.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/translation.dart';

import '../translation_menu.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final amoungText = watch(TranslationMenu.amoungProvider).state;

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
      onTap: isNotActive ? null : () => submit(context),
    );
  }

  void submit(BuildContext context) async {
    final db = context.read(dbProvider);
    final amoungText = context.read(TranslationMenu.amoungProvider).state;
    final id = context.read(TranslationMenu.idProvider).state;

    final isInsert = id == -1;

    final translation = Translation(
      id: isInsert ? null : id,
      amoung: amoungText == '' ? 0 : int.parse(amoungText),
      type: context.read(TranslationMenu.typeProvider).state,
      active: context.read(TranslationMenu.activeProvider).state,
      createAt: isInsert
          ? DateTime.now()
          : context.read(TranslationMenu.createAtProvider).state,
      updateAt: DateTime.now(),
    );

    final result = isInsert
        ? await db.translation.insert(translation)
        : await db.translation.update(translation);

    if (result != 0) context.refresh(Panel.listProvider);

    TranslationMenu.resetData(context);
    Navigator.pop(context);
  }

  MaterialColor getColor(ScopedReader watch) =>
      watch(TranslationMenu.activeProvider).state
          ? watch(TranslationMenu.typeProvider).state
              ? Colors.green
              : Colors.red
          : Colors.grey;

  bool getActiveButton(String amoungText) =>
      amoungText == '' || amoungText.trim() == '' || amoungText.isEmpty;
}
