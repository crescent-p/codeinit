part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {
  final Blog blog;

  BlogUploadSuccess({required this.blog});
}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}

final class BlogLoadSuccess extends BlogState {
  final List<Blog> blogs;

  BlogLoadSuccess({required this.blogs});
}

final class BlogLoadPersonalSuccess extends BlogState {
  final List<Blog> blogs;

  BlogLoadPersonalSuccess({required this.blogs});
}