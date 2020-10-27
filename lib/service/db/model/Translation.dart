import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tractor/service/db/db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Translation {
  int id;
  // int accountId = 0;
  // int objectiveId = 0;

  int amoung = 0;
  bool type = false;
  bool active = true;

  DateTime createAt;
  DateTime updateAt;

  Translation({
    this.id,
    // this.accountId = 0,
    // this.objectiveId = 0,
    this.amoung = 0,
    this.type = false,
    this.active = true,
    this.createAt,
    this.updateAt,
  });

  String get formatedAmoung => NumberFormat("###,###", "en_US").format(amoung);

  Translation.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    // accountId = map['account_id'];
    // objectiveId = map['objective_id'];

    amoung = map['amoung'];
    type = map['type'] == 1;
    active = map['active'] == 1;

    createAt = map['create_at'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['create_at'] as int);
    updateAt = map['update_at'] == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['update_at'] as int);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'account_id': accountId,
      // 'objective_id': objectiveId,
      'amoung': amoung,
      'type': type ? 1 : 0,
      'active': active ? 1 : 0,
      'create_at': createAt.millisecondsSinceEpoch,
      'update_at': updateAt.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return '''Translation{
      id: $id,'''
        // account_id: $accountId,
        // objective_id: $objectiveId,
        ''' 
      amoung: $amoung, 
      type: $type, 
      active: $active, 
      create_at: $createAt, 
      update_at: $updateAt}''';
  }

  Future<int> delete(BuildContext context) {
    return context.read(dbProvider).translation.delete(id);
  }
}
