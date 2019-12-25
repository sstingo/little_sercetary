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
  int _locations = 22;
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
    // setData() await;
    // Future setData() async {
    //   weatherData = await getData();
    // }

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
            heightFactor: 0.11,
            child: Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '天氣',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${_locations >= 22 ? "未選擇地區" : cityName}' +
                        // '${_locations >= 22 ? "" : Locations.values[_locations]}' + //////
                        // '${_locations > 22 ? "" : _locations}' +
                        '${_locations >= 22 ? "" : " 💧"}' +
                        '${_locations >= 22 ? "" : pop}' +
                        '${_locations >= 22 ? "" : "%"}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    '${_locations >= 22 ? "" : wxIcon}' +
                        '${_locations >= 22 ? "" : minT}' +
                        '${_locations >= 22 ? "" : "°c~"}' +
                        '${_locations >= 22 ? "" : maxT}' +
                        '${_locations >= 22 ? "" : "°c"}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
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
                _locations = 22;
              } else {
                _locations = locations.index;
                updateWeather();
              }
            } catch (e) {
              print('fail'); ///////////
              // _locations = 22;
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void updateWeather() async {
    // print(_locations); /////////
    setState(() {
      if (weatherData == null || _locations >= 22) {
        cityName = '';
        wxIcon = '';
        maxT = '';
        minT = '';
        pop = '';
        _locations = 22;
        print('updateWeather fail');
        return;
      }
      // cityName = weatherData['cwbopendata']['dataset']['location']
      //     [_locations - 1]['locationName'];
      cityName = getCityName(_locations);
      wx = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][0]['time'][1]['parameter']['parameterValue'];
      wxValue = int.parse(wx);
      wxIcon = getWeatherIcon(wxValue);
      maxT = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][1]['time'][1]['parameter']['parameterName'];
      minT = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][2]['time'][1]['parameter']['parameterName'];
      pop = weatherData['cwbopendata']['dataset']['location'][_locations]
          ['weatherElement'][4]['time'][1]['parameter']['parameterName'];
    });
  }
}
