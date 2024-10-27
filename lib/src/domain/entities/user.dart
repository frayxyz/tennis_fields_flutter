class User {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? signupDate;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.signupDate,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      signupDate: map['signup_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'signup_date': signupDate,
    };
  }
}
