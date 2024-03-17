class Blog {
  final String id;
  final String user_id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final String year;
  final String? posterName;

  Blog({
    required this.id,
    required this.user_id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.year,
    this.posterName,
  });
}
