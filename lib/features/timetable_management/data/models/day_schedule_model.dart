import 'item_model.dart';

class DayScheduleModel {
  final String day;
  final List<ItemModel> items;

  DayScheduleModel({required this.day, required this.items});

  factory DayScheduleModel.fromJson(Map<String, dynamic> json) {
    return DayScheduleModel(
      day: json['date'],
      items: (json['lectures'] as List<dynamic>).map((item) => ItemModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }
}
