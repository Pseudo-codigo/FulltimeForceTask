part of 'home_bloc.dart';

class HomeState {
  final Repository repositoryModel;
  const HomeState({
    required this.repositoryModel,
  });

  HomeState copyWith({
    Repository? repositoryModel,
  }) {
    return HomeState(repositoryModel: repositoryModel ?? this.repositoryModel);
  }
}

class HomeInitial extends HomeState {
  HomeInitial()
      : super(repositoryModel: Repository());
}
