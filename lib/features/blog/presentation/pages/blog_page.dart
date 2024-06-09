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
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          BlogPageSliverAppBar(),
          BlogPageSliverList(),
        ],
      ),
      drawer: BlogPageDrawer(),
    );
  }
}

class BlogPageSliverList extends StatelessWidget {
  const BlogPageSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailure) {
          showSnackbar(context, state.error);
        }
        if (state is BlogInitial || state is BlogUploadSuccess) {
          showSnackbar(context, 'Something went wrong. Please restart the app');
        }
      },
      builder: (context, state) {
        if (state is BlogLoading) {
          return const SliverFillRemaining(
            child: Loader(),
          );
        }
        if (state is BlogGetAllSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BlogCard(
                  blog: state.blogs[index],
                );
              },
              childCount: state.blogs.length,
            ),
          );
        }
        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
