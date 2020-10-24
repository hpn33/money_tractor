class Account {
  int id = 0;
  String title = '';
  DateTime createAt;
  DateTime updateAt;

  Account({
    this.id = 0,
    this.title = '',
    this.createAt,
    this.updateAt,
  }) {
    if (createAt == null) createAt = DateTime.now();
    if (updateAt == null) updateAt = DateTime.now();
  }

  Account.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    createAt = map['create_at'];
    updateAt = map['update_at'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'create_at': createAt,
      'update_at': updateAt,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, title: $title, create_at: $createAt, update_at: $updateAt}';
  }
}
