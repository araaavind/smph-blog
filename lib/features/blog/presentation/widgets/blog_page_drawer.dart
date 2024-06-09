import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/constants/constants.dart';
import 'package:semaphore/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:semaphore/features/blog/presentation/cubit/wall_cubit.dart';

class BlogPageDrawer extends StatelessWidget {
  const BlogPageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: BlocBuilder<WallCubit, WallState>(
        builder: (context, state) {
          return ListView(
            children: [
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(16),
                shape: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).dividerColor.withOpacity(0.8),
                  ),
                ),
                collapsedShape: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).dividerColor.withOpacity(0.8),
                  ),
                ),
                initiallyExpanded: true,
                title: const Text(
                  'Your walls',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  ListTile(
                    selected: state is WallInitial,
                    visualDensity: VisualDensity.compact,
                    title: const Text('All stories'),
                    onTap: () {
                      context.read<WallCubit>().resetWall();
                      context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
                      Navigator.pop(context);
                    },
                  ),
                  ...Constants.topics.map(
                    (e) => ListTile(
                      selected: state is WallChanged && state.wall == e,
                      visualDensity: VisualDensity.compact,
                      title: Text(e),
                      onTap: () {
                        context.read<WallCubit>().loadWall(e);
                        context.read<BlogBloc>().add(
                              BlogGetAllBlogsEvent(
                                topic: e,
                              ),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(16),
                shape: Border.all(
                  width: 0,
                ),
                initiallyExpanded: true,
                title: const Text(
                  'All feeds',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: const Text('Hackernews'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: const Text('Reddit'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: const Text('Zerodha Tech'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: const Text('Kent C. Dodds'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
