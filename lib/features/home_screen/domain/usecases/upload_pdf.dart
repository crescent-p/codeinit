import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:codeinit/features/home_screen/domain/repository/year_book_reposirory.dart';
import 'package:fpdart/fpdart.dart';


class UploadPdfUseCase implements UseCase<String, UploadPdfParams> {
  final YearBookRepository repository;

  UploadPdfUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UploadPdfParams params) async {
    try {
      return repository.uploadYearBook(
          yearBookModel: params.title, file: params.file);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

class UploadPdfParams {
  final YearBookModel title;
  final File file;

  UploadPdfParams({required this.title, required this.file});
}
