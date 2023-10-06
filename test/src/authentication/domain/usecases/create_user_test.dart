import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';

/// 1. What does the class depend on? Example: ClassName(); <- Constructor depends on the inside content
/// Here:
/// CreateUser class depends on AuthenticationRepository, because it has "something" inside the Constructor
/// fina AuthenticationRepository _repository;
/// const CreateUser(this._repository);

/// 2. How can we create a fake version of the dependency? -- We do not want to use for example the same HTTP, we want to use a fake one.
/// Use Mocktail

/// 3. How do we control what our dependencies do?
/// Using the Mocktail's APIs

/// This class [MockAuthenticationRepository] is going to be a [Mock] version of [AuthenticationRepository]
class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  // It will instantiate a new "useCase" for us every time you make a new test
  setUpAll(() {
    repository = MockAuthenticationRepository();
    useCase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
    'It Should call the [Repository.createUser] method',
    () async {
      // Arrange: Put everything together we need fo our function to work
      // STUB
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act:
      final result = await useCase(params); // Same as: useCase.call(params) From: CreateUser's [call] method

      // Assert:                  Right<Failure, void>    if    Left<void, dynamic> or Left<void, Failure>
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
