import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Code Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('scrumptious.dev/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() => _batteryLevel = batteryLevel);
    } on PlatformException catch (_) {
      setState(() => _batteryLevel = null);
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code Practice')
      ),
      body: Center(
        child: Text('Battery Level: $_batteryLevel')
      )
    );
  }
}
