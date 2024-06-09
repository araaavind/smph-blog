import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/network/network_cubit.dart';
import 'package:semaphore/core/theme/app_palette.dart';
import 'package:semaphore/core/utils/calculate_reading_time.dart';
import 'package:semaphore/features/blog/domain/entities/blog.dart';
import 'package:semaphore/features/blog/presentation/pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({
    super.key,
    required this.blog,
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
            return OnlineCard(
              blog: blog,
              color: Theme.of(context).cardColor,
            );
          }
          return OfflineCard(
            blog: blog,
            color: Theme.of(context).cardColor,
          );
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
            border: Border.all(),
            gradient: LinearGradient(
              colors: [
                Theme.of(context)
                    .extension<CardOverlayGradientColors>()!
                    .overlayGradientOne!,
                Theme.of(context)
                    .extension<CardOverlayGradientColors>()!
                    .overlayGradientTwo!,
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
                                padding: const EdgeInsets.all(4),
                                label: Text(
                                  e,
                                  style: const TextStyle(
                                    fontSize: 12,
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
                  AutoSizeText(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                    minFontSize: 18,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
                            padding: const EdgeInsets.all(4),
                            label: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 12,
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
              AutoSizeText(
                blog.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
                minFontSize: 18,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
