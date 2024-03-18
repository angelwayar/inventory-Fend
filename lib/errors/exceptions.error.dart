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
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class UnauthorizedException extends HttpExceptionService {
  const UnauthorizedException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class ForbiddenException extends HttpExceptionService {
  const ForbiddenException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class NotFoundException extends HttpExceptionService {
  const NotFoundException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class MethodNotAllowed extends HttpExceptionService {
  const MethodNotAllowed({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class InvalidInputException extends HttpExceptionService {
  const InvalidInputException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class UnexpectedError extends HttpExceptionService {
  const UnexpectedError({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class InternalServerException extends HttpExceptionService {
  const InternalServerException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
}

class TimeOutException extends HttpExceptionService {
  const TimeOutException({
    required String message,
    String? bodyMessage,
    DioExceptionType? dioExceptionType,
  }) : super(
          message: message,
          bodyMessage: bodyMessage,
          dioExceptionType: dioExceptionType,
        );
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
