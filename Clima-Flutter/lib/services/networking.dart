import 'package:http/http.dart' as http;
import 'dart:convert';

class NewtorkHelper {
  NewtorkHelper(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(url);
    int code = response.statusCode;
    if (code == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
