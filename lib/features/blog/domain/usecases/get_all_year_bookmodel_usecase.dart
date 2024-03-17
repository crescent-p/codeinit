import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:fpdart/fpdart.dart';

class GetAllYearBookModelUseCase {
  final BlogRepository repository;

  GetAllYearBookModelUseCase({required this.repository});

  Future<Either<Failure, List<YearBookModel>>> call() async {
    try {
      return Right(await repository.getAllYearBookRemote());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
