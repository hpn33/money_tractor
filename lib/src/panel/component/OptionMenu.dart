import 'package:flutter/material.dart';
import 'package:money_tractor/service/db/model/Translation.dart';
import 'package:money_tractor/src/widget/translationDetail.dart';
import 'package:money_tractor/src/widget/translationMenu/TranslationMenu.dart';

import '../panel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionMenu extends StatelessWidget {
  final Translation translation;
  OptionMenu(this.translation);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            item(
              icon: Icons.more_horiz,
              text: 'Detail',
              press: () {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (c) => TranslationDetailDialog(translation),
                );
              },
            ),
            Divider(),
            item(
              icon: Icons.edit,
              text: 'Edit',
              press: () {
                TranslationMenu.setItem(context, translation);

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (c) => TranslationMenu(),
                ).then((value) => context.refresh(Panel.listProvider));
              },
            ),
            Divider(),
            item(
              icon: Icons.delete,
              text: 'Delete',
              press: () async {
                await translation.delete(context);
                context.refresh(Panel.listProvider);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget item({IconData icon, String text, void Function() press}) => InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      );
}
