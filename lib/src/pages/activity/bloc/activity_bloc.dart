import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fulltime_force_task/src/pages/activity/models/activity_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<OnChangeList>((event, emit) {
      emit(state.copyWith(listActivity: event.listActivity));
    });
  }

  Future<void> getList() async {
    final response = await http.get(Uri.parse(
        'https://api.github.com/repos/pseudo-codigo/FulltimeForceTask/activity'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body) as List;

      List<ActivityModel> list = data
          .map((activityData) => ActivityModel.fromJson(activityData))
          .toList();

      add(OnChangeList(listActivity: list));
    } else {
      add(OnChangeList(listActivity: const []));
    }
  }

  String getName(String type, AppLocalizations? localizations) {
    var name = '';

    switch (type) {
      case 'push':
        name = localizations!.activityPush;
        break;
      case 'force_push':
        name = localizations!.activityForcePush;
        break;
      case 'branch_creation':
        name = localizations!.activityBranchCreation;
        break;
      case 'branch_deletion':
        name = localizations!.activityBranchDeletion;
        break;
      case 'pr_merge':
        name = localizations!.activityMerge;
        break;
      case 'merge_queue_merge':
        name = localizations!.activityQueueMerge;
        break;
      default:
    }
    return name;
  }

  Color getColor(String type) {
    Color name = Colors.black26;

    switch (type) {
      case 'push':
        name = Colors.blue;
        break;
      case 'force_push':
        name = Colors.purple;
        break;
      case 'branch_creation':
        name = Colors.green;
        break;
      case 'branch_deletion':
        name = Colors.red;
        break;
      case 'pr_merge':
        name = Colors.yellow.shade700;
        break;
      case 'merge_queue_merge':
        name = Colors.orange;
        break;
      default:
    }
    return name;
  }
}
