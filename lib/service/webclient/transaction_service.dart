import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/service/interceptor/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

class TransactionService {
  final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: Duration(seconds: 5));

  final String baseUrl = "192.168.0.10:8080";

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, "/transactions"))
        .timeout(Duration(seconds: 5));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client.post(
        Uri.http(baseUrl, "/transactions"),
        headers: {'password': password},
        body: jsonEncode(transaction.toJson()));
    return Transaction.fromJson(jsonDecode(response.body));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };
}

