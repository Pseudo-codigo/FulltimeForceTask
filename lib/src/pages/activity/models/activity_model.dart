import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class ActivityModel {
  final int? id;
  @JsonKey(name: "activity_type")
  final String? activityType;
  final DateTime? timestamp;

  ActivityModel({
    this.id,
    this.activityType,
    this.timestamp,
  });

  ActivityModel copyWith({
    int? id,
    String? activityType,
    DateTime? timestamp,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
