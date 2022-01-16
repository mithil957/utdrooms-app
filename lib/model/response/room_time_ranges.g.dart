// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_time_ranges.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTimeRanges _$RoomTimeRangesFromJson(Map<String, dynamic> json) =>
    RoomTimeRanges(
      json['room_location'] as String,
      (json['time_ranges'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoomTimeRangesToJson(RoomTimeRanges instance) =>
    <String, dynamic>{
      'room_location': instance.roomLocation,
      'time_ranges': instance.timeRanges,
    };
