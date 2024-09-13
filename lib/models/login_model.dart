class LoginModel {
  String name;
  String email;
  String phone;

  LoginModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  @override
  String toString() {
    return 'LoginModel(name: $name, email: $email, phone: $phone)';
  }
}