import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/entities/user.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // Test-Driven Development (TDD)
    // 1. Call the remote data source
    // 2. Check if the method returns the proper data
    // Make sure that it returns the proper data if there is an exception
    // // Check if when the remoteDataSource throws an exception, we return a
    // failure and if it does not throw an exception, we return the actual expected data
    await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
