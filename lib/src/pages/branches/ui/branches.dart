import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fulltime_force_task/src/pages/branches/bloc/branches_bloc.dart';
import 'package:fulltime_force_task/src/shared/utils/format_date.dart';
import 'package:fulltime_force_task/src/shared/widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/shared/widgets/row_item.dart';

class Branches extends StatelessWidget {
  const Branches({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BranchesBloc>()..getList();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeBranch),
      ),
      body: BlocBuilder<BranchesBloc, BranchesState>(
        builder: ((context, state) {
          if (state.listBranch.isEmpty) {
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
                var list = state.listBranch;
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
                      onExpansionChanged: (value) =>
                          bloc.getBranch(item.name!, value),
                      title: Text(
                        item.name ?? "",
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
                                              name: item.commit!.commit!.author!
                                                  .name!,
                                              value:
                                                  AppLocalizations.of(context)!
                                                      .branchCommitAuthor),
                                          RowItem(
                                              name: getDate(
                                                  item.commit!.commit!.author!
                                                      .date!,
                                                  AppLocalizations.of(context)
                                                      ?.localeName),
                                              value:
                                                  AppLocalizations.of(context)!
                                                      .branchCommitDate),
                                        ]),
                                    const SizedBox(height: 16),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RowItem(
                                              name:
                                                  item.commit!.commit!.message!,
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
