import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'services/weather.dart';
import 'screens/Test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  double buttonHeight = 50;

  @override
  void initState() {
    super.initState();
    // setData() await;
    // Future setData() async {
    //   weatherData = await getData();
    // }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  // blurRadius: 20.0,
                  // spreadRadius: 20.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '天氣',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[600],
                  ),
                ),
                Container(
                  // width: 100,
                  // height: buttonHeight,
                  height: 50, ////////////////////////
                  child: RaisedButton(
                    color: Colors.deepOrange[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    onPressed: () async {
                      var locations = await showAlert(context);
                      weatherData = await getData();
                      setState(() {
                        try {
                          if (locations.index == 0) {
                            _locations = 22;
                            buttonHeight = 50;
                          } else {
                            _locations = locations.index;
                            buttonHeight = 0;
                            updateWeather();
                          }
                        } catch (e) {
                          print('fail');
                        }
                      });
                    },
                    child: Text(
                      '請選擇地區',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Text(
                  '${_locations >= 22 ? "" : cityName}' +
                      '${_locations >= 22 ? "" : " 💧"}' +
                      '${_locations >= 22 ? "" : pop}' +
                      '${_locations >= 22 ? "" : "%"}',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  '${_locations >= 22 ? "" : wxIcon}' +
                      '${_locations >= 22 ? "" : minT}' +
                      '${_locations >= 22 ? "" : "°c~"}' +
                      '${_locations >= 22 ? "" : maxT}' +
                      '${_locations >= 22 ? "" : "°c"}',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            //擴張到父最大(不管子大小)
            child: Container(
              color: Colors.orange[50],
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: 100,
                    left: 50,
                    top: 40,
                    child: Image.asset('image/catcat2.png'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.deepOrange[200]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: RaisedButton(
                              color: Colors.orange[700],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Test();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                '健康',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.deepOrange[200]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: RaisedButton(
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Test();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                '財務',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.deepOrange[200]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: RaisedButton(
                              color: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Test();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                '用餐',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5, color: Colors.deepOrange[200]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: RaisedButton(
                              color: Colors.red[700],
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Test();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                '遊戲',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Image.asset('image/catcat2.png'),
                ],
              ),
            ),
          ),
        ],
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
        buttonHeight = 50;
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

//   child: FractionallySizedBox(
//     //百分比調大小
//     widthFactor: 1,
//     heightFactor: 0.11,

// floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var locations = await showAlert(context);
//           weatherData = await getData();
//           print('test'); ////////////
//           setState(() {
//             try {
//               if (locations.index == 0) {
//                 _locations = 22;
//                 buttonHeight = 50;
//               } else {
//                 _locations = locations.index;
//                 buttonHeight = 0;
//                 updateWeather();
//               }
//             } catch (e) {
//               print('fail'); ///////////
//               // _locations = 22;
//             }
//           });
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
