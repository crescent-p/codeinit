
import 'package:codeinit/core/error/failures.dart';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPersonalBlogsUseCase implements UseCase<List<Blog>, String>{
  final BlogRepository repository;

  GetPersonalBlogsUseCase({required this.repository});
  
  @override
  Future<Either<Failure, List<Blog>>> call(String name) async {
    try {
      return await repository.getPersonalBlogs(name: name);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

}