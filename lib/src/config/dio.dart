import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiDio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['apiUrl'] ?? '',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);

final mediaDio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['mediaUrl'] ?? '',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
