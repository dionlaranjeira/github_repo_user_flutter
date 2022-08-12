import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github_repo_user/view/users/user_details_page.dart';

class CardUserWidget extends StatelessWidget {
  final User user;

  const CardUserWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>UserDetailsPage(userLoginId: user.login!,))),
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
