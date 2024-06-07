import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/widgets/loader.dart';
import 'package:semaphore/core/theme/app_palette.dart';
import 'package:semaphore/core/utils/show_snackbar.dart';
import 'package:semaphore/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:semaphore/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:semaphore/features/blog/presentation/widgets/blog_card.dart';
import 'package:semaphore/features/profile/presentation/pages/profile_page.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogGetAllSuccess) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 60,
                  title: const Text(
                    'Semaphore',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, AddBlogNewPage.route());
                      },
                      icon: const Icon(CupertinoIcons.add_circled),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, ProfilePage.route());
                      },
                      icon: const Icon(CupertinoIcons.profile_circled),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     context.read<AuthBloc>().add(AuthLogoutEvent());
                    //   },
                    //   icon: const Icon(CupertinoIcons.arrow_right_circle),
                    // )
                  ],
                  floating: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return BlogCard(
                        blog: state.blogs[index],
                        color: AppPalette.blogCardColor,
                      );
                    },
                    childCount: state.blogs.length,
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
