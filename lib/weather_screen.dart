import 'dart:convert';
//import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> _weatherFuture;
  final TextEditingController _searchController = TextEditingController();
  String _cityName = "Kigali";
  @override
  void initState() {
    super.initState();
    _weatherFuture = getCurrentWeather(_cityName);
  }

  Future<Map<String, dynamic>> getCurrentWeather(String cityName) async {
    try {
      String apiKey = "5e15d903965364eff82370d77466b91d";
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,rw&units=metric&appid=$apiKey",
        ),
      );
      final data = jsonDecode(response.body);
      if (data['cod'] != '200') {
        throw "City '$cityName' not found or unavailable. API message: ${data['message']}";
      }
      final current = data['list'][0];
      final main = current['main'];
      final weather = current['weather'][0];
      final wind = current['wind'];
      return {
        'temp': main['temp'],
        'humidity': main['humidity'],
        'pressure': main['pressure'],
        'weather': weather['main'],
        'description': weather['description'],
        'icon': weather['icon'],
        'wind_speed': wind['speed'],
        'forecast': data['list'],
        'location': data['city']['name'],
        'country': data['city']['country'],
      };
    } catch (e) {
      throw "Error fetching weather, Exit app and try again";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,

        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 30),
            onPressed: () {
              setState(() {
                _weatherFuture = getCurrentWeather(_cityName);
              });
            },
          ),
          SizedBox(width: 40.0),
        ],
      ),
      body: FutureBuilder(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            );
          }
          final weather = snapshot.data;
          if (weather == null) {
            return Center(child: Text("No data available"));
          }
          List<dynamic> forecast = weather['forecast'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search city...",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: const Color.fromARGB(255, 151, 164, 187),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.blueAccent),
                        onPressed: () {
                          final value = _searchController.text.trim();
                          if (value.isNotEmpty) {
                            setState(() {
                              _cityName = value;
                              _weatherFuture = getCurrentWeather(_cityName);
                            });
                          }
                        },
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 241, 245, 249),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 74, 83, 94),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 223, 227, 230),
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        setState(() {
                          _cityName = value.trim();
                          _weatherFuture = getCurrentWeather(_cityName);
                        });
                      }
                    },
                  ),
                  if (weather['location'] != null && weather['country'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        '${weather['location']}, ${weather['country']}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 15,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Now   ${weather['temp']} °C',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            weather['weather'] == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            size: 64,
                            color: weather['weather'] == 'Rain'
                                ? Colors.blue
                                : Colors.orange,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            weather['weather'],
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            weather['description'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Weather Forecast",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: forecast.take(5).map<Widget>((item) {
                        final dt = item['dt_txt'];
                        final dateTime = DateTime.parse(dt);
                        final time = DateFormat('hh:mm a').format(dateTime);
                        final temp = item['main']['temp'];
                        final mainWeather = item['weather'][0]['main'];
                        return SizedBox(
                          width: 150,
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 49, 47, 44),
                                    ),
                                  ),
                                  Icon(
                                    mainWeather == 'Rain'
                                        ? Icons.cloud
                                        : Icons.sunny,
                                    size: 32,
                                    color: mainWeather == 'Rain'
                                        ? Colors.blue
                                        : Colors.orange,
                                  ),
                                  Text(
                                    '$temp °C',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  const Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.water_drop, size: 32, color: Colors.blue),
                          Text('Humidity', style: TextStyle(fontSize: 20)),
                          Text(
                            '${weather['humidity']}%',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.air, size: 32, color: Colors.blue),
                          Text('Wind Speed', style: TextStyle(fontSize: 20)),
                          Text(
                            '${weather['wind_speed']} m/s',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.beach_access,
                            size: 32,
                            color: Colors.blue,
                          ),
                          Text('Pressure', style: TextStyle(fontSize: 20)),
                          Text(
                            '${weather['pressure']} hPa',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0),
                  const Text(
                    "Powered by Merci RUYANGA",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
