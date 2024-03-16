// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'package:codeinit/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.image_url,
    required super.phone_number,
    required super.website,
    required super.designation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image_url: json['image_url'],
      phone_number: json['phone_number'],
      website: json['website'],
      designation: json['designation'],
    );
  }
  UserModel copyWith({String? id, String? name, String? email, String? image_url, String? phone_number, String? website, String? designation}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image_url: image_url ?? this.image_url,
      phone_number: phone_number ?? this.phone_number,
      website: website ?? this.website,
      designation: designation ?? this.designation,      
    );
  }
}
