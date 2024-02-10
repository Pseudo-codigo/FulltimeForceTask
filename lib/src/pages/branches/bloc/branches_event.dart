part of 'branches_bloc.dart';

@immutable
abstract class BranchesEvent {}

class OnChangeList extends BranchesEvent {
  final List<Branch> listBranch;

  OnChangeList({required this.listBranch});
}
