import 'package:flutter/material.dart';

class TimetableProvider extends ChangeNotifier {
  int? _selectedYear;
  int _selectedDayIndex = 0;
  bool _isCreatingSchedule = false;
  DateTime? _selectedScheduleDate;
  List<dynamic> _currentDays = [];

  // Getters
  int? get selectedYear => _selectedYear;
  int get selectedDayIndex => _selectedDayIndex;
  bool get isCreatingSchedule => _isCreatingSchedule;
  DateTime? get selectedScheduleDate => _selectedScheduleDate;
  List<dynamic> get currentDays => _currentDays;
  dynamic get selectedDay =>
      _currentDays.isNotEmpty && _selectedDayIndex < _currentDays.length
          ? _currentDays[_selectedDayIndex]
          : null;

  // Setters
  void setSelectedYear(int? year) {
    _selectedYear = year;
    notifyListeners();
  }

  void setSelectedDayIndex(int index) {
    if (index >= 0 && index < _currentDays.length) {
      _selectedDayIndex = index;
      notifyListeners();
    }
  }

  void setIsCreatingSchedule(bool value) {
    _isCreatingSchedule = value;
    notifyListeners();
  }

  void setSelectedScheduleDate(DateTime? date) {
    _selectedScheduleDate = date;
    notifyListeners();
  }

  void setCurrentDays(List<dynamic> days) {
    _currentDays = days;
    // Reset selected day index if it's out of bounds
    if (_selectedDayIndex >= days.length) {
      _selectedDayIndex = 0;
    }
    notifyListeners();
  }

  void resetDaySelection() {
    _selectedDayIndex = 0;
    notifyListeners();
  }

  void clearState() {
    _selectedYear = null;
    _selectedDayIndex = 0;
    _isCreatingSchedule = false;
    _selectedScheduleDate = null;
    _currentDays = [];
    notifyListeners();
  }
}
