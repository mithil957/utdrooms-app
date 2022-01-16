class RoomTimeRangesRequest {
  final String day;
  final DateTime startTime;
  final int minimumAmountOfTime;

  RoomTimeRangesRequest(
      {required this.day,
      required this.startTime,
      required this.minimumAmountOfTime});
}
