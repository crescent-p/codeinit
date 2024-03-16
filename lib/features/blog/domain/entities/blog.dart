class Blog {
  final String id;
  final String postId;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final List<String> topics;
  final String? posterName;

  Blog({
    required this.id,
    required this.postId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.topics,
    this.posterName,
  });
}
