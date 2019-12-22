import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const dataid = 'F-C0032-001';
const apiKey = 'CWB-9986681F-B9E6-474D-8458-753CD3B1C344';
const format = 'JSON';

enum ConfirmAction { ACCEPT, CANCEL }
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    super.initState();
    // getData(); ////
  }

  @override
  Widget build(BuildContext context) {
    getData(); ////
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',
              style: Theme.of(context).textTheme.display1,
            ),
            // DropdownList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlert(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void getData() async {
    http.Response response = await http.get(
        'https://opendata.cwb.gov.tw/fileapi/v1/opendataapi/$dataid?Authorization=$apiKey&format=$format');

    String data = response.body;
    // var encodedata = Utf8Encoder(data);
    var decodedData = jsonDecode(data);
    // var city =
    //     decodedData['cwbopendata']['dataset']['location'][0]['locationName'];
    //cwbopendata.dataset.location[0].locationName

    print(decodedData);
  }

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
                // Navigator.pop(context, Locations.Taipei);
                Navigator.of(context).pop(Locations.Taipei);
              },
              child: const Text('臺北市'),
            ),
            SimpleDialogOption(
              onPressed: () {
                // Navigator.pop(context, Locations.NewTaipei);
                Navigator.of(context).pop(Locations.NewTaipei);
              },
              child: const Text('新北市'),
            ),
            SimpleDialogOption(
              onPressed: () {
                // Navigator.pop(context, Locations.Taoyuan);
                Navigator.of(context).pop(Locations.Taoyuan);
              },
              child: const Text('桃園市'),
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
