import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiAirQuality extends StatefulWidget {
  const ApiAirQuality({super.key});

  @override
  State<ApiAirQuality> createState() => _ApiAirQualityState();
}

class _ApiAirQualityState extends State<ApiAirQuality> {
  Map<String, dynamic>? info;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.waqi.info/feed/here/?token=402e83c9e5f1e8f976e885a80b500e96ba71bbd3'));
      if (response.statusCode == 200) {
        setState(() {
          info = jsonDecode(response.body);
          print(info);
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality Index (AQI)'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 165, 193),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Color.fromARGB(255, 56, 47, 47),
        ),
      ),
      body: 
      Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 250, 235, 220),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    "${info?['data']['city']['name']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      backgroundColor: Color.fromARGB(255, 219, 230, 255),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 181, 181),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${info?['data']['iaqi']['pm25']['v']}",
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 56, 47, 47),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${getAqiScale(info?['data']['iaqi']['pm25']['v'])}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 56, 47, 47),
                      backgroundColor: Color.fromARGB(255, 255, 219, 247),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Temperature : ${info?['data']['iaqi']['t']['v']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 56, 47, 47),
                      backgroundColor: Color.fromARGB(255, 255, 219, 247),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      fetchData();
                    },
                    child: const Icon(Icons.refresh),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 181, 181),
                      iconColor: const Color.fromARGB(255, 56, 47, 47),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      )
      
    );
  }

  String getAqiScale(int aqi) {
    if (aqi <= 50) {
      return "Good";
    } else if (aqi <= 100) {
      return "Moderate";
    } else if (aqi <= 150) {
      return "Unhealthy for Sensitive Groups";
    } else if (aqi <= 200) {
      return "Unhealthy";
    } else if (aqi <= 300) {
      return "Very Unhealthy";
    } else {
      return "Hazardous";
    }
  }
}
