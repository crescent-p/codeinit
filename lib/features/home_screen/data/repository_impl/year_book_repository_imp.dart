import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/home_screen/data/data_sources/remote_data_source.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:codeinit/features/home_screen/domain/repository/year_book_reposirory.dart';
import 'package:fpdart/fpdart.dart';

class YearBookRepositoryImp implements YearBookRepository {
  final HomeRemoteDataSource remoteDataSource;

  YearBookRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<YearBookModel>>> getYearBook()async {
    try {
      return await remoteDataSource.getYearBooks();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadYearBook(
      {required YearBookModel yearBookModel, required File file}) async {
    try {
      return await remoteDataSource.uploadYearBook(yearBookModel, file);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
