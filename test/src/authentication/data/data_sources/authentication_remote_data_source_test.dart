import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/utils/constants.dart';
import 'package:tdd_clean_architecture/src/authentication/data/data_sources/authentication_remote_data_source.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group(
    'createUser',
    () {
      test(
        'It should complete successfully when the statusCode is 200 or 201',
        () async {
          when(() => client.post(any(), body: any(named: 'body'))).thenAnswer((_) async => http.Response('User created successfully', 201));

          final methodCall = remoteDataSource.createUser;

          expect(
              methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
              completes);

          verify(
            () => client.post(
              Uri.parse('$kBaseUrl$kCreateUserEndPoint'),
              body: jsonEncode({
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              }),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
