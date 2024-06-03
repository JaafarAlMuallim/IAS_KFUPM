class User {
  String userId;
  String name;
  String email;
  DateTime birthDate;
  String contactNumber;
  String role;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.contactNumber,
    required this.role,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      birthDate: DateTime.parse(json['birth_date']),
      contactNumber: json['contact_number'],
      role: json['role'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'birth_date': birthDate.toIso8601String(),
      'contact_number': contactNumber,
      'role': role,
    };
  }
}
