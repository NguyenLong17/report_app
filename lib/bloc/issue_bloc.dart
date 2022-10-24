import 'dart:async';
import 'package:flutter/material.dart';
import 'package:report_app/common/widgets/progress_dialog.dart';
import 'package:report_app/model/issue.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/issue_service.dart';

class IssueBloc {
  final _listIssueStreamController = StreamController<List<Issue>>();
  final _issueStreamController = StreamController<Issue>();

  Stream<List<Issue>> get streamListIssue => _listIssueStreamController.stream;

  Stream<Issue> get streamIssue => _issueStreamController.stream;

  final issues = <Issue>[];
  final BuildContext context;
  Issue? issue;

  IssueBloc(this.context) {
    // getIssues();
  }

  Future<void> getIssues({bool isClear = false}) async {
    final progressDialog = ProgressDialog(context);

    progressDialog.show();

    await Future.delayed(const Duration(seconds: 2));
    await apiService
        .getIssue(offset: isClear ? 0 : issues.length)
        .then((value) {
      if (isClear) {
        issues.clear();
      }
      if (value.isNotEmpty) {
        issues.addAll(value);
        _listIssueStreamController.add(issues);
      } else if (isClear) {
        _listIssueStreamController.add(issues);
      }
      progressDialog.hide();
    }).catchError((e) {
      progressDialog.hide();

      _listIssueStreamController.addError(e.toString());
    });
  }

  Future<void> reportIssue({
    required Issue issue,
  }) async {
    apiService
        .reportIssue(
          title: issue.title ?? '',
          content: issue.content ?? '',
      photos: issue.photos!.join('|') ?? '',
        )
        .then((value) {
          _issueStreamController.add(value);

          issues.add(value);
          _listIssueStreamController.add(issues);
    })
        .catchError((e) {
      _issueStreamController.addError(e.toString());
    });
  }
}
