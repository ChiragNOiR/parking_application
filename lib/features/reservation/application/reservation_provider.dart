import 'package:flutter/material.dart';
import 'package:parking_app/features/reservation/domain/reservation_model.dart';

class ReservationProvider extends ChangeNotifier {
  ReservationModel _currentReservation =
      ReservationModel('', '', '', '', '', '', '', '', '');

  ReservationModel get reserve => _currentReservation;

  void setReservation(ReservationModel reserve) {
    _currentReservation = reserve;
    notifyListeners();
  }

  setStartTime(String startTime) {
    _currentReservation.start = startTime;
    notifyListeners();
  }

  setEndTime(String endTime) {
    _currentReservation.end = endTime;
    notifyListeners();
  }
}
