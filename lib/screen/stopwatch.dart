import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

String formatTime(int milisec) {
  var secs = milisec ~/ 1000;
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  var milisecs = ((milisec % 1000) ~/ 10).toString().padLeft(2, '0');
  return "$minutes:$seconds:$milisecs";
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch;
  Timer _timer;

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {});
  }

  void handleReset() {
    _stopwatch.reset();
    _stopwatch.stop();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(fontSize: 84.0, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: handleStartStop,
                    child: Text(
                      _stopwatch.isRunning ? 'Stop' : 'Start',
                      style: TextStyle(fontSize: 30.0),
                    )),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: handleReset,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 30.0),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
