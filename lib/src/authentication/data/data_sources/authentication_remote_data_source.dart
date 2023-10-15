import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/src/authentication/data/models/user_model.dart';

import '../../../../core/utils/constants.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = '/test-api/users';
const kGetUserEndPoint = '/test-api/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  const AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // 1.  to make sure that it returns the right data when the response code is 200
    // or the proper response code
    // 2. Check to make sure that it throws a custom exception with the right message
    // when the status code is the bad one
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndPoint),
        body: jsonEncode({
          'createdAt': 'createdAt',
          'name': 'name',
          'avatar': 'avatar',
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _client.get(Uri.https(kBaseUrl, kGetUserEndPoint));

    return List<DataMap>.from(jsonDecode(response.body) as List).map((userData) => UserModel.fromMap(userData)).toList();
  }
}
