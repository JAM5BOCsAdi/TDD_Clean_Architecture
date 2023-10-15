import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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

  group(
    'createUser',
    () {
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

          const createdAt = 'whatever.createdAt';
          const name = 'whatever.name';
          const avatar = 'whatever.avatar';

          // Act:
          final result = await repoImpl.createUser(createdAt: createdAt, name: name, avatar: avatar);

          // Assert:
          expect(result, equals(const Right(null)));
          verify(() => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar)).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
