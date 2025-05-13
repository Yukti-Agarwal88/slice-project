import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slice_project/model/location_model.dart';
import 'package:slice_project/services/location_database.dart';

class LocationState {
  final LocationModel? location;
  LocationState(this.location);
}

class LocationEvent {
  final LocationModel location;
  LocationEvent(this.location);
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationDatabase db;

  LocationBloc(this.db) : super(LocationState(null)) {
    on<LocationEvent>((event, emit) async {
      await db.insertLocation(event.location);
      emit(LocationState(event.location));
    });
  }
}
