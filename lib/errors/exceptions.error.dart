import 'package:dio/dio.dart';

/// Client Exceptions - Remote
class HttpExceptionService implements Exception {
  const HttpExceptionService({
    required this.message,
    this.bodyMessage,
    this.dioExceptionType,
  });

  final String message;
  final String? bodyMessage;
  final DioExceptionType? dioExceptionType;
}

class BadRequestException extends HttpExceptionService {
  const BadRequestException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class UnauthorizedException extends HttpExceptionService {
  const UnauthorizedException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class ForbiddenException extends HttpExceptionService {
  const ForbiddenException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class NotFoundException extends HttpExceptionService {
  const NotFoundException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class MethodNotAllowed extends HttpExceptionService {
  const MethodNotAllowed({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class InvalidInputException extends HttpExceptionService {
  const InvalidInputException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class UnexpectedError extends HttpExceptionService {
  const UnexpectedError({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class InternalServerException extends HttpExceptionService {
  const InternalServerException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

class TimeOutException extends HttpExceptionService {
  const TimeOutException({
    required super.message,
    super.bodyMessage,
    super.dioExceptionType,
  });
}

/// Client Exceptions - Local
class LocalExceptionService implements Exception {
  const LocalExceptionService({
    required this.message,
    this.bodyMessage,
  });

  final String message;
  final String? bodyMessage;
}
