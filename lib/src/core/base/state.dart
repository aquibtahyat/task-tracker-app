import 'package:equatable/equatable.dart';

abstract class BaseState<T> extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

class InitialState<T> extends BaseState<T> {
  const InitialState();

  @override
  List<Object?> get props => [];
}

class LoadingState<T> extends BaseState<T> {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class LoadingMoreState<T> extends BaseState<T> {
  final T data;

  const LoadingMoreState(this.data);

  @override
  List<Object?> get props => [data];
}

class SuccessState<T> extends BaseState<T> {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class FailureState<T> extends BaseState<T> {
  final String message;
  final Object? error;

  const FailureState(this.message, {this.error});

  @override
  List<Object?> get props => [message, error];
}
