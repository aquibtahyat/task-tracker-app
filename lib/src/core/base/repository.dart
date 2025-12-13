import 'package:dio/dio.dart';
import 'package:task_tracker_app/src/core/network/error_handler.dart';

import 'result.dart';

abstract base class Repository {
  Future<Result<T>> asyncGuard<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Success<T>(result);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.handleError(e);
      return Failure<T>(errorMessage);
    } on Exception catch (e) {
      return Failure<T>(e.toString());
    } catch (e) {
      return Failure<T>('Something went wrong');
    }
  }
}
