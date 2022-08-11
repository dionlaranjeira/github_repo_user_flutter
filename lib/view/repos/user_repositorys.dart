import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:github_repo_user/model/repository.dart';
import 'package:github_repo_user/util/colors_languages.dart';
import 'package:github_repo_user/view_model/list_repositorys.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserRepositorys extends StatefulWidget {
  final String userLoginId;

  const UserRepositorys({Key? key, required this.userLoginId})
      : super(key: key);

  @override
  State<UserRepositorys> createState() => _UserRepositorysState();
}

class _UserRepositorysState extends State<UserRepositorys> {
  ListRepositorysViewModel listRepositorysViewModel = ListRepositorysViewModel();
  Map<String, dynamic> colors = ColorsLanguage.colors as Map<String, dynamic>;

  // _retornarCor(String language) async {
  //   String color = "0xffdddddd";
  //   colors.forEach((key, value) {
  //     if(key == language){
  //       color = "0xff"+ value["color"].toString().replaceAll("#", "")  ;
  //     }
  //   });
  //   print("color-->" + color);
  //   return Color(int.parse(color));
  // }

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
        return InkWell(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(repo.name!,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                repo.description != null ? Text(repo.description!): Container(),
                Row(children: [
                  const FaIcon(FontAwesomeIcons.star),
                  const SizedBox(width: 8),
                  Text(repo.stargazersCount!.toString()),

                  const SizedBox(width: 16),
                  const FaIcon(FontAwesomeIcons.eye),
                  const SizedBox(width: 8),
                  Text(repo.watchersCount!.toString()),

                  const SizedBox(width: 16),
                  const FaIcon(FontAwesomeIcons.codeFork),
                  const SizedBox(width: 8),
                  Text(repo.forksCount!.toString()),

                  repo.language != null ? Row(
                    children: [const SizedBox(width: 16),
                      const FaIcon(FontAwesomeIcons.code),
                      const SizedBox(width: 8),
                      Text(repo.language!)],
                  ): Container(),

                ]),
                Divider(),
              ],
            ),
          ),
        );
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
      child: Text("Repositorys",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Center buildInforText(String text) =>
      const Center(child: Text('Internet connection problems.'));


}
