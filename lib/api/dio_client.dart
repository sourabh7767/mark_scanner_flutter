import 'package:dio/dio.dart';

import '../screen/login/login_screen.dart';
import '../utils/local_storage.dart';
import 'package:get/get.dart' as getx;

class LoggingInterceptor extends Interceptor {

  int _maxCharactersPerLine = 200;

  @override

  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler interceptorHandler) async {

    print("--> ${options.method} ${options.path}");

    print("Content type: ${options.contentType}");

    print("<-- END onRequest HTTP");

    return super.onRequest(options, interceptorHandler);

  }

  @override

  Future onResponse(Response response, ResponseInterceptorHandler interceptorHandler) async{

    print(

        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    String responseAsString = response.data.toString();

    if (responseAsString.length > _maxCharactersPerLine) {

      int iterations =

      (responseAsString.length / _maxCharactersPerLine).floor();

      for (int i = 0; i <= iterations; i++) {

        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;

        if (endingIndex > responseAsString.length) {

          endingIndex = responseAsString.length;

        }

        print("c"+

            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));

      }

    } else {

      print("D"+response.data);

    }

    print("<-- END onResponse HTTP");

    return super.onResponse(response, interceptorHandler);

  }

  @override

  Future onError(DioError err, ErrorInterceptorHandler errorInterceptorHandler) async {

    print("<-- Error -->");
print("code"+err.response!.data!["message"].toString());
    if (err.response!.data["message"] == "Unauthenticated.") {
      LocalStorage.delectAllData();
      getx.Get.offAll(LoginScreen());
    }
    print(err.error);

    print(err.message);

    return super.onError(err, errorInterceptorHandler);

  }

}