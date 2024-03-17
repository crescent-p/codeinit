part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class CreateBlogEvent extends BlogEvent {
  final String title;
  final String content;
  final File image;
  final String user_id;
  final String year;

  CreateBlogEvent({
    required this.title,
    required this.content,
    required this.image,
    required this.user_id,
    required this.year,
  });
}

class GetAllBlogEvent extends BlogEvent {
  GetAllBlogEvent();
}

class GetPersonalBlogsEvent extends BlogEvent {
  final String name;
  GetPersonalBlogsEvent({required this.name});
}

class UploadYearBookEvent extends BlogEvent {
  final File file;
  UploadYearBookEvent({required this.file});
}

class GetAllYearBookModeEvent extends BlogEvent {
  GetAllYearBookModeEvent();
}