import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_repo_user/model/user_details.dart';
import 'package:github_repo_user/util/format_string.dart';
import 'package:github_repo_user/view/repos/user_repositorys.dart';

class UseDetailsWidget extends StatelessWidget {
  final UserDetail userDetail;
  const UseDetailsWidget({Key? key, required this.userDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: MediaQuery.of(context).size.height * 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: Theme.of(context).dividerColor,
                    backgroundImage:
                    NetworkImage(userDetail.avatarUrl!)),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(userDetail.name!.toUpperCase(), style: Theme.of(context).textTheme.headline1,),
                    Text(userDetail.login!, style: Theme.of(context).textTheme.headline2,),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            userDetail.bio != null ? Text(userDetail.bio!, style: Theme.of(context).textTheme.headline2) : Container(),

            const SizedBox(height: 8),
            userDetail.company != null?
            buildRowInfor(context, const FaIcon(FontAwesomeIcons.building), userDetail.company!) : Container(),

            const SizedBox(height: 8),
            userDetail.location != null ?
            buildRowInfor(context, const FaIcon(FontAwesomeIcons.locationDot), userDetail.location!) : Container(),

            const SizedBox(height: 8),
            userDetail.email != null ?
            buildRowInfor(context, const FaIcon(FontAwesomeIcons.envelope), userDetail.email!) : Container(),

            const SizedBox(height: 8),
            userDetail.twitterUsername != null ?
            buildRowInfor(context, const FaIcon(FontAwesomeIcons.twitter), "@" + userDetail.twitterUsername!) :Container(),

            const SizedBox(height: 8),
            Row(children: [
              const FaIcon(FontAwesomeIcons.user),
              const SizedBox(width: 8),
              Text(userDetail.followers.toString(), style: Theme.of(context).textTheme.headline2),
              const Text(" Followers - "),
              Text(userDetail.following.toString(), style: Theme.of(context).textTheme.headline2),
              const Text(" Following"),
            ],),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    onPressed:  () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context)=>UserRepositorys(userLoginId: userDetail.login!))),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.folder),
                        const SizedBox(width: 8),
                        const Text("Repositories"),
                        Expanded(child: Container()),
                        Text(userDetail.publicRepos.toString())
                      ],
                    ),
                ),
              ),
            ),
            // Text("Github user since " + userViewModel.userDetail!.createdAt!),
            const SizedBox(height: 24),
            Center(child: Text("Github user since " +  FormatStrings.dateFormart(userDetail.createdAt!),textAlign: TextAlign.center , style: Theme.of(context).textTheme.headline1)),

          ],
        ),
      ),
    );
  }

  Row buildRowInfor(BuildContext context ,FaIcon icon, String information) {
    return Row(children: [
            icon,
            const SizedBox(width: 8),
            Text(information, style: Theme.of(context).textTheme.headline2),
          ],);
  }
}