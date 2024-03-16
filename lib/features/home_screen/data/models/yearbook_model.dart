
import 'package:codeinit/features/home_screen/domain/entities/yearbook.dart';

class YearBookModel extends YearBook{
  YearBookModel({required super.link, required super.name, required super.id, required super.user_id});

  factory YearBookModel.fromJson(Map<String, dynamic> json) {
    return YearBookModel(
      link: json['link'],
      name: json['name'],
      id: json['id'],
      user_id: json['user_id'],
    );
  }
  YearBookModel copyWith( {String? link, String? name, String? id, String? user_id}) {
    return YearBookModel(
      user_id: user_id ?? this.user_id,
      link: link ?? this.link,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
   toJson() {
    return <String, dynamic>{
      'link': link,
      'name': name,
      'id': id,
      'user_id': user_id,
    };
  }
}