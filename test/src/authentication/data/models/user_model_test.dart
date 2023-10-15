import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

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
  const tModel = UserModel.empty();

  test(
    'It should be a subclass of [User] entity',
    () {
      // Arrange:

      // Act:

      // Assert:
      expect(tModel, isA<User>());
    },
  );

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group(
    'fromMap',
    () {
      test(
        'It should return a [UserModel] with the correct data',
        () {
          // Arrange:

          // Act:
          final result = UserModel.fromMap(tMap);

          expect(result, equals(tModel));
        },
      );
    },
  );

  group(
    'fromJson',
    () {
      test(
        'It should return a [UserModel] with the correct data',
        () {
          // Act:
          final result = UserModel.fromJson(tJson);
          expect(result, equals(tModel));
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'It should return a [Map] with the correct data',
        () {
          // Act:
          final result = tModel.toMap();
          // Assert:
          expect(result, equals(tMap));
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'It should return a [JSON] with the correct data',
        () {
          // Act:
          final result = tModel.toJson();

          final tJson = jsonEncode(
            {
              "id": "1",
              "createdAt": "_empty.createdAt",
              "name": "_empty.name",
              "avatar": "_empty.avatar",
            },
          );
          // Assert:
          expect(result, equals(tJson));
        },
      );
    },
  );

  group(
    'copyWith',
    () {
      test(
        'It should return a [UserModel] with different data',
        () {
          // Act:
          final result = tModel.copyWith(name: 'Paul');
          expect(result.name, equals('Paul'));
        },
      );
    },
  );
}
