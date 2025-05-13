import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/location_controller.dart';

class LocationScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Location")),
      body: Obx(() {
        final loc = controller.currentLocation.value;
        return Center(
          child:
              loc == null
                  ? Text("Fetching location...")
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Latitude: ${loc.latitude}"),
                      Text("Longitude: ${loc.longitude}"),
                      Text(
                        "Timestamp: ${DateTime.fromMillisecondsSinceEpoch(loc.timestamp)}",
                      ),
                    ],
                  ),
        );
      }),
    );
  }
}
