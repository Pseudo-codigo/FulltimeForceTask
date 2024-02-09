import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/pages/home/bloc/home_bloc.dart';
import 'package:fulltime_force_task/src/shared/routes/routes.dart';
import 'package:fulltime_force_task/src/shared/widgets/loading.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    bloc.getRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fulltime Force Task"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: ((context, state) {
          if (state.repositoryModel.id == 0) {
            return const Loading();
          }
          return EasyRefresh.builder(
            header: const MaterialHeader(),
            footer: const NotLoadFooter(),
            onRefresh: () async {
              bloc.getRepository();
              return IndicatorResult.success;
            },
            onLoad: () async {},
            childBuilder: (context, physics) {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(state
                                                        .repositoryModel
                                                        .owner
                                                        ?.avatarUrl ??
                                                    'https://icon-library.com/images/generic-user-icon/generic-user-icon-9.jpg')),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  state.repositoryModel.owner?.login ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 80,
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        rowItem(
                                            context: context,
                                            name: state.repositoryModel.name,
                                            value: AppLocalizations.of(context)!
                                                .homeRepository),
                                      ]),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton.extended(
                                      heroTag: 'branches',
                                      onPressed: () {},
                                      elevation: 1,
                                      label: Text(AppLocalizations.of(context)!
                                          .homeBranch),
                                      icon: const Icon(Icons.commit),
                                    ),
                                    const SizedBox(width: 16.0),
                                    FloatingActionButton.extended(
                                      heroTag: 'settings',
                                      onPressed: () {
                                        context.pushNamed(Routes.settings);
                                      },
                                      elevation: 1,
                                      backgroundColor: Colors.red,
                                      label: Text(AppLocalizations.of(context)!
                                          .settingsTitle),
                                      icon: const Icon(Icons.settings),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 80,
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        rowItem(
                                            context: context,
                                            name: state.repositoryModel.openIssuesCount.toString(),
                                            value: AppLocalizations.of(context)!
                                                .homeIssues),
                                        rowItem(
                                            context: context,
                                            name: state.repositoryModel.defaultBranch,
                                            value: AppLocalizations.of(context)!
                                                .homeDefault,
                                            separator: true),
                                        rowItem(
                                            context: context,
                                            name: state.repositoryModel.stargazersCount.toString(),
                                            value: AppLocalizations.of(context)!
                                                .homeStars,
                                            separator: true),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  Widget rowItem({
    required BuildContext context,
    String name = "",
    String value = "",
    bool separator = false,
  }) {
    return Expanded(
        child: Row(
      children: [
        if (separator) const VerticalDivider(),
        Expanded(child: _singleItem(context, name, value)),
      ],
    ));
  }

  Widget _singleItem(BuildContext context, String name, String value) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            softWrap: true,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      );
}
