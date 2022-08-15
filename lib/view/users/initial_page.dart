import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:github_repo_user/model/user.dart';

import 'package:github_repo_user/util/custom_search_delegate.dart';
import 'package:github_repo_user/view/users/components/infor_text_widget.dart';

import 'package:github_repo_user/view_model/list_users.dart';
import 'package:github_repo_user/view_model/user_data.dart';
import 'package:github_repo_user/view/users/components/card_user_widget.dart';
import 'package:github_repo_user/view/users/components/loading_widget.dart';
import 'package:github_repo_user/view/users/components/user_details_widget.dart';

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
              return LoadingWidget();
            case ConnectionState.done:
              return _query.isEmpty ? buildGridViewUsers(listUsersViewModel.users!) : UseDetailsWidget(userDetail: userViewModel.userDetail!);
            case ConnectionState.none:
              return const InforTextWidget(infor: 'Internet connection problems.');
            default:
              return const InforTextWidget(infor: 'Problems receiving data.');
          }
        },
      ),
    );
  }


  MasonryGridView buildGridViewUsers(List<User> users) {
    return MasonryGridView.count(
      // controller: _scrollController,
      itemCount: users.length,
      crossAxisCount: 2,
      itemBuilder: (_, index) {
        User user = users[index];
        return CardUserWidget(user: user);
      },
    );
  }

}
