import 'package:flutter/material.dart';
import 'package:report_app/bloc/issue_bloc.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/model/account_public.dart';
import 'package:report_app/model/issue.dart';
import 'package:report_app/page/items/item_issue.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({Key? key}) : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  late IssueBloc bloc;

  @override
  void initState() {
    bloc = IssueBloc(context);
    bloc.getIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Issue Page',
      ),
      body: buildList(),
    );
  }

  Widget buildList() {

    return StreamBuilder<List<Issue>>(
      stream: bloc.streamListIssue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final issues = snapshot.data ?? [];
          print('_IssuePageState.buildList: ${issues.length}');
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              if (index == issues.length - 1) {
                bloc.getIssues();
              }

              final issue = issues[index];

              return ItemIssue(
                issue: issue,
                accountPublic: AccountPublic(),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: issues.length,
          );
        }
        return Container();
      },
    );
  }
}
