import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/entities/user.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

/// 1. What does the class depend on? Example: ClassName(); <- Constructor depends on the inside content
/// Here:
/// CreateUser class depends on AuthenticationRepository, because it has "something" inside the Constructor
/// fina AuthenticationRepository _repository;
/// const CreateUser(this._repository);

/// 2. How can we create a fake version of the dependency? -- We do not want to use for example the same HTTP, we want to use a fake one.
/// Use Mocktail

/// 3. How do we control what our dependencies do?
/// Using the Mocktail's APIs

void main() {
  late AuthenticationRepository repository;
  late GetUsers useCase;

  setUp(
    () {
      repository = MockAuthenticationRepository();
      useCase = GetUsers(repository);
    },
  );

  const tResponse = [User.empty()];

  test(
    'It should call [AuthenticationRepository.getUsers] and return [List<User>]',
    () async {
      // Arrange: Put everything together we need fo our function to work
      // STUB
      when(
        () => repository.getUsers(),
      ).thenAnswer(
        (_) async => const Right(tResponse),
      );

      // Act:
      final result = await useCase(); // Same as: useCase.call(params) From: GetUser's [call] method

      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

      verify(() => repository.getUsers()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
