import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/widgets/loader.dart';
import 'package:semaphore/core/utils/show_snackbar.dart';
import 'package:semaphore/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:semaphore/features/blog/presentation/widgets/blog_card.dart';
import 'package:semaphore/features/blog/presentation/widgets/blog_page_drawer.dart';
import 'package:semaphore/features/blog/presentation/widgets/blog_page_sliver_app_bar.dart';

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
                const BlogPageSliverAppBar(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return BlogCard(
                        blog: state.blogs[index],
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
      drawer: const BlogPageDrawer(),
    );
  }
}
