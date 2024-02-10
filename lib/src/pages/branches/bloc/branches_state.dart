part of 'branches_bloc.dart';

class BranchesState {
  final List<Branch> listBranch;
  const BranchesState({
    required this.listBranch,
  });

  BranchesState copyWith({
    List<Branch>? listBranch,
  }) {
    return BranchesState(listBranch: listBranch ?? this.listBranch);
  }
}

class BranchesInitial extends BranchesState {
  BranchesInitial() : super(listBranch: []);
}
