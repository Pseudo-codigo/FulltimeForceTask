import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/github.dart';

part 'commits_event.dart';
part 'commits_state.dart';

class CommitsBloc extends Bloc<CommitsEvent, CommitsState> {
  CommitsBloc() : super(CommitsInitial()) {
    on<OnChangeList>((event, emit) {
      emit(state.copyWith(listCommit: event.listCommit));
    });
  }

  Future<void> getList() async {
    var git = GitHub();
    List<RepositoryCommit> listCommit = await (git.repositories
            .listCommits(RepositorySlug("Pseudo-codigo", "FulltimeForceTask")))
        .toList();

    add(OnChangeList(listCommit: listCommit));
  }
}
