import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fulltime_force_task/src/pages/commits/bloc/commits_bloc.dart';
import 'package:fulltime_force_task/src/shared/utils/format_date.dart';
import 'package:fulltime_force_task/src/shared/widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/shared/widgets/row_item.dart';

class Commits extends StatelessWidget {
  const Commits({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CommitsBloc>()..getList();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeCommits),
      ),
      body: BlocBuilder<CommitsBloc, CommitsState>(
        builder: ((context, state) {
          if (state.listCommit.isEmpty) {
            return const Loading();
          }
          return EasyRefresh.builder(
              header: const MaterialHeader(),
              footer: const NotLoadFooter(),
              onRefresh: () async {
                bloc.getList();
                return IndicatorResult.success;
              },
              onLoad: () async {},
              childBuilder: (context, physics) {
                var list = state.listCommit;
                return ListView.builder(
                  // Providing a restorationId allows the ListView to restore the
                  // scroll position when a user leaves and returns to the app after it
                  // has been killed while running in the background.
                  physics: physics,
                  restorationId: 'branchesListView',
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = list[index];

                    return ExpansionTile(
                      // onExpansionChanged: (value) =>
                      //     bloc.getCommit(item.name!, value),
                      title: Text(
                        getDate(item.commit!.author!.date!,
                            AppLocalizations.of(context)?.localeName),
                      ),
                      children: [
                        Builder(
                          builder: (context) {
                            if (item.commit?.author == null) {
                              return Center(
                                child: SpinKitCircle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              );
                            }
                            return Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 400),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RowItem(
                                              name: item.commit!.author!.name!,
                                              value:
                                                  AppLocalizations.of(context)!
                                                      .branchCommitAuthor),
                                          RowItem(
                                              name:
                                                  item.commit!.committer!.name!,
                                              value:
                                                  AppLocalizations.of(context)!
                                                      .branchCommitCommiter),
                                        ]),
                                    const SizedBox(height: 16),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RowItem(
                                              name: item.commit!.message!,
                                              value:
                                                  AppLocalizations.of(context)!
                                                      .branchCommitMessage),
                                        ]),
                                  ],
                                ));
                          },
                        ),
                      ],
                    );
                  },
                );
              });
        }),
      ),
    );
  }
}
