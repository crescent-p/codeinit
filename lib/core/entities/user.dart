// ignore_for_file: non_constant_identifier_names

class User {
  final String id;
  final String name;
  final String email;
  final String image_url;
  final String phone_number;
  final String website;
  final String designation;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.image_url,
      required this.phone_number,
      required this.website,
      required this.designation});
}
