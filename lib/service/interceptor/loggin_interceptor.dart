import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'password': '2000'
  };

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (data.method == Method.POST) {
      data.headers.addAll(headers);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    //print("***RESPONSE***");
    //print(data.statusCode);
    //print(data.headers);
    //print(data.body);
    return data;
  }
}
