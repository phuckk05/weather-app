import 'package:flutter/material.dart';

import '../constants/ultis.dart';

class InformationNowCus extends StatelessWidget {
  final String city;
  final String temp;
  final String weatherIcon;
  InformationNowCus({
    super.key,
    required this.city,
    required this.temp,
    required this.weatherIcon,
  });

  final date = Ultis.getCurrentDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 30),
            Text(
              city,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        //date
        const SizedBox(height: 10),
        Text(date, style: TextStyle(color: Colors.white, fontSize: 16)),
        //nhiệt độ
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              temp,
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20),
            //icon mây
            Icon(
              weatherIcon == 'cloud' ? Icons.cloud : Icons.sunny,
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ],
    );
  }
}
