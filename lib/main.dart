import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timetodisplay = "";
  bool checktimer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tb = TabController(
      length: 2,
      vsync: this,
    );
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
//    debugPrint(timeForTimer.toString());
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState(() {
        if(timeForTimer < 1 || checktimer == false) {
          t.cancel();
//          checktimer = true;
//          timetodisplay = "";
//          started = true;
//          stopped = true;
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomePage(),
          ));
        }

        else if(timeForTimer < 60) {
          timetodisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if(timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
        }

//        else {
//          timeForTimer = timeForTimer - 1;
//        }
//        timetodisplay = timeForTimer.toString();
//        timeForTimer = timeForTimer - 1;
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0
                      ),
                      child: Text(
                        "HH", style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700
                      ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        }
                    )
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0
                      ),
                      child: Text(
                          "MM", style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700
                      ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        }
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0
                      ),
                      child: Text(
                          "SS" , style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700
                      ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        }
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
                timetodisplay, style: TextStyle(
                fontSize: 35.0,
              fontWeight: FontWeight.w600
            ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: started ? start : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0
                    ),
                    color: Colors.green,
                    child: Text(
                      "Start", style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  RaisedButton(
                    onPressed: stopped ? null : stop,
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0
                    ),
                    color: Colors.red,
                    child: Text(
                      "Stop", style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )
                ],

            ),
          ),
        ],
      ),
    );
  }


  Widget stopwatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "00:00:00",
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RaisedButton(
                          child: Text('Stop', style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                          ),),
                          onPressed: (){},
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 15.0
                        ),
                      ),

                      RaisedButton(
                        child: Text('Stop', style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                        onPressed: (){},
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0
                        ),
                      ),

                      RaisedButton(
                        child: Text('Stop', style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                        onPressed: (){},
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeProject'),
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer"
            ),
            Text(
              "Stopwatch"
            )
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0
          ),
          labelStyle: TextStyle(
            fontSize: 18.0
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
         timer(),
          Text(
            "Stopwatch"
          )
        ],
        controller: tb,
      ),
    );
  }
}

