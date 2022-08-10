import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/view/users/components/card_user.dart';
import 'package:github_repo_user/view_model/list_users.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class InitialPage extends StatefulWidget {

  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
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
              return buildColumnLoading();
            case ConnectionState.done:
              return buildGridViewUsers(listUsersViewModel.users!);
            case ConnectionState.none:
              return buildInforText('Internet connection problems.');
            default:
              return buildInforText('Problems receiving data.');
          }
        },
      ),
    );
  }

  Center buildInforText(String text) => const Center(child: Text('Internet connection problems.'));

  MasonryGridView buildGridViewUsers(List<User> users) {
    return MasonryGridView.count(
              // controller: _scrollController,
              itemCount: users.length,
              crossAxisCount: 2,
              itemBuilder: (_, index) {
                User user = users[index];
                return CardUser(user: user);
              },
            );
  }

  Column buildColumnLoading() {
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
  }
}
