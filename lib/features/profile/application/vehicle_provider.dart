import 'package:flutter/material.dart';
import 'package:parking_app/features/profile/domain/vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  VehicleModel _currentVehicle = VehicleModel('', '', '', '', '', '', '');

  VehicleModel get vehicle => _currentVehicle;
}
