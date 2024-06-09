import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:semaphore/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:semaphore/core/common/cubits/network/network_cubit.dart';
import 'package:semaphore/core/theme/theme.dart';
import 'package:semaphore/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:semaphore/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:semaphore/features/blog/presentation/cubit/wall_cubit.dart';
import 'package:semaphore/features/blog/presentation/pages/blog_page.dart';
import 'package:semaphore/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:semaphore/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<NetworkCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<WallCubit>(),
      ),
    ],
    child: const SemaphoreApp(),
  ));
}

class SemaphoreApp extends StatefulWidget {
  const SemaphoreApp({super.key});

  @override
  State<SemaphoreApp> createState() => _SemaphoreAppState();
}

class _SemaphoreAppState extends State<SemaphoreApp> {
  late StreamSubscription<InternetStatus> connectionListener;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetCurrentUserProfileEvent());
    connectionListener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      context
          .read<NetworkCubit>()
          .updateNetworkStatus(status == InternetStatus.connected);
    });
  }

  @override
  void dispose() {
    connectionListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semaphore',
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      home: const BlogPage(),
    );
  }
}
