import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fulltime_force_task/src/pages/activity/bloc/activity_bloc.dart';
import 'package:fulltime_force_task/src/pages/branches/bloc/branches_bloc.dart';
import 'package:fulltime_force_task/src/shared/utils/format_date.dart';
import 'package:fulltime_force_task/src/shared/widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fulltime_force_task/src/shared/widgets/row_item.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ActivityBloc>()..getList();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeActivity),
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: ((context, state) {
          if (state.listActivity.isEmpty) {
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
                var list = state.listActivity;
                return ListView.builder(
                  // Providing a restorationId allows the ListView to restore the
                  // scroll position when a user leaves and returns to the app after it
                  // has been killed while running in the background.
                  physics: physics,
                  restorationId: 'branchesListView',
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = list[index];

                    return ListTile(
                      title: Text(
                        getDate(item.timestamp!,
                            AppLocalizations.of(context)!.localeName),
                      ),
                      trailing: Text(
                        bloc.getName(
                            item.activityType!, AppLocalizations.of(context)),
                        style:
                            TextStyle(color: bloc.getColor(item.activityType!), fontSize: 12),
                      ),
                    );
                  },
                );
              });
        }),
      ),
    );
  }
}
