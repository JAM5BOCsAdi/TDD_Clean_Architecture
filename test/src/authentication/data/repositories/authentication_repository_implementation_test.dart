import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_clean_architecture/core/errors/failure.dart';
import 'package:tdd_clean_architecture/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:tdd_clean_architecture/src/authentication/data/repositories/authentication_repository_implementation.dart';

class MockAuthRemoteDataSource extends Mock implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(
    () {
      remoteDataSource = MockAuthRemoteDataSource();
      repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
    },
  );

  const tException = ApiException(message: 'Unknown Error Occurred', statusCode: 500);

  group(
    'createUser',
    () {
      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      test(
        'It Should call the [RemoteDataSource.createUser] and complete successfully when the call to the remote source is successful',
        () async {
          // Arrange:
          when(
            () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenAnswer((_) async => Future.value());

          // Act:
          final result = await repoImpl.createUser(createdAt: createdAt, name: name, avatar: avatar);

          // Assert:
          expect(result, equals(const Right(null)));
          verify(() => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );

      test(
        'It should return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
          // Arrange:
          when(
            () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenThrow(tException);

          // Act:
          final result = await repoImpl.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          );

          expect(
            result,
            equals(
              Left(
                ApiFailure(
                  message: tException.message,
                  statusCode: tException.statusCode,
                ),
              ),
            ),
          );

          verify(() => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
