import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semaphore/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:semaphore/core/theme/theme.dart';
import 'package:semaphore/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:semaphore/features/blog/presentation/bloc/blog_bloc.dart';
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
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProfileBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
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
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetCurrentUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semaphore',
      theme: AppTheme.darkThemeMode,
      home: const BlogPage(),
    );
  }
}
