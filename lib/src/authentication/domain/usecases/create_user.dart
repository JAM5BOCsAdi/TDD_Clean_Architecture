import 'package:equatable/equatable.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/usecase/usecase.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;
  const CreateUser(this._repository);

  @override
  ResultFuture call(CreateUserParams params) async => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
