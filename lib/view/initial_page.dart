import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/view_model/list_users.dart';

class InitialPage extends StatelessWidget {

  ListUsersViewModel listUsersViewModel = ListUsersViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: listUsersViewModel.getRandomUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Loading data...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            case ConnectionState.done:
              return buildColumn(listUsersViewModel.users!);
            case ConnectionState.none:
              return const Center(child: Text('Internet connection problems.'));
            default:
              return const Center(child: Text('Problems receiving data.'));
          }
        },
      ),
    );
  }

  Column buildColumn(List<User> users) {
    return Column(
      children: users.map((e) => Text(e.login!)).toList(),
    );
  }
}
