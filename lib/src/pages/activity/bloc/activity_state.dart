part of 'activity_bloc.dart';

class ActivityState {
  final List<ActivityModel> listActivity;
  const ActivityState({
    required this.listActivity,
  });

  ActivityState copyWith({
    List<ActivityModel>? listActivity,
  }) {
    return ActivityState(listActivity: listActivity ?? this.listActivity);
  }
}

class ActivityInitial extends ActivityState {
  ActivityInitial() : super(listActivity: []);
}
