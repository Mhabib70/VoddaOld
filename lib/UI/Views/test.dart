import 'dart:async';

import 'package:flutter/material.dart';


class AttendanceScreen extends StatefulWidget {
  AttendanceScreen();

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  static var countdownDuration1 = Duration(minutes: 10);
  Duration duration1 = Duration();
  Timer? timer1;

  @override
  void initState() {
    var hours1;
    var mints1;
    var secs1;
    hours1 = int.parse("10");
    mints1 = int.parse("00");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(hours: hours1, minutes: mints1, seconds: secs1);
    startTimer1();
    reset1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Timer Example"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              _onWillPop();
            },
          ),
        ),
        body: Container(
          color: Colors.black12,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Timer",
                  style: TextStyle(fontSize: 25),
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "Count down timer",
                  style: TextStyle(fontSize: 25),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    child: buildTime1()),
              ]),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final isRunning = timer1 == null ? false : timer1!.isActive;
    if (isRunning) {
      timer1!.cancel();
    }
    Navigator.of(context, rootNavigator: true).pop(context);
    return true;
  }



  void reset1() {
      setState(() => duration1 = countdownDuration1);

  }



  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }



  void addTime1() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration1.inSeconds - addSeconds;
      if (seconds < 0) {
        timer1?.cancel();
      } else {
        duration1 = Duration(seconds: seconds);
      }
    });
  }



  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );
}