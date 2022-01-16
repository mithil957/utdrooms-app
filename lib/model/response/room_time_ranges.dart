import 'package:json_annotation/json_annotation.dart';

part 'room_time_ranges.g.dart';

@JsonSerializable()
class RoomTimeRanges {

  @JsonKey(name: 'room_location')
  String roomLocation;

  @JsonKey(name: 'time_ranges')
  List<String> timeRanges;

  RoomTimeRanges(this.roomLocation, this.timeRanges);

  factory RoomTimeRanges.fromJson(Map<String, dynamic> json) => _$RoomTimeRangesFromJson(json);

  @override
  String toString() {
    return "($roomLocation : $timeRanges)";
  }
}