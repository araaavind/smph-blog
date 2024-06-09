import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/constants/constants.dart';
import 'package:semaphore/core/error/exceptions.dart';
import 'package:semaphore/core/error/failures.dart';
import 'package:semaphore/core/network/connection_checker.dart';
import 'package:semaphore/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:semaphore/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:semaphore/features/blog/data/models/blog_model.dart';
import 'package:semaphore/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  final BlogLocalDatasource blogLocalDatasource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(
    this.blogRemoteDatasource,
    this.blogLocalDatasource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, BlogModel>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDatasource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDatasource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogModel>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = blogLocalDatasource.loadLocalBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDatasource.getAllBlogs();
      blogLocalDatasource.saveLocalBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
