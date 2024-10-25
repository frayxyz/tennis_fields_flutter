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

  // Método para convertir un Map a un User
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

  // Método para convertir un User a un Map
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
