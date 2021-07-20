import 'package:bytebank_app/http/interceptors/logging.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Uri transactionsUri = Uri.parse("http://192.168.0.165:8081/transactions");
Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);
