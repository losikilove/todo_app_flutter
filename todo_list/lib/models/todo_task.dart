class TodoTask {
  static int _countId = 0;
  final int id;
  final String title;
  final DateTime duration;

  TodoTask(title, duration)
      : title = title,
        duration = duration,
        id = _countId++;

  String get showDate =>
      '${duration.year}/${duration.month.toString().padLeft(2, '0')}/${duration.day.toString().padLeft(2, '0')}';

  String get showTime =>
      '${duration.hour.toString().padLeft(2, '0')}:${duration.minute.toString().padLeft(2, '0')}';

  String get showDuration =>
      '${duration.year}/${duration.month.toString().padLeft(2, '0')}/${duration.day.toString().padLeft(2, '0')} ${duration.hour.toString().padLeft(2, '0')}:${duration.minute.toString().padLeft(2, '0')}';
}
