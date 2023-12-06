
import 'package:dio/dio.dart';

abstract class DioApi {
  Future<Response> post(
      {required String url,
      required body,
      required String token,
      Map<String, dynamic>? headers});
}

class DioApiImplementation implements DioApi {
  @override
  Future<Response> post(
      {required String url,
      required body,
      required String token,
      Map<String, dynamic>? headers}) async {
    Dio dio = Dio();

    var res = await dio.post(url,
        data: body,
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            headers: headers ?? {'Authorization': "Bearer $token"}));
    return res;
  }
}
