import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'services/weather.dart';

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
  int wxValue;
  String wxIcon;
  String maxT;
  String minT;
  String pop;

  @override
  void initState() {
    super.initState();
    // weatherData = getData();
    updateWeather();
    // print(weatherData); /////
  }

  @override
  Widget build(BuildContext context) {
    // print(weatherData); //////////
    // updateWeather(); //////
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
                        '${_locations < 0 ? "" : " 今日天氣 "}',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    '${_locations < 0 ? "" : wxIcon}' +
                        '${_locations < 0 ? "" : minT}' +
                        '${_locations < 0 ? "" : "°c~"}' +
                        '${_locations < 0 ? "" : maxT}' +
                        '${_locations < 0 ? "" : "°c"}' +
                        '${_locations < 0 ? "" : " 💧"}' +
                        '${_locations < 0 ? "" : pop}' +
                        '${_locations < 0 ? "" : "%"}',
                    // '${_locations < 0 ? "" : _locations}', /////////
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
          weatherData = await getData();
          setState(() {
            try {
              if (locations.index == 0) {
                _locations = -1;
              } else {
                _locations = locations.index;
                updateWeather();
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

  // void updateData() async {
  //   weatherData = await getData();
  //   print("bbbbbbbbbbb$weatherData");
  // }

  void updateWeather() async {
    // print("aaaaaaaaaaa$weatherData");
    setState(() {
      if (weatherData == null || _locations < 0) {
        cityName = '';
        wxIcon = '';
        maxT = '';
        minT = '';
        pop = '';
        // print('test1'); ///////
        return;
      }
      cityName = weatherData['cwbopendata']['dataset']['location']
          [_locations - 1]['locationName'];
      wx = weatherData['cwbopendata']['dataset']['location'][_locations - 1]
          ['weatherElement'][0]['time'][1]['parameter']['parameterValue'];
      wxValue = int.parse(wx);
      // print(wxValue);
      wxIcon = getWeatherIcon(wxValue);
      maxT = weatherData['cwbopendata']['dataset']['location'][_locations - 1]
          ['weatherElement'][1]['time'][1]['parameter']['parameterName'];
      minT = weatherData['cwbopendata']['dataset']['location'][_locations - 1]
          ['weatherElement'][2]['time'][1]['parameter']['parameterName'];
      pop = weatherData['cwbopendata']['dataset']['location'][_locations - 1]
          ['weatherElement'][4]['time'][1]['parameter']['parameterName'];
    });
  }
}
