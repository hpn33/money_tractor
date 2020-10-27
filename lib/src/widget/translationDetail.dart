import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tractor/service/db/model/Translation.dart';

class TranslationDetailDialog extends StatelessWidget {
  final Translation item;

  final bool isIncome;
  final bool isActive;

  TranslationDetailDialog(this.item)
      : isIncome = item.type == 1,
        isActive = item.active == 1;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? isIncome
            ? Colors.green
            : Colors.red
        : Colors.grey;

    return Dialog(
      backgroundColor: color[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                typeInfo(color),
                Divider(),
                amoungInfo(color),
                Divider(),
                dateInfo(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              height: 3,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Padding dateInfo() {
    final createFormated =
        DateFormat('yyyy-MM-dd   kk:mm').format(item.createAt);

    final updateFormated =
        DateFormat('yyyy-MM-dd   kk:mm').format(item.updateAt);

    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
        left: 8,
        top: 28,
        bottom: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('create'),
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
              Text('edit'),
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

  Padding amoungInfo(MaterialColor color) {
    final sign = isIncome ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'amoung',
            style: TextStyle(
              color: color,
            ),
          ),
          Text(
            '$sign ${item.formatedAmoung}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Row typeInfo(MaterialColor color) {
    final typeText = isIncome ? 'Add' : 'Sub';

    return Row(
      children: [
        Text(
          typeText,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          isActive ? 'Active' : 'DeActive',
          style: TextStyle(
            // fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
