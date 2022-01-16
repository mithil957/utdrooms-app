import 'package:json_annotation/json_annotation.dart';

part 'class_info.g.dart';

@JsonSerializable()
class ClassInfo {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'start')
  String startTime;

  @JsonKey(name: 'end')
  String endTime;

  ClassInfo(this.title, this.startTime, this.endTime);

  factory ClassInfo.fromJson(Map<String, dynamic> json) => _$ClassInfoFromJson(json);

  @override
  String toString() {
    return "(title: $title, startTime: $startTime, endTime: $endTime)";
  }
}