class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String university;
  final String gender;
  final String image;
  final String token;
  final String color;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.university,
    required this.gender,
    required this.image,
    required this.token,
    required this.color,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'] ?? 'first name',
      lastName: json['lastName'] ?? 'last name',
      gender: json['gender'] ?? 'male',
      image: json['image'] ?? 'image',
      token: json['token'] ?? 'token',
      university: json['university'],
      color: json['hair']['color'],
    );
  }
}
