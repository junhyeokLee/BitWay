import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'DioError.dart';

final logger = Logger();

Future<T> HandleError<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioError catch (e) {
    final errorMessage = getErrorMessage(e);
    logger.e('DioError: $errorMessage');
    throw Exception(errorMessage);
  } catch (e) {
    final errorMessage = getErrorMessage(e);
    logger.e('General Error: $errorMessage');
    throw Exception(errorMessage);
  }
}