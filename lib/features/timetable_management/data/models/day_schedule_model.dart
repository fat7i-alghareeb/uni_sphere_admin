import 'item_model.dart';

class DayScheduleModel {
  final String day;
  final String id;
  final List<ItemModel> items;

  DayScheduleModel({required this.day, required this.id, required this.items});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      day: json['date'],
      id: json['scheduleId'],
      items: (json['lectures'] as List<dynamic>)
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
