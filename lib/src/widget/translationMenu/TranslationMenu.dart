import 'package:flutter/material.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import 'component/activeButton.dart';
import 'component/amoungInput.dart';
import 'component/lastEdit.dart';
import 'component/submitButton.dart';
import 'component/switchTypePayment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationMenu extends StatelessWidget {
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
                ActiveButton(),
                Divider(),
                LastEdit(),
              ],
            ),
          ),
          SizedBox(height: 50),
          SubmitButton(),
        ],
      ),
    );
  }

  static void resetData(BuildContext context) {
    context.read(typeProvider).state = true;
    context.read(amoungProvider).state = '0';
    context.read(idProvider).state = -1;
    context.read(activeProvider).state = true;
  }

  static void setItem(BuildContext context, Translation item) {
    context.read(typeProvider).state = item.type == 1;
    context.read(amoungProvider).state = item.amoung.toString();
    context.read(idProvider).state = item.id;
    context.read(activeProvider).state = item.active == 1;
    context.read(createAtProvider).state = item.createAt;
    context.read(updateAtProvider).state = item.updateAt;
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
