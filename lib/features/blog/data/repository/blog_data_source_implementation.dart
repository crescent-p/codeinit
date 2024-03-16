import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/network/connection_checker.dart';
import 'package:codeinit/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:codeinit/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:codeinit/features/blog/data/models/blog_model.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImple implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final Network network;

  BlogRepositoryImple(
      {required this.blogLocalDataSource,
      required this.network,
      required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> createBlog(
      {required String title,
      required String content,
      required File image,
      required String postId,
      required List<String> topics}) async {
    try {
      BlogModel blog = BlogModel(
        id: const Uuid().v1(),
        postId: postId,
        title: title,
        content: content,
        imageUrl: "imageUrl",
        createdAt: DateTime.now(),
        topics: topics,
      );
      String url =
          await blogRemoteDataSource.uploadImage(file: image, blog: blog);
      return blogRemoteDataSource.createBlog(
          blog: blog.copyWith(imageUrl: url));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getBlogs() async {
    try {
      if (await network.isConnected) {
        Either<Failure, List<BlogModel>> download =
            await blogRemoteDataSource.getBlogs();
        download.fold(
          (failure) => Left(failure),
          (blogs) => blogLocalDataSource.updateAllBlogs(blogs),
        );
        return download;
      } else {
        return Right(blogLocalDataSource.getAllBlogs());
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getPersonalBlogs({required String name})async {
    try {
      return await blogRemoteDataSource.getPersonalBlogs(name: name);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
