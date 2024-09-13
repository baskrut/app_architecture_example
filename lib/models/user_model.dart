class UserModel {
  String name;
  int id;

  UserModel({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, id: $id)';
  }
}
