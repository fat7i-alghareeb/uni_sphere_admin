class NotificationsManagementEntity {
  final String id;
  final String title;
  final String body;
  final String targetType; // 'global', 'department', 'year', 'subject'
  final String? targetId;
  NotificationsManagementEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.targetType,
    this.targetId,
  });
}
