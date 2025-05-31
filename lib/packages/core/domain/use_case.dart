import 'dart:async';

/// A simple use case that does not have neither an input nor an output
abstract class UseCase {
  FutureOr<void> call();
}

/// A use case that takes an input [IN] and returns an output [OUT]
abstract class UseCase2<IN, OUT> {
  FutureOr<OUT> call(IN input);
}

/// A use case that does not accept an input but returns an output [OUT]
abstract class UseCaseOut<OUT> {
  FutureOr<OUT> call();
}

/// A use case that does accepts an input [IN] but does not return anything
abstract class UseCaseIn<IN> {
  FutureOr<void> call(IN input);
}
