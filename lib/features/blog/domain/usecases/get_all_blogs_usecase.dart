import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<Blog>, NoParams>{
  final BlogRepository repository;

  GetAllBlogsUseCase({required this.repository});
  
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    try {
      return await repository.getBlogs();
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

}