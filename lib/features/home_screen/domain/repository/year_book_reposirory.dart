import 'dart:io';

import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class YearBookRepository {
  Future<Either<Failure, List<YearBookModel>>> getYearBook();
  Future<Either<Failure, String>> uploadYearBook({
    required YearBookModel yearBookModel,
    required File file,
  });
}
