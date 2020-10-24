// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/all.dart';
// import 'package:money_tractor/service/db/db_helper.dart';
// import 'package:money_tractor/service/db/model/Account.dart';

// final accountListProvider = StateProvider((ref) => <Account>[]);

// class AccountPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, watch) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             RaisedButton(
//               child: Text('create'),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return Dialog(
//                       child: AddAccoungDialog(),
//                     );
//                   },
//                 );
//               },
//             ),
//             ListView(
//               children: [
//                 for (var item in watch(accountListProvider).state)
//                   Text(item.toString()),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddAccoungDialog extends ConsumerWidget {
//   final titleController = TextEditingController();

//   @override
//   Widget build(BuildContext context, watch) {
//     final db = watch(dbProvider);

//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text('add Account'),
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'title'),
//             ),
//             RaisedButton(
//               child: Text('sumbit'),
//               onPressed: () async {
//                 final result = await db.account
//                     .insert(Account(title: titleController.text));
//                 if (result != 0)
//                   context.read(accountListProvider).state =
//                       await db.account.all();

//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
