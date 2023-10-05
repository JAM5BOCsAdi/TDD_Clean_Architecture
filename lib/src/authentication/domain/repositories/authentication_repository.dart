import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/src/authentication/domain/entities/user.dart';

/// Authentication Repository: It means what functionality /-ies this feature (authentication) carries,
/// but it does not actually implement them.
/// Authentication is a feature (So basically we could put it in a folder, named features)
abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
