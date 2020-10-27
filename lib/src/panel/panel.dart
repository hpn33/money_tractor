import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart' as intl;
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';

import 'translation/TranslationDialog.dart';

class Panel extends StatelessWidget {
  static final listProvider = FutureProvider<List<Translation>>((ref) {
    final db = ref.read(dbProvider);

    return db.translation.all();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      actions: [
        // FlatButton(
        //   child: Text(
        //     'add Objective',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (context) => AddObjective(),
        //     );
        //   },
        // ),
        FlatButton(
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.white),
              Text(
                'Add Translation',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => TranslationDialog(),
            ).then((value) => TranslationDialog.resetData(context));
          },
        ),
      ],
    );
  }

  Widget body(BuildContext context) {
    context.refresh(listProvider);

    return Consumer(
      builder: (
        BuildContext context,
        T Function<T>(ProviderBase<Object, T>) watch,
        Widget child,
      ) {
        return watch(listProvider).when(
          data: (list) {
            final sum = sumAmoungs(list);
            final sumText = sumFormater(sum);
            final sumColor = sum >= 0 ? Colors.green : Colors.red;

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      for (var item in list) TCard(item),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: sumColor[100],
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: sumColor,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  height: 52,
                  alignment: Alignment.center,
                  child: Text(sumText),
                ),
              ],
            );
          },
          error: (Object error, StackTrace stackTrace) => Text('$error'),
          loading: () => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  int sumAmoungs(List<Translation> list) {
    var sum = 0;

    for (var item in list) {
      final sign = item.type == 1 ? 1 : -1;

      if (item.active == 1) sum += sign * item.amoung;
    }
    return sum;
  }

  String sumFormater(int sum) {
    if (sum == 0) return '- 0 -';

    final sumFormated = intl.NumberFormat("###,###", "en_US").format(sum);
    final sign = sum.sign == -1 ? '-' : '+';

    return '$sign $sumFormated';
  }
}

class TCard extends ConsumerWidget {
  final Translation item;
  TCard(this.item);

  // final getObjectiveByIdProvider = FutureProvider.family<Objective, int>(
  //     (ref, id) => ref.read(dbProvider).objective.getById(id));

  @override
  Widget build(BuildContext context, watch) {
    final isActive = item.active == 1;
    final isIncome = item.type == 1;
    final cColor = isActive
        ? isIncome
            ? Colors.green
            : Colors.red
        : Colors.grey;

    final sign = isIncome ? '+' : '-';
    final amoung = intl.NumberFormat("###,###", "en_US").format(item.amoung);

    return GestureDetector(
      child: Row(
        textDirection: isIncome ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? cColor[50] : Colors.grey[200],
              border: Border(bottom: BorderSide(color: cColor)),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$sign $amoung",
                style: TextStyle(
                  fontSize: 16,
                  color: isActive ? null : Colors.grey,
                ),
              ),
            ),
          ),
          // Text(
          //   '01/10/2020',
          //   style: TextStyle(
          //     color: Colors.grey[300],
          //   ),
          // ),
        ],
      ),
      onLongPress: () {
        context.read(TranslationDialog.typeProvider).state = item.type == 1;
        context.read(TranslationDialog.amoungProvider).state =
            item.amoung.toString();
        context.read(TranslationDialog.idProvider).state = item.id;
        context.read(TranslationDialog.activeProvider).state = item.active == 1;
        context.read(TranslationDialog.createAtProvider).state = item.createAt;
        context.read(TranslationDialog.updateAtProvider).state = item.updateAt;

        showDialog(
          context: context,
          builder: (c) => TranslationDialog(),
        ).then((value) => TranslationDialog.resetData(context));
      },
    );
  }
}
