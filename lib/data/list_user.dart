import 'dart:ffi';

class ListUser {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String birthDate;
  final String image;
  final String bloodGroup;
  final int height;
  final double weight;
  final String eyeColor;
  final String hairColor;
  final String street;
  final String city;
  final String postalCode;
  final String state;
  final String university;

  ListUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.university,
  });

  factory ListUser.fromJson(Map<String, dynamic> json) {
    return ListUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      maidenName: json['maidenName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      birthDate: json['phone'],
      image: json['image'],
      bloodGroup: json['bloodGroup'],
      height: json['height'],
      weight: json['weight'],
      eyeColor: json['eyeColor'],
      hairColor: json['hair']['color'],
      street: json['address']['address'],
      city: json['address']['city'],
      postalCode: json['address']['postalCode'],
      state: json['address']['state'],
      university: json['university'],
    );
  }
}
