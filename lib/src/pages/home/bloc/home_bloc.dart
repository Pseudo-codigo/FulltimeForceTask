import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_date/dart_date.dart';
import 'package:github/github.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<OnChangeRepository>((event, emit) {
      emit(state.copyWith(repositoryModel: event.repository));
    });
  }

  Future<void> getRepository() async {
    // final result = await Amplify.Auth.fetchAuthSession();

    var git = GitHub();
    Repository repo = await git.repositories
        .getRepository(RepositorySlug("Pseudo-codigo", "FulltimeForceTask"));

    add(OnChangeRepository(repository: repo));
  }
}
