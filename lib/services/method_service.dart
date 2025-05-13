import 'package:flutter/services.dart';
import 'package:slice_project/model/location_model.dart';

class LocationChannelService {
  static const _channel = MethodChannel('com.example.location_channel');

  static Future<void> startService() async {
    await _channel.invokeMethod("startService");
  }

  static void setupListener(Function(LocationModel) onUpdate) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onLocationUpdate') {
        final data = Map<String, dynamic>.from(call.arguments);
        final loc = LocationModel.fromMap(data);
        onUpdate(loc);
      }
    });
  }
}
