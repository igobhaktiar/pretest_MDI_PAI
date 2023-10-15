class UserList {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String? hair;
  final String? university;
  final int? height;
  final String? phone;
  final String? birthDate;
  final String? bloodGroup;
  final dynamic weight;

  UserList({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    this.hair,
    this.university,
    this.height,
    this.weight,
    this.phone,
    this.birthDate,
    this.bloodGroup,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      hair: json['hair']['color'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      university: json['university'],
      height: json['height'],
      weight: json['weight'],
      phone: json['phone'],
      birthDate: json['birthDate'],
      bloodGroup: json['bloodGroup'],
    );
  }
}
