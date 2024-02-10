part of 'commits_bloc.dart';

class CommitsState {
  final List<RepositoryCommit> listCommit;
  const CommitsState({
    required this.listCommit,
  });

  CommitsState copyWith({
    List<RepositoryCommit>? listCommit,
  }) {
    return CommitsState(listCommit: listCommit ?? this.listCommit);
  }
}

class CommitsInitial extends CommitsState {
  CommitsInitial() : super(listCommit: []);
}
