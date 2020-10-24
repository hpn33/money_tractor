import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Objective.dart';

import '../panel.dart';

class AddObjective extends ConsumerWidget {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context, watch) {
    final db = watch(dbProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('add Objective'),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'title'),
            ),
            RaisedButton(
              child: Text('sumbit'),
              onPressed: () async {
                final result = await db.objective
                    .insert(Objective(title: titleController.text));

                if (result != 0)
                  context.read(listProvider).state = await db.translation.all();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
