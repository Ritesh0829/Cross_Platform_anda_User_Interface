import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CityListScreen(),
    );
  }
}

class CityListScreen extends StatelessWidget {
  final List<String> cities = [
    'New York',
    'London',
    'Tokyo',
    'Sydney',
    'Paris',
  ];

  const CityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(cities[index]),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WeatherDetailScreen(city: cities[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WeatherDetailScreen extends StatefulWidget {
  final String city;

  const WeatherDetailScreen({super.key, required this.city});

  @override
  _WeatherDetailScreenState createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city)),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Weather in ${widget.city}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.wb_sunny,
                      size: 40,
                      color: Colors.orange,
                    ),
                    title: Text('Sunny'),
                    subtitle: Text('25°C'),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.thermostat_outlined,
                      size: 40,
                      color: Colors.red,
                    ),
                    title: Text('Humidity'),
                    subtitle: Text('60%'),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.air, size: 40, color: Colors.blue),
                    title: Text('Wind'),
                    subtitle: Text('15 km/h'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
