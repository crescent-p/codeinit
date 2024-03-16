import 'dart:io';
import 'package:codeinit/core/error/exceptions.dart';
import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/blog/data/models/blog_model.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<Either<Failure, List<BlogModel>>> getBlogs();
  Future<String> uploadImage({required File file, required Blog blog});
  Future<Either<Failure, Blog>> createBlog({required BlogModel blog});
  Future<Either<Failure, List<BlogModel>>> getPersonalBlogs(
      {required String name});
}

class BlogRemoteDataSourceImple implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImple({required this.client});

  @override
  Future<Either<Failure, Blog>> createBlog({required BlogModel blog}) async {
    try {
      final json = blog.toJson();
      final blogData = await client.from('blogs').insert(json).select();
      return Right(BlogModel.fromJson(blogData.first));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<String> uploadImage({required File file, required Blog blog}) async {
    try {
      await client.storage.from('blog_images').upload(blog.id, file);
      return client.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw UploadImageFailed;
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> getBlogs() async {
    try {
      //take blogs table and combine with name from profiles table
      final query = await client.from('blogs').select("*, profiles(name)");
      return Right(query
          .map((e) =>
              BlogModel.fromJson(e).copyWith(posterName: e["profiles"]["name"]))
          .toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> getPersonalBlogs(
      {required String name}) async {
    try {
      final userId = await client.from('profiles').select().eq('name', name);
      if (userId.isEmpty) return Left(Failure(message: "User not found"));
      final res =
          await client.from('blogs').select().eq('post_id', userId.first['id']);
      return Right(res.map((e) => BlogModel.fromJson(e)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
