class User {
  User({
    required this.name,
    required this.password,
    required this.email,
  });

  final String name;
  final String password;
  final String email;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.name == name && other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ password.hashCode;
}
