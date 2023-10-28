import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class _ServerErrorHandler extends Failure {
  _ServerErrorHandler(String message) : super(message);

  factory _ServerErrorHandler.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.cancel:
        return _ServerErrorHandler('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return _ServerErrorHandler('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return _ServerErrorHandler(
            'Send timeout in connection with API server');
      case DioExceptionType.receiveTimeout:
        return _ServerErrorHandler(
            'Receive timeout in connection with API server');
      case DioExceptionType.badCertificate:
        return _ServerErrorHandler('badCertificate with api server');
      case DioExceptionType.badResponse:
        return _ServerErrorHandler.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.connectionError:
        return _ServerErrorHandler('No Internet Connection');
      case DioExceptionType.unknown:
        return _ServerErrorHandler('Something went wrong');
      default:
        return _ServerErrorHandler('Something went wrong');
    }
  }

  factory _ServerErrorHandler.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return _ServerErrorHandler(response['error']['message']);
    } else if (statusCode == 404) {
      return _ServerErrorHandler(
          'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return _ServerErrorHandler(
          'There is a problem with server, please try later');
    } else {
      return _ServerErrorHandler('There was an error , please try again');
    }
  }
}

String handleServerError(e) {
  String error = _ServerErrorHandler(e.toString()).message;
  if (e is DioException) {
    error = _ServerErrorHandler.fromDiorError(e).message;
  }
  return error;
}
