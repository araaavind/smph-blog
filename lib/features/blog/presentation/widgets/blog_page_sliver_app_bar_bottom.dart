import 'package:flutter/material.dart';

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
      title: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.menu,
                size: 22,
                weight: 1,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'All stories',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
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
