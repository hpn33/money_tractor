import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Objective.dart';
import 'package:money_tractor/service/db/model/Translation.dart';

import '../panel.dart';

class AddTranslation extends ConsumerWidget {
  final amoungController = TextEditingController();
  final switchValueProvider = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, watch) {
    final db = watch(dbProvider);
    final switchValue = watch(switchValueProvider).state;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('add Translation'),
            ObjectiveMenu(),
            TextField(
              controller: amoungController,
              decoration: InputDecoration(labelText: 'amoung'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(switchValue ? 'دریافت' : 'برداشت'),
                Switch(
                  value: switchValue,
                  onChanged: (v) => context.read(switchValueProvider).state = v,
                ),
              ],
            ),
            RaisedButton(
              child: Text('sumbit'),
              onPressed: () async {
                final result = await db.translation.insert(
                  Translation(
                    objectiveId: context.read(selectedObjId).state,
                    amoung: amoungController.text == ''
                        ? 0
                        : int.parse(amoungController.text),
                    type: switchValue ? 1 : 0,
                  ),
                );

                if (result != 0)
                  context.read(listProvider).state = await db.translation.all();

                context.read(selectedObjId).state = -1;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

final selectedObjId = StateProvider<int>((ref) => -1);

class ObjectiveMenu extends ConsumerWidget {
  final objectivesList = FutureProvider<List<Objective>>(
      (ref) => ref.read(dbProvider).objective.all());

  @override
  Widget build(BuildContext context, watch) {
    final selectedId = watch(selectedObjId).state;

    return watch(objectivesList).when(
      data: (l) {
        final list = [Objective(id: 0), ...l];

        return DropdownButton<int>(
          hint: Text("Select item"),
          value: list.isNotEmpty && selectedId == -1 ? list[0].id : selectedId,
          onChanged: (int value) {
            context.read(selectedObjId).state = value;
          },
          items: list.map(
            (Objective obj) {
              return DropdownMenuItem<int>(
                value: obj.id,
                child: Text('${obj.id} :${obj.title}'),
              );
            },
          ).toList(),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (e, s) => RaisedButton(
        child: Text('refresh'),
        onPressed: () {
          context.refresh(objectivesList);
        },
      ),
    );
  }
}
