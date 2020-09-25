import 'package:http/http.dart' as http;

class Api {
  static final _api = Api._internal();
  factory Api() {
    return _api;
  }
  Api._internal();
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOWM0MzFjMDRjMmM4NTJkM2Y3OWQ3MGRhZmEwYzA4ZGZhN2VmOGI3NzY1YjZiNTA4MjgzYmY1OWIzNWI4N2I1ODYxMGU3OWNhNmQwMjYwNDIiLCJpYXQiOjE2MDA5NTc1NjMsIm5iZiI6MTYwMDk1NzU2MywiZXhwIjoxNjMyNDkzNTYzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Ee-Rm-V_IH365dZ7RYNp77D7UJycXCEGd1yHv8DaKSqg5iM006YWLUi3GIDPAM-dA0okjdMxrdUtomVrsQGjUN2nEzUsojVdEDNuqTA4JMMhtJHEtTvSnubsdi7vWz3QIM9PpT4yn6OnOqxTiYQNGYpbuokaRof6-aIwndl11yTNPSj8tBvgmBfrIpGjxHEmEzio_mpVH7tr4_SCN1mIlDcdxO91ZNO6_OgAOkJNumXnDfoRatN7T6Js_NlU6mGHjTWUdAL36FUzguOPgv4x3L2uIO3dRcU8cI0lQzQ9vb_xWTnVTz4K2xbBxsgCYiadqnoKhsiHkjw5kAEoN0we0Dm9aFSUJ4NXEWe0juCwYtm3J4aIe3sdodneSVv8svSa6KsDPZF35Vq6gNJKBno8ZKL8qm0S8dhbYn18VCmsr1Gqcj2fAizJubdeVLOs2bJBw2rTKBoLUAscjvTLiEcfDhrGcYcuLvhVWLICTSYejj7BneB3LlLp8o3Ov4KaZ_hwiko7VWyOacCnwizKyh6xXNKh7gF4n8mwO4qxCEoLHsKrePacXZ_PBOLke3tI8VoHjuEqijEnEEebMHYfHyF0TZAHGDGQ1QeKJfjDAcjCc_i7GvJ3edHYcyuen-BtU_o36gEuFwZyXPhnPwDWaD6luvncsde7nXUp9jPwBA5mZUA";
  String baseUrl = '192.168.1.16';
  String path = '/web/socket/public/api';
//
  Future<http.Response> httpGet(
      String endPath, Map<String, String> query) async {
    // String uripath = '$path/$endPath';
    // print(uripath);
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    if (query != null) {
      uri = Uri.http(baseUrl, '$path/$endPath', query);
    }
    return http.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'Application/json',
    });
  }

  Future<http.Response> httpPost(String endPath, Object body) async {
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    return http.post(uri, body: body, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'Application/json',
    });
  }
}
