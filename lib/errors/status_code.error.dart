import 'package:inventory_fend/errors/exceptions.error.dart';

class StatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int requestTimeOut = 408;
  static const int internalServerError = 500;
  static const int gatewayTimeOut = 504;

  static HttpExceptionService typeStatusCode({required int statusCode}) {
    switch (statusCode) {
      case badRequest:
        return const BadRequestException(message: 'BadRequestException');
      case unauthorized:
        return const UnauthorizedException(message: 'UnauthorizedException');
      case forbidden:
        return const ForbiddenException(message: 'ForbiddenException');
      case notFound:
        return const NotFoundException(message: 'NotFoundException');
      case methodNotAllowed:
        return const MethodNotAllowed(message: 'MethodNotAllowed');
      case internalServerError:
        return const InternalServerException(
          message: 'InternalServerEsception',
        );
      case requestTimeOut:
      case gatewayTimeOut:
        return const TimeOutException(message: 'TimeOutException');
      default:
        return const UnexpectedError(message: 'UnexpectedError');
    }
  }
}
