import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class HomeRemoteDataSource {
  Future<Either<Failure, List<YearBookModel>>> getYearBooks();
  Future<Either<Failure, String>> uploadYearBook(
      YearBookModel yearBooks, File file);
  Future<Either<Failure, String>> uploadPdf(String uniqueid, File file);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient supabaseClient;

  HomeRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<Either<Failure, String>> uploadPdf(String uniqueid, File file) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(uniqueid, file);
      return Right(
          supabaseClient.storage.from('blog_images').getPublicUrl(uniqueid));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<YearBookModel>>> getYearBooks() async {
    try {
      final query = await supabaseClient.from('yearbooktable').select('*');
      return Right(query.map((e) => YearBookModel.fromJson(e)).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadYearBook(
      YearBookModel yearBooks, File file) async {
    try {
      final link = await uploadPdf(const Uuid().v1().toString(), file);
      if (link.isLeft()) {
        return link;
      } else {
        //is link.getRight().toString() the correct way to get the value from the Either?
        yearBooks = yearBooks.copyWith(
            user_id: supabaseClient.auth.currentUser?.id.toString(),
            id: const Uuid().v1().toString(),
            link: link.getOrElse((_) => "").toString());

        final json = yearBooks.toJson();
        await supabaseClient.from('yearbooktable').insert(json).select();
        return const Right("Success");
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
