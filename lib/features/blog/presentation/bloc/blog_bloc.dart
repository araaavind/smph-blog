import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/usecase/usecase.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';
import 'package:semaphore/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:semaphore/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUploadEvent>(_onBlogUpload);

    on<BlogGetAllBlogsEvent>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
      title: event.title,
      content: event.content,
      userId: event.userId,
      image: event.image,
      topics: event.topics,
    ));

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(
    BlogGetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogGetAllSuccess(blogs)),
    );
  }
}
