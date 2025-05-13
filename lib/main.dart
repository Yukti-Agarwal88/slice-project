import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slice_project/controller/location_bloc.dart';
import 'package:slice_project/controller/location_controller.dart';
import 'package:slice_project/services/location_database.dart';
import 'package:slice_project/services/method_service.dart';
import 'package:slice_project/views/location_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = LocationDatabase();
  final lastLocation = await db.getLastLocation();

  final bloc = LocationBloc(db);
  final controller = Get.put(LocationController());

  if (lastLocation != null) controller.currentLocation.value = lastLocation;

  LocationChannelService.setupListener((location) {
    controller.currentLocation.value = location;
    bloc.add(LocationEvent(location));
  });

  await LocationChannelService.startService();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: LocationScreen());
  }
}
