class CreateSchedule {
  final int year;
  final String scheduleDate;

  CreateSchedule({
    required this.year,
    required this.scheduleDate,
  });

  factory CreateSchedule.fromJson(Map<String, dynamic> json) {
    return CreateSchedule(
      year: json['year'],
      scheduleDate: json['scheduleDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'year': year,
        'scheduleDate': scheduleDate,
      };
}
