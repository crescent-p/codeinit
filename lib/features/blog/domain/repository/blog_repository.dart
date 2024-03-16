import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> createBlog({
    required String title,
    required String content,
    required File image,
    required String postId,
    required List<String> topics,
  });
  Future<Either<Failure, List<Blog>>> getBlogs();
  Future<Either<Failure, List<Blog>>> getPersonalBlogs({required String name});
}
