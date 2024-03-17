import 'package:codeinit/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.user_id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.createdAt,
    required super.year,
    super.posterName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'].toString(),
      user_id: json['user_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['created_at']),
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': user_id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'year': year,
    };
  }

  BlogModel copyWith({
    String? id,
    String? user_id,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    String? year,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      year: year ?? this.year,
      posterName: posterName ?? this.posterName,
    );
  }
}
