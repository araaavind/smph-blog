import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';
import 'package:semaphore/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String userId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.userId,
    required this.image,
    required this.topics,
  });
}
