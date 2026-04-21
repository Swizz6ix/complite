import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:complite/core/errors/app_error.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/company_repository.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class CompanyApi implements CompanyRepository {
  // final _logger = Logger("CompanyApp.Repository");
  @override
  Future<List<CompanyDto>> fetchCompany(
    String requestId, 
    // {
      // int page = 1,
      // int limit = 10
    // }
    ) async {
    try {
      final response = await retry(
        () => http
        .get(Uri.parse(
          'https://json-placeholder.mock.beeceptor.com/companies'))
        .timeout(Duration(seconds: 10)),

        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 2,
        maxDelay: Duration(seconds: 1),
      );

      if (response.statusCode != 200) {
        throw HttpException("server error ${response.statusCode}");
      }

      // _logger.info("[$requestId] HTTP status code: ${response.statusCode}");
      
      final jsonList = jsonDecode(response.body);

      if (jsonList is! List) {
        throw const FormatException("Expected a JSON list");
      }

      return jsonList
        .map((e) => CompanyDto.fromJson(e as Map<String, dynamic>))
        .toList();

    } on SocketException {
      // _logger.warning("[$requestId] No internet connection");
    throw SocketException("No Internet connection");
    } on TimeoutException {
      // _logger.warning("[$requestId] Request time out");
      throw TimeoutException("Request time out");
    } on FormatException catch(e) {
      // _logger.severe("[$requestId] Json parsing error: ${e.message}");
      throw FormatException("Invalid JSON ${e.message}");
    } 
  }
}