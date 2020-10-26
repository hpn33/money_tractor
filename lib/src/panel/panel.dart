import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart' as intl;
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';

import 'translationMenu/addTDialog.dart';

final listProvider = StateProvider<List<Translation>>((ref) => []);

class Panel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: appBar(context),
      body: body(watch),
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
              builder: (context) => AddTranslation(),
            );
          },
        ),
      ],
    );
  }

  Widget body(watch) {
    return StreamBuilder(
      stream: watch(dbProvider).open().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        context
            .read(dbProvider)
            .translation
            .all()
            .then((value) => context.read(listProvider).state = value);

        return Consumer(
          builder: (
            BuildContext context,
            T Function<T>(ProviderBase<Object, T>) watch,
            Widget child,
          ) {
            final list = watch(listProvider).state;
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
        );
      },
    );
  }

  int sumAmoungs(List<Translation> list) {
    var sum = 0;

    for (var item in list) {
      final sign = item.type == 1 ? 1 : -1;

      sum += sign * item.amoung;
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
    final isIncome = item.type == 1;
    final cColor = isIncome ? Colors.green : Colors.red;
    final sign = isIncome ? '+' : '-';
    final amoung = intl.NumberFormat("###,###", "en_US").format(item.amoung);

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: isIncome ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: cColor[50],
            border: Border(bottom: BorderSide(color: cColor)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$sign $amoung",
              style: TextStyle(fontSize: 16),
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
    );
  }
}
