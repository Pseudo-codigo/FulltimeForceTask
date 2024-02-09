part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class OnChangeRepository extends HomeEvent {
  final Repository repository;

  OnChangeRepository({required this.repository});
}