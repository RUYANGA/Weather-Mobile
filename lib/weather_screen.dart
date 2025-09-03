import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
 
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<void> getCurrentWeather() async {
    try {
      String cityName = "Kigali,rw";
      String apiKey =
          "5e15d903965364eff82370d77466b91d"; // replace with your actual key

      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=$apiKey",
        ),
      );
      final data = jsonDecode(response.body);
      if (data['cod']!= '200') {
        throw data['message'];        
      }

      return data;

    } catch (e) {
      throw "Unexpected Error, Try again";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 30),
            onPressed: () {
              getCurrentWeather();
            },
          ),
          SizedBox(width: 40.0),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),)),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '78  K',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.cloud, size: 64, color: Colors.blue),
                        const SizedBox(height: 8.0),
                        const Text('Rain', style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30.0),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '09:00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 49, 47, 44),
                                  ),
                                ),
                                Icon(Icons.cloud, size: 32, color: Colors.blue),
                                Text('301.17', style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 49, 47, 44),
                                  ),
                                ),
                                Icon(
                                  Icons.sunny,
                                  size: 32,
                                  color: Colors.lightGreen,
                                ),
                                Text('302.15', style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 49, 47, 44),
                                  ),
                                ),
                                Icon(
                                  Icons.sunny,
                                  size: 32,
                                  color: Colors.lightGreen,
                                ),
                                Text('302.15', style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 49, 47, 44),
                                  ),
                                ),
                                Icon(Icons.cloud, size: 32, color: Colors.blue),
                                Text('302.15', style: TextStyle(fontSize: 24)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                const Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.water_drop, size: 32, color: Colors.blue),
                        Text('Humidity', style: TextStyle(fontSize: 20)),
                        Text('78%', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.air, size: 32, color: Colors.blue),
                        Text('Wind Speed', style: TextStyle(fontSize: 20)),
                        Text('15 km/h', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.beach_access, size: 32, color: Colors.blue),
                        Text('Pressure', style: TextStyle(fontSize: 20)),
                        Text('1013 hPa', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100.0),
                const Text(
                  "Powered by Merci RUYANGA",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
