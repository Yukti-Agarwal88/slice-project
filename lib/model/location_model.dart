class LocationModel {
  final double latitude;
  final double longitude;
  final int timestamp;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
    'timestamp': timestamp,
  };

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: map['timestamp'],
    );
  }
}
