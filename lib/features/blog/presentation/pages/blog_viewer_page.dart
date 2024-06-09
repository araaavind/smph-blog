import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/network/network_cubit.dart';
import 'package:semaphore/core/constants/constants.dart';
import 'package:semaphore/core/utils/calculate_reading_time.dart';
import 'package:semaphore/core/utils/format_date.dart';
import 'package:semaphore/core/utils/show_snackbar.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewerPage(
            blog: blog,
          ));

  final Blog blog;
  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkDisconnected) {
            showSnackbar(context, Constants.networkDisconnectedMessage);
          } else if (state is NetworkConnected) {
            showSnackbar(context, Constants.networkConnectedMessage);
          }
        },
        builder: (context, state) {
          final blogImageWidget = state is NetworkConnected
              ? Image.network(blog.imageUrl)
              : Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Images are not loaded when you are offline',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                );

          return Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      blog.title,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'By ${blog.userName}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${formatDate(blog.updatedAt, 'd MMM, yyyy')} . ${calculateReadingTime(blog.content)} min',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: blogImageWidget,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
