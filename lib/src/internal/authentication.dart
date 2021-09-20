import 'dart:convert';

import 'constants.dart' as Constants;
import 'package:http/http.dart' as http;

class Authentication {
  static final Authentication _singleton = Authentication._internal();

  factory Authentication() {
    return _singleton;
  }

  Authentication._internal();

  Future<String> getAccessToken(String clientID, String clientSecret) async {
    final uri = Uri.parse([Constants.CEDARMAPS_BASE_URL, 'v1/token'].join('/'));

    var body = new Map<String, String>();
    body['client_id'] = clientID;
    body['client_secret'] = clientSecret;

    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body);

    var response = await http.post(uri, body: body);

    if (response.statusCode != 200) {
      throw ('Invalid client id or secret provided');
    } else {
      return jsonDecode(response.body)['access_token'];
    }
  }
}
