part of 'commits_bloc.dart';

@immutable
abstract class CommitsEvent {}

class OnChangeList extends CommitsEvent {
  final List<RepositoryCommit> listCommit;

  OnChangeList({required this.listCommit});
}
