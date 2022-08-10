import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:github_repo_user/model/repository.dart';
import 'package:github_repo_user/view_model/list_repositorys.dart';


class UserRepositorys extends StatefulWidget {
  final String userLoginId;

  const UserRepositorys({Key? key, required this.userLoginId})
      : super(key: key);

  @override
  State<UserRepositorys> createState() => _UserRepositorysState();
}

class _UserRepositorysState extends State<UserRepositorys> {
  ListRepositorysViewModel listRepositorysViewModel = ListRepositorysViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textAppBar(context),
        ),
        body: FutureBuilder(
          // future: userViewModel.getUserInformation(widget.userLoginId),
          future: listRepositorysViewModel.getUserRepositories("dionlaranjeira"),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return buildColumnLoading();
              case ConnectionState.active:
                return buildColumnLoading();
              case ConnectionState.done:
                List<Repository> repositorys = listRepositorysViewModel.repos!;
                return buildGridViewUsers(repositorys);
              case ConnectionState.none:
                return buildInforText('Internet connection problems.');
              default:
                return buildInforText('Problems receiving data.');
            }
          },
        ));
  }

  MasonryGridView buildGridViewUsers(List<Repository> repos) {
    return MasonryGridView.count(
      // controller: _scrollController,
      itemCount: repos.length,
      crossAxisCount: 1,
      itemBuilder: (_, index) {
        Repository repo = repos[index];
        return Text(repo.name!);
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

  Container textAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(widget.userLoginId,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Center buildInforText(String text) =>
      const Center(child: Text('Internet connection problems.'));


}
