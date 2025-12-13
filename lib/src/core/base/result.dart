abstract class Result<T> {
  T? data;
  String? message;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

class Success<T> extends Result<T> {
  Success(T data) {
    this.data = data;
  }
}

class Failure<T> extends Result<T> {
  Failure(String message) {
    this.message = message;
  }
}
