import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltime_force_task/src/shared/utils/git_slug.dart';
import 'package:github/github.dart';

part 'branches_event.dart';
part 'branches_state.dart';

class BranchesBloc extends Bloc<BranchesEvent, BranchesState> {
  BranchesBloc() : super(BranchesInitial()) {
    on<OnChangeList>((event, emit) {
      emit(state.copyWith(listBranch: event.listBranch));
    });
  }

  Future<void> getBranch(String name, bool expanded) async {
    if (expanded) {
      var git = GitHub();
      List<Branch> list = state.listBranch;

      var index = list.indexWhere((element) => element.name == name);

      Branch branch = await git.repositories.getBranch(getSlug(), name);

      list[index] = branch;

      add(OnChangeList(listBranch: list));
    }
  }

  Future<void> getList() async {
    var git = GitHub();
    List<Branch> listBranch =
        await (git.repositories.listBranches(getSlug())).toList();

    add(OnChangeList(listBranch: listBranch));
  }
}
