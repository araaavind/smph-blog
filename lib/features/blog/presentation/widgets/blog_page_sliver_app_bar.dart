import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:semaphore/features/auth/presentation/pages/login_page.dart';
import 'package:semaphore/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:semaphore/features/blog/presentation/widgets/blog_page_sliver_app_bar_bottom.dart';
import 'package:semaphore/features/profile/presentation/pages/profile_page.dart';

class BlogPageSliverAppBar extends StatelessWidget {
  const BlogPageSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        return SliverAppBar(
          title: const Text(
            'Semaphore',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          floating: true,
          pinned: true,
          snap: false,
          stretch: true,
          bottom: const BlogPageSliverAppBarBottom(),
          automaticallyImplyLeading: false,
          actions: [
            state is AppUserLoggedIn
                ? IconButton(
                    onPressed: () {
                      Navigator.push(context, AddBlogNewPage.route());
                    },
                    icon: const Icon(CupertinoIcons.add_circled),
                  )
                : const SizedBox.shrink(),
            IconButton(
              onPressed: () {
                state is AppUserInitial
                    ? Navigator.push(context, LoginPage.route())
                    : Navigator.push(context, ProfilePage.route());
              },
              icon: const Icon(CupertinoIcons.profile_circled),
            ),
          ],
        );
      },
    );
  }
}
