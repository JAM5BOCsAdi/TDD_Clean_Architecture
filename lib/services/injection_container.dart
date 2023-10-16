import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:tdd_clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_clean_architecture/src/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance; // Service Locator = sl

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )
    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImplementation(sl()))
    // Data sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(() => AuthRemoteDataSrcImpl(sl()))
    // External dependencies
    ..registerLazySingleton(http.Client.new);
}
