// 📦 Package imports:
import 'package:equatable/equatable.dart';

class DropDownData extends Equatable {
  final String? name;
  final String? id;

  const DropDownData({
    required this.name,
    required this.id,
  });

  factory DropDownData.fromNameAndId(Map<String, dynamic> json) {
    return DropDownData(name: json["name"], id: json["id"]);
  }
  @override
  List<Object?> get props => [name, id];
}
