import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/view_model/list_users.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              // return buildColumn(listUsersViewModel.users!);
              return MasonryGridView.count(
                // controller: _scrollController,
                itemCount: listUsersViewModel.users!.length,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return cardUser(listUsersViewModel.users![index]);
                },
              );
            case ConnectionState.none:
              return const Center(child: Text('Internet connection problems.'));
            default:
              return const Center(child: Text('Problems receiving data.'));
          }
        },
      ),
    );
  }

  InkWell cardUser(User user) {
    return InkWell(
      onTap: null,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(4.0)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(
                user.login ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            Hero(
              tag: user.id!,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: CachedNetworkImage(
                    imageUrl: user.avatarUrl!,
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
