import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:semaphore/core/common/widgets/loader.dart';
import 'package:semaphore/core/theme/app_palette.dart';
import 'package:semaphore/core/utils/show_snackbar.dart';
import 'package:semaphore/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:semaphore/features/blog/presentation/pages/blog_page.dart';

class ProfilePage extends StatelessWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackbar(context, state.message);
              } else if (state is AuthInitial) {
                Navigator.pushAndRemoveUntil(
                  context,
                  BlogPage.route(),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return state is AuthLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: SizedBox(
                        height: 14,
                        width: 14,
                        child: Loader(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutEvent());
                      },
                      icon: const Icon(Icons.logout),
                    );
            },
          ),
        ],
      ),
      body: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserInitial) {
            return const Loader();
          }
          final user = (state as AppUserLoggedIn).user;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? '',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppPalette.greyColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
