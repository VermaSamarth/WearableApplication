import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Monitoring App',
      theme: ThemeData(
        primaryColor: Colors.teal,
        hintColor: Colors.orangeAccent,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.teal[800]),
        ),
      ),
      home: MonitoringDashboardPage(),
    );
  }
}

class MonitoringDashboardPage extends StatefulWidget {
  @override
  _MonitoringDashboardPageState createState() =>
      _MonitoringDashboardPageState();
}

class _MonitoringDashboardPageState extends State<MonitoringDashboardPage> {
  bool isOn = false;
  double bodyTemperature = 36.5;
  double ambientTemperature = 25.0;
  int heartRate = 75;
  final double temperatureThreshold = 38.0;

  void togglePower() {
    setState(() {
      isOn = !isOn;
    });
  }

  void checkTemperatureAlert() {
    if (bodyTemperature > temperatureThreshold) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),
          content: Text(
            'Body temperature exceeds threshold!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Health Monitoring Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      'Device is ${isOn ? 'ON' : 'OFF'}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isOn ? Colors.green : Colors.red,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: togglePower,
                      icon: Icon(isOn ? Icons.power_off : Icons.power),
                      label: Text(
                        isOn ? 'Turn OFF' : 'Turn ON',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOn ? Colors.redAccent : Colors.teal,
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            MonitoringCard(
              title: 'Body Temperature',
              value: '${bodyTemperature.toStringAsFixed(1)} °C',
              icon: Icons.thermostat_outlined,
            ),
            SizedBox(height: 24),
            MonitoringCard(
              title: 'Ambient Temperature',
              value: '${ambientTemperature.toStringAsFixed(1)} °C',
              icon: Icons.device_thermostat,
            ),
            SizedBox(height: 24),
            MonitoringCard(
              title: 'Heart Rate',
              value: '$heartRate BPM',
              icon: Icons.favorite_border,
            ),
          ],
        ),
      ),
    );
  }
}

class MonitoringCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  MonitoringCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  _MonitoringCardState createState() => _MonitoringCardState();
}

class _MonitoringCardState extends State<MonitoringCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(widget.icon, size: 30, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
