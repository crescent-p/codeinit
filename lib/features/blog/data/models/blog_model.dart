import 'package:codeinit/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.postId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.createdAt,
    required super.topics,
    super.posterName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      postId: json['post_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['updated_at']),
      topics: List<String>.from(json['topics'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'post_id': postId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'updated_at': createdAt.toIso8601String(),
      'topics': topics,
    };
  }

  BlogModel copyWith({
    String? id,
    String? postId,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      topics: topics ?? this.topics,
      posterName: posterName ?? this.posterName,
    );
  }
}
