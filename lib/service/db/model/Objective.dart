class Objective {
  int id;
  // int accountId = 0;
  String title;
  DateTime createAt;
  DateTime updateAt;

  Objective({
    this.id,
    this.title = '',
    this.createAt,
    this.updateAt,
  }) {
    // if (createAt == null) createAt = DateTime.now();
    // if (updateAt == null) updateAt = DateTime.now();
  }

  Objective.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    // accountId = map['account_id'];
    title = map['title'];
    createAt = map['create_at'];
    updateAt = map['update_at'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'account_id': accountId,
      'title': title,
      'create_at': createAt,
      'update_at': updateAt,
    };
  }

  @override
  String toString() {
    return '''Objective{
      id: $id, ''' +
        // account_id: $accountId,
        '''
      title: $title, 
      create_at: $createAt, 
      update_at: $updateAt}''';
  }
}
