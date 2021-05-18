import 'dart:convert';

import 'package:bytebank/models/Transaction.dart';
import 'package:bytebank/service/interceptor/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

class TransactionService {
  final Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

  final String baseUrl = "192.168.1.179:8081";

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, "/transactions"))
        .timeout(Duration(seconds: 5));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client
        .post(Uri.http(baseUrl, "/transactions"), body: transaction.toJson());
    return Transaction.fromJson(jsonDecode(response.body));
  }
}