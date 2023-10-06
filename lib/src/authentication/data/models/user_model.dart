import 'package:tdd_clean_architecture/src/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
        );
}
