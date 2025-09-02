import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
              // Handle refresh action
            },
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 15,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '300.67 °K',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(Icons.cloud, size: 64, color: Colors.blue),
                    SizedBox(height: 8.0),
                    Text('Rain', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weather Forecast",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30.0),
            SingleChildScrollView(
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
                            Text('09:00', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange)),
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
                      elevation: 3 ,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('12:00', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange)),
                            Icon(Icons.cloud, size: 32, color: Colors.blue),
                            Text('302.15', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 3 ,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('12:00', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange)),
                            Icon(Icons.cloud, size: 32, color: Colors.blue),
                            Text('302.15', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Card(
                      elevation: 3 ,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('12:00', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange)),
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
            SizedBox(height: 30.0),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text("Additional Information",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)) ,
            SizedBox(height: 30.0),
            Row(
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
            SizedBox(height: 150.0),
            Text("Powered by Merci RUYANGA",style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
