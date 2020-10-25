import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:hooks_riverpod/all.dart';
import 'amoungInput.dart';
import 'submitButton.dart';
import 'switchTypePayment.dart';

class AddTranslation extends StatelessWidget {
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
                SizedBox(height: 30),
                AmoungInput(),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 50),
          SubmitButton(),
        ],
      ),
    );
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
