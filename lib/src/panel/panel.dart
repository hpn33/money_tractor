import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import 'package:money_tractor/src/panel/translationMenu/amoungInput.dart';

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
      stream: watch(dbProvider).init().asStream(),
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
            return ListView(
              children: [
                for (var item in watch(listProvider).state) TCard(item),
              ],
            );
          },
        );
      },
    );
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: isIncome ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: cColor[50],
            border: Border(bottom: BorderSide(color: cColor)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$sign ${item.amoung}",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Text(
          '01/10/2020',
          style: TextStyle(
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
