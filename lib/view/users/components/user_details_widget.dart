import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_repo_user/view/repos/user_repositorys.dart';
import 'package:github_repo_user/view_model/user_data.dart';

class UseDetailsWidget extends StatelessWidget {
  final UserViewModel userViewModel;
  const UseDetailsWidget({required this.userViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
                maxRadius: 30,
                backgroundColor: Theme.of(context).dividerColor,
                backgroundImage:
                NetworkImage(userViewModel.userDetail!.avatarUrl!)),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userViewModel.userDetail!.name!.toUpperCase()),
                Text(userViewModel.userDetail!.login!),
              ],
            ),
          ],
        ),
        Text(userViewModel.userDetail!.bio!),
        Row(children: [
          const FaIcon(FontAwesomeIcons.building),
          SizedBox(width: 8),
          Text(userViewModel.userDetail!.company!),
          SizedBox(width: 16),
          const FaIcon(FontAwesomeIcons.locationDot),
          SizedBox(width: 8),
          Text(userViewModel.userDetail!.location!),
        ],),

        Row(children: [
          const FaIcon(FontAwesomeIcons.link),
          Text(userViewModel.userDetail!.blog!),
        ],),

        Row(children: [
          const FaIcon(FontAwesomeIcons.envelope),
          Text(userViewModel.userDetail!.email!),
        ],),

        Row(children: [
          const FaIcon(FontAwesomeIcons.link),
          Text(userViewModel.userDetail!.blog!),
        ],),

        Row(children: [
          const FaIcon(FontAwesomeIcons.twitter),
          Text("@" + userViewModel.userDetail!.twitterUsername!),
        ],),

        Row(children: [
          const FaIcon(FontAwesomeIcons.user),
          Text(userViewModel.userDetail!.followers.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          Text(" Followers - "),
          Text(userViewModel.userDetail!.following.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          Text(" Following"),
        ],),

        ElevatedButton(
            onPressed:  () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>UserRepositorys(userLoginId: "dionlaranjeira"))),
            child: Row(
              children: [
                const FaIcon(FontAwesomeIcons.folder),
                const SizedBox(width: 8),
                const Text("Repositories"),
                Expanded(child: Container()),
                Text(userViewModel.userDetail!.publicRepos.toString())
              ],
            )
        ),

        Text("Github user since " + userViewModel.userDetail!.createdAt!)

      ],
    );
  }
}