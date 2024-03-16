import 'package:codeinit/core/common/cubit/app_user_cubit.dart';
import 'package:codeinit/core/theme/theme.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:codeinit/features/auth/presentation/pages/signin.dart';
import 'package:codeinit/features/home_screen/presentation/bloc/main_page_bloc.dart';
import 'package:codeinit/features/home_screen/presentation/pages/home_screen.dart';
import 'package:codeinit/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //load all widgets before calling supabase
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
      BlocProvider(create: (_) => serviceLocator<MainPageBloc> ())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: AppTheme.darkThemeMode,
          home: state ? const HomeScreen() : const SignIn(),
        );
      },
    );
  }
}
