import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/util/custom_search_delegate.dart';
import 'package:github_repo_user/view/users/components/card_user.dart';
import 'package:github_repo_user/view/users/components/user_details.dart';
import 'package:github_repo_user/view_model/list_users.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:github_repo_user/view_model/user_data.dart';

class InitialPage extends StatefulWidget {

  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  ListUsersViewModel listUsersViewModel = ListUsersViewModel();
  UserViewModel userViewModel = UserViewModel();
  String _query = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            color: Colors.grey
        ),
        title: Image.asset("assets/images/github.png", width: 150),
        actions: [
          IconButton(
              onPressed: () async {
                String? resultQuery = await showSearch(context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _query = resultQuery!;
                });
              },
              icon: const Icon(Icons.search, size: 35)),

        ],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _query.isEmpty ? listUsersViewModel.getRandomUsers() : userViewModel.getUserInformation(_query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return buildColumnLoading();
            case ConnectionState.done:
              return _query.isEmpty ? buildGridViewUsers(listUsersViewModel.users!) : UseDetailsWidget(userViewModel: userViewModel);
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
