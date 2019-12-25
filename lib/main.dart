import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'services/weather.dart';

const dataid = 'F-C0032-001';
const apiKey = 'CWB-9986681F-B9E6-474D-8458-753CD3B1C344';
const format = 'JSON';

// enum ConfirmAction { ACCEPT, CANCEL }
enum Locations {
  None,
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
  Lienchiang
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '生活小秘書'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic weatherData;
  int _locations = -1;
  String cityName;
  String wx;
  String wxValue;
  String wxIcon;
  String maxT;
  String minT;
  String pop;

  @override
  void initState() {
    super.initState();
    // weatherData = getData();
    // updateWeather(weatherData, _locations);
    // print(weatherData); /////
  }

  @override
  Widget build(BuildContext context) {
    ////
    // print(weatherData); //////////
    updateWeather(_locations); //////
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            //百分比調大小
            widthFactor: 1,
            heightFactor: 0.2,
            child: Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '天氣',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${_locations < 0 ? "未選擇地區" : Locations.values[_locations]}' +
                        '${_locations < 0 ? "" : " 今日天氣 "}' +
                        '${_locations < 0 ? "" : minT}' +
                        '${_locations < 0 ? "" : "°c~"}' +
                        '${_locations < 0 ? "" : maxT}' +
                        '${_locations < 0 ? "" : "°c"}',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    '${_locations < 0 ? "" : wx}' +
                        '${_locations < 0 ? "" : " 💧"}' +
                        '${_locations < 0 ? "" : pop}' +
                        '${_locations < 0 ? "" : "%"}' +
                        '${_locations < 0 ? "" : _locations}', /////////
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                    // style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var locations = await showAlert(context);
          setState(() {
            try {
              if (locations.index == 0) {
                _locations = -1;
              } else {
                _locations = locations.index;
                updateWeather(_locations);
              }
            } catch (e) {
              // print('fail');
              // _locations = -1;
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void updateWeather(int _locations) async {
    weatherData = await getData();
    print("aaaaaaaaaaa$weatherData");
    setState(() {
      if (weatherData == null || _locations < 0) {
        cityName = '';
        wxIcon = '';
        maxT = '';
        minT = '';
        pop = '';
        print('test1'); ///////
        return;
      }
      cityName = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['locationName'];
      wx = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][0]['time'][1]['parameter']['parameterValue'];
      // wxValue = ;
      // wx = getWeatherIcon(wxValue);
      maxT = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][1]['time'][1]['parameter']['parameterName'];
      minT = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][2]['time'][1]['parameter']['parameterName'];
      pop = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][4]['time'][1]['parameter']['parameterName'];
    });
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
                Navigator.of(context).pop(Locations.Taoyuan);
              },
              child: const Text('桃園市'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(Locations.Taichung);
              },
              child: const Text('臺中市'),
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
                Navigator.of(context).pop(Locations.Keelung);
              },
              child: const Text('基隆市'),
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
}
