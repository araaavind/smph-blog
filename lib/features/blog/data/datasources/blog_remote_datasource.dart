import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:semaphore/core/constants/supabase_constants.dart';
import 'package:semaphore/core/error/exceptions.dart';
import 'package:semaphore/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from(SupabaseConstants.blogsTableName)
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (_) {
      throw const ServerException(
          'Something went wrong. We\'re checking the issue.');
    } on AuthException catch (_) {
      throw const ServerException('You are note authorized to upload blogs');
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      throw const ServerException(
          'Something went wrong. We\'re checking the issue.');
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from(SupabaseConstants.blogImagesStorageBucketName)
          .upload(
            blog.id,
            image,
          );

      return supabaseClient.storage
          .from(SupabaseConstants.blogImagesStorageBucketName)
          .getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      throw const ServerException(
          'Something went wrong. We\'re checking the issue.');
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from(SupabaseConstants.blogsTableName)
          .select('*, ${SupabaseConstants.profilesTableName}(name)')
          .order('updated_at', ascending: false);
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              userName: blog[SupabaseConstants.profilesTableName]['name'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
      throw const ServerException(
          'Something went wrong. We\'re checking the issue.');
    }
  }
}
