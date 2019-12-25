// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const dataid = 'F-C0032-001';
const apiKey = 'CWB-9986681F-B9E6-474D-8458-753CD3B1C344';
const format = 'JSON';

Future<dynamic> getData() async {
  http.Response response = await http.get(
      'https://opendata.cwb.gov.tw/fileapi/v1/opendataapi/$dataid?Authorization=$apiKey&format=$format');

  if (response.statusCode == 200) {
    String data = response.body;
    dynamic decodedData = jsonDecode(data);
    print("--------------------------------------------------"); /////
    print(decodedData['cwbopendata']['dataset']['location'][0]['weatherElement']
        [1]['time'][1]['parameter']['parameterName']); ////////////

    // print(Utf8Decoder().convert(decodedData));
    // print(decodedData); /////
    return decodedData;
  } else {
    print(response.statusCode);
  }
}

String getWeatherIcon(int parameterValue) {
  if (parameterValue == 1) {
    return '☀️';
  } else if (parameterValue <= 3) {
    return '🌥️';
  } else if (parameterValue <= 7) {
    return '☁️';
  } else if (parameterValue <= 22) {
    return '🌧️';
  } else {
    return '🤷‍';
  }
}
