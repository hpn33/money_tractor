import 'package:flutter/material.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import '../panel.dart';
import 'component/amoungInput.dart';
import 'component/submitButton.dart';
import 'component/switchTypePayment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final idProvider = StateProvider((ref) => -1);
final typeProvider = StateProvider((ref) => true);
final amoungProvider = StateProvider((ref) => '0');
final activeProvider = StateProvider((ref) => true);

class TranslationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchTypePayment(typeProvider),
                SizedBox(height: 20),
                AmoungInput(amoungProvider),
                SizedBox(height: 20),
                activeButton(),
              ],
            ),
          ),
          SizedBox(height: 50),
          SubmitButton(
            amoungProvider,
            typeProvider,
            context.read(idProvider).state == -1 ? insert : update,
          ),
        ],
      ),
    );
  }

  Widget activeButton() {
    return Consumer(
      builder: (
        BuildContext context,
        T Function<T>(ProviderBase<Object, T>) watch,
        Widget child,
      ) {
        final active = watch(activeProvider).state;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(active ? 'active' : 'deactive'),
              Switch(
                value: active,
                onChanged: (bool value) {
                  context.read(activeProvider).state = value;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void insert(BuildContext context) async {
    final db = context.read(dbProvider);
    final amoungText = context.read(amoungProvider).state;

    final result = await db.translation.insert(
      Translation(
        amoung: amoungText == '' ? 0 : int.parse(amoungText),
        type: context.read(typeProvider).state ? 1 : 0,
        active: context.read(activeProvider).state ? 1 : 0,
      ),
    );

    if (result != 0) context.refresh(listProvider);

    Navigator.pop(context);
  }

  void update(BuildContext context) async {
    final db = context.read(dbProvider);
    final amoungText = context.read(amoungProvider).state;

    final result = await db.translation.update(
      Translation(
        id: context.read(idProvider).state,
        amoung: amoungText == '' ? 0 : int.parse(amoungText),
        type: context.read(typeProvider).state ? 1 : 0,
        active: context.read(activeProvider).state ? 1 : 0,
      ),
    );

    if (result != 0) context.refresh(listProvider);

    Navigator.pop(context);
  }
}

// final selectedObjId = StateProvider<int>((ref) => -1);

// class ObjectiveMenu extends ConsumerWidget {
//   // final objectivesList = FutureProvider<List<Objective>>(
//   //     (ref) => ref.read(dbProvider).objective.all());

//   @override
//   Widget build(BuildContext context, watch) {
//     final selectedId = watch(selectedObjId).state;

//     return watch(objectivesList).when(
//       data: (l) {
//         final list = [Objective(id: 0), ...l];

//         return DropdownButton<int>(
//           hint: Text("Select item"),
//           value: list.isNotEmpty && selectedId == -1 ? list[0].id : selectedId,
//           onChanged: (int value) {
//             context.read(selectedObjId).state = value;
//           },
//           items: list.map(
//             (Objective obj) {
//               return DropdownMenuItem<int>(
//                 value: obj.id,
//                 child: Text('${obj.id} :${obj.title}'),
//               );
//             },
//           ).toList(),
//         );
//       },
//       loading: () => CircularProgressIndicator(),
//       error: (e, s) => RaisedButton(
//         child: Text('refresh'),
//         onPressed: () {
//           context.refresh(objectivesList);
//         },
//       ),
//     );
//   }
// }
