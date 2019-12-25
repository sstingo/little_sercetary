import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const dataid = 'F-C0032-001';
const apiKey = 'CWB-9986681F-B9E6-474D-8458-753CD3B1C344';
const format = 'JSON';

enum Locations {
  Taipei,
  NewTaipei,
  Taoyuan,
  Taichung,
  Tainan,
  Kaohsiung,
  Keelung,
  Hsinchu,
  HsinchuCity,
  Miaoli,
  Changhua,
  Nantou,
  Yunlin,
  Chiayi,
  ChiayiCity,
  Pingtung,
  Yilan,
  Hualien,
  Taitung,
  Penghu,
  Kinmen,
  Lienchiang,
  None,
}

Future<dynamic> getData() async {
  http.Response response = await http.get(
      'https://opendata.cwb.gov.tw/fileapi/v1/opendataapi/$dataid?Authorization=$apiKey&format=$format');

  if (response.statusCode == 200) {
    String data = response.body;
    dynamic decodedData = jsonDecode((data));
    return decodedData;
  } else {
    print(response.statusCode);
  }
}

String getCityName(int _locations) {
  List cityList = [
    '臺北市',
    '新北市',
    '桃園市',
    '臺中市',
    '臺南市',
    '高雄市',
    '基隆市',
    '新竹縣',
    '新竹市',
    '苗栗縣',
    '彰化縣',
    '南投縣',
    '雲林縣',
    '嘉義縣',
    '嘉義市',
    '屏東縣',
    '宜蘭縣',
    '花蓮縣',
    '臺東縣',
    '澎湖縣',
    '金門縣',
    '連江縣'
  ];

  return cityList[_locations];
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

Future<Locations> showAlert(BuildContext context) {
  //跳出視窗
  return showDialog<Locations>(
    context: context,
    barrierDismissible: true, //控制點擊對話框以外的區域是否隱藏對話框
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('選擇所在地區'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.None);
            },
            child: const Text('...'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Taipei);
            },
            child: const Text('臺北市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.NewTaipei);
            },
            child: const Text('新北市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Keelung);
            },
            child: const Text('基隆市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Taoyuan);
            },
            child: const Text('桃園市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Hsinchu);
            },
            child: const Text('新竹縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.HsinchuCity);
            },
            child: const Text('新竹市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Miaoli);
            },
            child: const Text('苗栗縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Taichung);
            },
            child: const Text('臺中市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Changhua);
            },
            child: const Text('彰化縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Nantou);
            },
            child: const Text('南投縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Yunlin);
            },
            child: const Text('雲林縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Chiayi);
            },
            child: const Text('嘉義縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.ChiayiCity);
            },
            child: const Text('嘉義市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Tainan);
            },
            child: const Text('臺南市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Kaohsiung);
            },
            child: const Text('高雄市'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Pingtung);
            },
            child: const Text('屏東縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Yilan);
            },
            child: const Text('宜蘭縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Hualien);
            },
            child: const Text('花蓮縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Taitung);
            },
            child: const Text('臺東縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Penghu);
            },
            child: const Text('澎湖縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Kinmen);
            },
            child: const Text('金門縣'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop(Locations.Lienchiang);
            },
            child: const Text('連江縣'),
          ),
        ],
      );
    },
  );
}
