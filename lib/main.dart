import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'services/weather.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '天氣'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic weatherData;
  int _locations = -1;
  String cityName;
  String wx;
  int maxT;
  int minT;
  int pop;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // getData(); ////
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            //百分比調大小
            widthFactor: 1,
            heightFactor: 0.1,
            child: Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
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
                    '${_locations < 0 ? "未選擇地區" : Locations.values[_locations]}',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    '${_locations < 0 ? "💧" : _locations - 1}',
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
              }
            } catch (e) {
              print('fail');
              // _locations = -1;
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  dynamic getData() async {
    http.Response response = await http.get(
        'https://opendata.cwb.gov.tw/fileapi/v1/opendataapi/$dataid?Authorization=$apiKey&format=$format');

    String data = response.body;
    // var encodedata = Utf8Encoder(data);
    var decodedData = jsonDecode(data);
    // var city =
    //     decodedData['cwbopendata']['dataset']['location'][0]['locationName'];
    //cwbopendata.dataset.location[0].locationName

    print(decodedData); /////

    return weatherData;
  }

  //  void updateWeather(dynamic weatherData, int _locations) {
  //   setState(() {
  //    if (weatherData == null) {
  //         cityName = '';
  //         wx = '';
  //         maxT = 0;
  //         minT = 0;
  //         pop = 0;
  //       return;
  //    }
  //         cityName = weatherData['cwbopendata']['dataset']['location'][_locations]['locationName'];
  //           //cwbopendata.dataset.location[0].locationName
  //         wx = weatherData['cwbopendata']['dataset']['location'][_locations]['weatherElement'][0]['time'][1]['parameter']['parameterName'];
  //         // cwbopendata.dataset.location[0].weatherElement[0].time[1].parameter.parameterValue
  //         maxT = weatherData['cwbopendata']['dataset']['location'][_locations]['weatherElement'][1]['time'][1]['parameter']['parameterName'];
  //         // cwbopendata.dataset.location[0].weatherElement[1].time[1].parameter.parameterName
  //         minT = weatherData['cwbopendata']['dataset']['location'][_locations]['weatherElement'][2]['time'][1]['parameter']['parameterName'];
  //         // cwbopendata.dataset.location[0].weatherElement[2].time[1].parameter.parameterName
  //         // cwbopendata.dataset.location[0].weatherElement[2].time[2].parameter.parameterName
  //         pop = weatherData['cwbopendata']['dataset']['location'][_locations]['weatherElement'][4]['time'][1]['parameter']['parameterName'];
  //         // cwbopendata.dataset.location[0].weatherElement[4].time[1].parameter.parameterName
  //   });
  // }

  Future<Locations> showAlert(BuildContext context) async {
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

            // actions: <Widget>[
            //   // Center(
            //   //   child: DropdownList(),
            //   // ),
            //   FlatButton(
            //     child: const Text('取消'),
            //     onPressed: () {
            //       Navigator.of(context).pop(ConfirmAction.CANCEL);
            //     },
            //   ),
            //   FlatButton(
            //     child: const Text('確認'),
            //     onPressed: () {
            //       Navigator.of(context).pop(ConfirmAction.ACCEPT);
            //     },
            //   ),
          ],
        );
      },
    );
  }
}

// class DropdownList extends StatefulWidget {
//   @override
//   _DropdownListState createState() {
//     return _DropdownListState();
//   }
// }

// class _DropdownListState extends State<DropdownList> {
//   String _value;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownButton<String>(
//         items: [
//           DropdownMenuItem<String>(
//             child: Text('Item 1'),
//             value: 'one',
//           ),
//           DropdownMenuItem<String>(
//             child: Text('Item 2'),
//             value: 'two',
//           ),
//           DropdownMenuItem<String>(
//             child: Text('Item 3'),
//             value: 'three',
//           ),
//         ],
//         onChanged: (String value) {
//           setState(() {
//             _value = value;
//           });
//         },
//         hint: Text('Select Item'),
//         value: _value,
//       ),
//     );
//   }
// }
