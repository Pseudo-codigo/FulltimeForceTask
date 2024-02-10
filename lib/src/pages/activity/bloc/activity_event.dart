part of 'activity_bloc.dart';

@immutable
abstract class ActivityEvent {}

class OnChangeList extends ActivityEvent {
  final List<ActivityModel> listActivity;

  OnChangeList({required this.listActivity});
}
