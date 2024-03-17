import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadYearBookUseCase implements UseCase<String, File> {
  final BlogRepository repository;

  UploadYearBookUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(File file) async {
    try {
      return Right(await repository.uploadYearBook(file: file));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
