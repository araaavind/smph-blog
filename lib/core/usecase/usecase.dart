import 'package:fpdart/fpdart.dart';
import 'package:semaphore/core/error/failures.dart';

abstract interface class Usecase<SuccessType, ParamsType> {
  Future<Either<Failure, SuccessType>> call(ParamsType params);
}

class NoParams {}
