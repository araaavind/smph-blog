import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/cubit/network_cubit.dart';
import 'package:semaphore/core/theme/app_palette.dart';
import 'package:semaphore/core/utils/calculate_reading_time.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';
import 'package:semaphore/features/blog/presentation/pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;

  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          if (state is NetworkConnected) {
            return OnlineCard(blog: blog, color: color);
          }
          return OfflineCard(blog: blog, color: color);
        },
      ),
    );
  }
}

class OnlineCard extends StatelessWidget {
  const OnlineCard({
    super.key,
    required this.blog,
    required this.color,
  });

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                blog.imageUrl,
              ),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0, 0.75],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Chip(
                                label: Text(
                                  e,
                                  style: const TextStyle(
                                    color: AppPalette.whiteColor,
                                  ),
                                ),
                                color: const WidgetStatePropertyAll(
                                  AppPalette.gradient2,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Text(
                    blog.title,
                    style: const TextStyle(
                      color: AppPalette.whiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text('${calculateReadingTime(blog.content)} min'),
            ],
          ),
        ),
      ],
    );
  }
}

class OfflineCard extends StatelessWidget {
  const OfflineCard({
    super.key,
    required this.blog,
    required this.color,
  });

  final Blog blog;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Chip(
                            label: Text(
                              e,
                              style: const TextStyle(
                                color: AppPalette.whiteColor,
                              ),
                            ),
                            color: const WidgetStatePropertyAll(
                              AppPalette.gradient2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(
                blog.title,
                style: const TextStyle(
                  color: AppPalette.whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
