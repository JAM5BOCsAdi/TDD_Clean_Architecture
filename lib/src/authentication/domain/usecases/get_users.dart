import 'package:tdd_clean_architecture/core/utils/typedef.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;

  const GetUsers(this._repository);

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
