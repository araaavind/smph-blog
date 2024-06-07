import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';
import 'package:semaphore/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
