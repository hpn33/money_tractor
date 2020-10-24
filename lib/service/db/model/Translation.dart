class Translation {
  int id;
  // int accountId = 0;
  int objectiveId = 0;

  int amoung = 0;
  int type = 0;
  int active = 0;

  DateTime createAt;
  DateTime updateAt;

  Translation({
    this.id,
    // this.accountId = 0,
    this.objectiveId = 0,
    this.amoung = 0,
    this.type = 0,
    this.active = 0,
    this.createAt,
    this.updateAt,
  }) {
    // if (createAt == null) createAt = DateTime.now();
    // if (updateAt == null) updateAt = DateTime.now();
  }

  Translation.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    // accountId = map['account_id'];
    objectiveId = map['objective_id'];

    amoung = map['amoung'];
    type = map['type'];
    active = map['active'];

    createAt = map['create_at'];
    updateAt = map['update_at'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'account_id': accountId,
      'objective_id': objectiveId,
      'amoung': amoung,
      'type': type,
      'active': active,
      'create_at': createAt,
      'update_at': updateAt,
    };
  }

  @override
  String toString() {
    return '''Translation{
      id: $id,'''
        // account_id: $accountId,
        ''' 
      objective_id: $objectiveId, 
      amoung: $amoung, 
      type: $type, 
      active: $active, 
      create_at: $createAt, 
      update_at: $updateAt}''';
  }
}
