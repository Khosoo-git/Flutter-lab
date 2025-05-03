import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final apiKey = 'f7200ab3b0fe5355602956f2a9c5b404';
  final List<Map<String, String>> cities = [
    {'name': 'Улаанбаатар', 'value': 'Ulaanbaatar'},
    {'name': 'Эрдэнэт', 'value': 'Erdenet'},
    {'name': 'Дархан', 'value': 'Darkhan'},
    {'name': 'Даланзадгад', 'value': 'Dalanzadgad'},
    {'name': 'Чойбалсан', 'value': 'Choibalsan'},
    {'name': 'Ховд', 'value': 'Khovd'},
  ];

  final Map<String, dynamic> weatherDataMap = {};

  @override
  void initState() {
    super.initState();
    for (var city in cities) {
      fetchWeather(city['value']!);
    }
  }

  Future<void> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final timestamp = jsonData['dt'];
        final observationTime = DateTime.fromMillisecondsSinceEpoch(
          timestamp * 1000,
        );
        final formattedTime = DateFormat('E HH:mm').format(observationTime);
        setState(() {
          weatherDataMap[city] = {
            'temp': jsonData['main']['temp'],
            'description': jsonData['weather'][0]['main'],
            'icon': _getWeatherIcon(jsonData['weather'][0]['icon']),
            'wind': jsonData['wind']['speed'],
            'time': formattedTime,
          };
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  IconData _getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '02n':
        return WeatherIcons.night_cloudy;
      case '03d':
      case '03n':
        return WeatherIcons.cloud;
      case '04d':
      case '04n':
        return WeatherIcons.cloudy;
      case '09d':
      case '09n':
        return WeatherIcons.showers;
      case '10d':
      case '10n':
        return WeatherIcons.rain;
      case '11d':
      case '11n':
        return WeatherIcons.thunderstorm;
      case '13d':
      case '13n':
        return WeatherIcons.snow;
      case '50d':
      case '50n':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }

  Color getCardColor(String description) {
    switch (description.toLowerCase()) {
      case 'clear':
        return Colors.orangeAccent;
      case 'rain':
        return Colors.blueAccent;
      case 'clouds':
        return Colors.deepPurpleAccent;
      case 'snow':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("WEATHER FORECAST APP"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body:
          weatherDataMap.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children:
                      cities.map((city) {
                        final data = weatherDataMap[city['value']];
                        if (data == null) {
                          return const SizedBox();
                        }
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: getCardColor(data['description']),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                city['name']!,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['time'],
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${data['temp'].toStringAsFixed(1)}°',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(data['icon'], size: 50, color: Colors.white),
                              Text(
                                data['description'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text('Wind: ${data['wind']} km/h'),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
    );
  }
}
