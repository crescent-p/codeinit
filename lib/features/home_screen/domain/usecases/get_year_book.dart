import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/home_screen/domain/entities/yearbook.dart';
import 'package:codeinit/features/home_screen/domain/repository/year_book_reposirory.dart';
import 'package:fpdart/fpdart.dart';

class GetYearBookUseCase implements UseCase<List<YearBook>, NoParams> {
  final YearBookRepository repository;

  GetYearBookUseCase({required this.repository});

  @override
  Future<Either<Failure, List<YearBook>>> call(NoParams params) async {
    try {
      return repository.getYearBook();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
