import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/features/blog/presentation/cubit/wall_cubit.dart';

class BlogPageSliverAppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  const BlogPageSliverAppBarBottom({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      title: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.menu,
                size: 20,
                weight: 1,
              ),
            ),
            const SizedBox(width: 8),
            BlocBuilder<WallCubit, WallState>(
              builder: (context, state) {
                return Text(
                  state is WallInitial
                      ? 'All Stories'
                      : (state as WallChanged).wall,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          iconSize: 22,
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          iconSize: 22,
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
      ],
      shape: Border(
        top: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.8),
          width: 0.1,
        ),
        bottom: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.8),
          width: 0.1,
        ),
      ),
    );
  }
}
