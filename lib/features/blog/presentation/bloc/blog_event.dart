part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class CreateBlogEvent extends BlogEvent {
  final String title;
  final String content;
  final File image;
  final String postId;
  final List<String> topics;

  CreateBlogEvent({
    required this.title,
    required this.content,
    required this.image,
    required this.postId,
    required this.topics,
  });
}

class GetAllBlogEvent extends BlogEvent {
  GetAllBlogEvent();
}
class GetPersonalBlogsEvent extends BlogEvent {
  final String name;
  GetPersonalBlogsEvent({required this.name});
}