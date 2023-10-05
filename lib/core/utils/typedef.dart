import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
