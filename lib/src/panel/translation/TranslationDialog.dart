import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import '../panel.dart';
import 'component/amoungInput.dart';
import 'component/submitButton.dart';
import 'component/switchTypePayment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationDialog extends StatelessWidget {
  static final idProvider = StateProvider((ref) => -1);
  static final typeProvider = StateProvider((ref) => true);
  static final amoungProvider = StateProvider((ref) => '0');
  static final activeProvider = StateProvider((ref) => true);
  static final createAtProvider = StateProvider((ref) => DateTime.now());
  static final updateAtProvider = StateProvider((ref) => DateTime.now());

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
                SwitchTypePayment(),
                SizedBox(height: 20),
                AmoungInput(),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                activeButton(),
                Divider(),
                lastEdit(context),
              ],
            ),
          ),
          SizedBox(height: 50),
          SubmitButton(submit),
        ],
      ),
    );
  }

  Widget lastEdit(BuildContext context) {
    // if not updateMode -> nothing show
    if (context.read(idProvider).state == -1) return SizedBox();

    final createDate = context.read(createAtProvider).state;
    final createFormated = DateFormat('yyyy-MM-dd   kk:mm').format(createDate);

    final updateDate = context.read(updateAtProvider).state;
    final updateFormated = DateFormat('yyyy-MM-dd   kk:mm').format(updateDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Create: '),
              Text(
                createFormated,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Edit: '),
              Text(
                updateFormated,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
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

  void submit(BuildContext context) async {
    final db = context.read(dbProvider);
    final amoungText = context.read(amoungProvider).state;
    final id = context.read(idProvider).state;

    final isInsert = id == -1;

    final translation = Translation(
      id: isInsert ? null : id,
      amoung: amoungText == '' ? 0 : int.parse(amoungText),
      type: context.read(typeProvider).state ? 1 : 0,
      active: context.read(activeProvider).state ? 1 : 0,
      createAt:
          isInsert ? DateTime.now() : context.read(createAtProvider).state,
      updateAt: DateTime.now(),
    );

    final result = isInsert
        ? await db.translation.insert(translation)
        : await db.translation.update(translation);

    if (result != 0) context.refresh(Panel.listProvider);

    Navigator.pop(context);
  }

  static void resetData(BuildContext context) {
    context.read(typeProvider).state = true;
    context.read(amoungProvider).state = '0';
    context.read(idProvider).state = -1;
    context.read(activeProvider).state = true;
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
