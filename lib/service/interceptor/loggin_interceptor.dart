import 'package:bytebank/service/exceptions/http_exception.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction exists'
  };

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final List<int> _statusAccept = [200, 201, 202, 203, 204];

  void _throwHttpError(int statusCode) =>
      throw HttpException(_getMessage(statusCode));

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    } else {
      return 'Unknown error';
    }
  }

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (data.method == Method.POST) {
      data.headers.addAll(headers);
    }
    print(data.baseUrl);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (!_statusAccept.contains(data.statusCode)) {
      _throwHttpError(data.statusCode);
    }
    return data;
  }
}
