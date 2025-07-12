import 'errors_messagens.dart';

sealed class Failure implements Exception {
  final String msg;
  Failure(this.msg);

  @override
  String toString() => '$runtimeType: $msg!!!';
}

class DefaultError extends Failure {
  DefaultError([super.msg = MessagesError.defaultError]);
}

class InvalidEmail extends Failure {
  InvalidEmail([super.msg = MessagesError.defaultError]);
}

class InvalidSearchText extends Failure {
  InvalidSearchText([super.msg = MessagesError.defaultError]);
}

class EmptyField extends Failure {
  EmptyField([super.msg = MessagesError.defaultError]);
}

class InvalidDate extends Failure {
  InvalidDate([super.msg = MessagesError.defaultError]);
}

class DatasourceResultEmpty extends Failure {
  DatasourceResultEmpty([super.msg = MessagesError.defaultError]);
}

class APIFailure extends Failure {
  APIFailure([super.msg = MessagesError.defaultError]);
}
