import 'dart:io';
import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateBlogUseCase implements UseCase<Blog, Params> {
  final BlogRepository repository;

  CreateBlogUseCase({required this.repository});

  @override
  Future<Either<Failure, Blog>> call(Params params) async {
    try {
     return await repository.createBlog(
        title: params.title,
        content: params.content,
        image: params.image,
        postId: params.postId,
        topics: params.topics,
      );
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class Params {
  final String title;
  final String content;
  final File image;
  final String postId;
  final List<String> topics;

  Params({
    required this.title,
    required this.content,
    required this.image,
    required this.postId,
    required this.topics,
  });
}
