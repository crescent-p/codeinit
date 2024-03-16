import 'package:codeinit/core/common/cubit/app_user_cubit.dart';
import 'package:codeinit/core/network/connection_checker.dart';
import 'package:codeinit/core/secrets/supabase_secrets.dart';
import 'package:codeinit/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:codeinit/features/auth/data/repository/auth_repository_impl.dart';
import 'package:codeinit/features/auth/domain/repository/auth_repository.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_sign_out.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:codeinit/features/auth/domain/usecases/auth_current_user.dart';
import 'package:codeinit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:codeinit/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:codeinit/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:codeinit/features/blog/data/repository/blog_data_source_implementation.dart';
import 'package:codeinit/features/blog/domain/repository/blog_repository.dart';
import 'package:codeinit/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:codeinit/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:codeinit/features/blog/domain/usecases/get_personal_blogs_usecase.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/home_screen/data/data_sources/remote_data_source.dart';
import 'package:codeinit/features/home_screen/data/repository_impl/year_book_repository_imp.dart';
import 'package:codeinit/features/home_screen/domain/repository/year_book_reposirory.dart';
import 'package:codeinit/features/home_screen/domain/usecases/get_year_book.dart';
import 'package:codeinit/features/home_screen/domain/usecases/upload_pdf.dart';
import 'package:codeinit/features/home_screen/presentation/bloc/main_page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();
  _initBlog();
  _initMainPage();
  final supabase = await Supabase.initialize(
      anonKey: supabaseAnon, url: supabaseDatabaseUrl);

  serviceLocator.registerLazySingleton(() => supabase.client);
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  //network
  serviceLocator.registerLazySingleton(() => InternetConnection());

  serviceLocator.registerFactory<Network>(
      () => NetworkImpl(connectionChecker: serviceLocator()));

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
}

void _initMainPage() {
  serviceLocator.registerLazySingleton(() => MainPageBloc(
      uploadPdfUseCase: serviceLocator(),
      getYearBookUseCase: serviceLocator()));

  serviceLocator
      .registerFactory(() => GetYearBookUseCase(repository: serviceLocator()));
  serviceLocator
      .registerFactory(() => UploadPdfUseCase(repository: serviceLocator()));
  serviceLocator.registerFactory<YearBookRepository>(
      () => YearBookRepositoryImp(remoteDataSource: serviceLocator()));
  serviceLocator.registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(supabaseClient: serviceLocator()));
}

void _initAuth() {
  //for each call create new instance of the class
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImple(
            supabaseClient: serviceLocator(),
          ));
  serviceLocator.registerFactory(
    () => AuthSignOutUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        network: serviceLocator(),
        authRemoteDataSource: serviceLocator(),
      ));
  serviceLocator.registerFactory(() => AuthSignUpUseCase(
        repository: serviceLocator(),
      ));
  serviceLocator.registerFactory(() => AuthSignInUseCase(
        repository: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => AuthCurrentUserUseCase(
        repository: serviceLocator(),
      ));

  //only one instace is required
  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUpUseCase: serviceLocator(),
        userSignInUseCase: serviceLocator(),
        currentUserUseCase: serviceLocator(),
        appUserCubit: serviceLocator(),
        signOutUseCase: serviceLocator(),
      ));
}

void _initBlog() {
  //Blog
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );
  serviceLocator
      .registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImple(
            client: serviceLocator(),
          ));
  serviceLocator
      .registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(
            box: serviceLocator(),
          ));
  serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImple(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        network: serviceLocator(),
      ));
  serviceLocator.registerFactory(() => CreateBlogUseCase(
        repository: serviceLocator(),
      ));

  serviceLocator.registerFactory(() => GetAllBlogsUseCase(
        repository: serviceLocator(),
      ));
  serviceLocator.registerFactory(() => GetPersonalBlogsUseCase(
        repository: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => BlogBloc(
        createBlogUseCase: serviceLocator(),
        getAllBlogsUseCase: serviceLocator(),
        getPersonalBlogsUseCase: serviceLocator(),
      ));
}
