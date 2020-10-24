import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Objective.dart';
import 'package:money_tractor/service/db/model/Translation.dart';

import 'component/addODialog.dart';
import 'component/addTDialog.dart';

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
        FlatButton(
          child: Text(
            'add Objective',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddObjective(),
            );
          },
        ),
        FlatButton(
          child: Text(
            'add Translation',
            style: TextStyle(color: Colors.white),
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

  final getObjectiveByIdProvider = FutureProvider.family<Objective, int>(
      (ref, id) => ref.read(dbProvider).objective.getById(id));

  @override
  Widget build(BuildContext context, watch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: item.type == 0 ? Colors.red[100] : Colors.green[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.amoung.toString()),
                ],
              ),
            ),
          ),
          if (item.objectiveId > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.grey,
                ),
                child: watch(getObjectiveByIdProvider(item.objectiveId)).when(
                  data: (item) => Text(item.title),
                  loading: () => Text('wait...'),
                  error: (e, s) => Text(e),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
