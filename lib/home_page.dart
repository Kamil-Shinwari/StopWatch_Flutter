import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int second = 0;
  int minute = 0;
  int Hours = 0;
  String digitseconds = "00";
  String digitMinute = "00";
  String digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  // creating the stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // creating reset function

  void reset() {
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      Hours = 0;
      digitseconds = "00";
      digitMinute = "00";
      digitHours = "00";
      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHours$digitMinute$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsecond = second + 1;
      int localMinute = minute;
      int localHours = Hours;
      if (localsecond > 59) {
        if (localMinute > 59) {
          localHours++;
          localMinute = 0;
        } else {
          localMinute++;
          localsecond=0;
        }
       
      }
      
      setState(() {
        second = localsecond;
        minute = localMinute;
        Hours = localHours;
        digitseconds = (second >= 10) ? "$second" : "$second";
        digitMinute = (minute >= 10) ? "$minute" : "$minute";
        digitHours = (Hours >= 10) ? "$Hours" : "$Hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            
              child: Container(
                height: MediaQuery.of(context).size.height *0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "StopWatch App",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "$digitHours:$digitMinute:$digitseconds",
                        style: TextStyle(color: Colors.white, fontSize: 80),
                      ),
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff323f68)),
                      child: ListView.builder(
                        itemCount: laps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lap n{$index+1}",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                ),
                        
                                Text(
                                  "Lap n${laps[index]}",
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                ),
                        
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: RawMaterialButton(
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {
                                (!started)?start():stop();
                              },
                              child: Text(
                                (!started)?"start":"stop",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () {
                              addLaps();
                             
                            },
                            icon: Icon(
                              Icons.flag,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: RawMaterialButton(
                            fillColor: Colors.blue,
                            shape:
                                StadiumBorder(side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              reset();
                            },
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
