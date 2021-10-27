import 'package:flutter/material.dart';
import 'package:money_tractor/page/widget/translation_detail.dart';
import 'package:money_tractor/page/widget/translationMenu/translation_menu.dart';
import 'package:money_tractor/service/db/model/translation.dart';

import '../panel.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionMenu extends StatelessWidget {
  final Translation translation;

  const OptionMenu(this.translation, {Key? key}) : super(key: key);

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
            const Divider(),
            item(
              icon: Icons.edit,
              text: 'Edit',
              press: () {
                TranslationMenu.setItem(context, translation);

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (c) => const TranslationMenu(),
                ).then((value) => context.refresh(Panel.listProvider));
              },
            ),
            const Divider(),
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

  Widget item({
    required IconData icon,
    required String text,
    void Function()? press,
  }) =>
      InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      );
}
