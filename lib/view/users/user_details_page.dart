import 'package:flutter/material.dart';
import 'package:github_repo_user/model/user_details.dart';
import 'package:github_repo_user/view/repos/user_repositorys.dart';
import 'package:github_repo_user/view_model/user_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDetailsPage extends StatefulWidget {
  final String userLoginId;

  const UserDetailsPage({Key? key, required this.userLoginId})
      : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  UserViewModel userViewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: textAppBar(context),
        ),
        body: FutureBuilder(
          // future: userViewModel.getUserInformation(widget.userLoginId),
          future: userViewModel.getUserInformation("dionlaranjeira"),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return buildColumnLoading();
              case ConnectionState.active:
                return buildColumnLoading();
              case ConnectionState.done:
                UserDetail user = userViewModel.userDetail!;
                return Scaffold(
                    backgroundColor: const Color(0xffdddddd),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Theme.of(context).dividerColor,
                                      backgroundImage:
                                      NetworkImage(user.avatarUrl!)),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user.name!.toUpperCase()),
                                      Text(user.login!),
                                    ],
                                  ),
                                ],
                              ),
                        Text(user.bio!),
                          Row(children: [
                            const FaIcon(FontAwesomeIcons.building),
                            SizedBox(width: 8),
                            Text(user.company!),
                            SizedBox(width: 16),
                            const FaIcon(FontAwesomeIcons.locationDot),
                            SizedBox(width: 8),
                            Text(user.location!),
                          ],),

                          Row(children: [
                            const FaIcon(FontAwesomeIcons.link),
                            Text(user.blog!),
                          ],),

                          Row(children: [
                            const FaIcon(FontAwesomeIcons.envelope),
                            Text(user.email!),
                          ],),

                          Row(children: [
                            const FaIcon(FontAwesomeIcons.link),
                            Text(user.blog!),
                          ],),

                          Row(children: [
                          const FaIcon(FontAwesomeIcons.twitter),
                          Text("@" + user.twitterUsername!),
                        ],),

                          Row(children: [
                            const FaIcon(FontAwesomeIcons.user),
                            Text(user.followers.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(" Followers - "),
                            Text(user.following.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  Text(user.publicRepos.toString())
                                ],
                              )
                          ),

                          ElevatedButton(
                              onPressed: (){},
                              child: Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.heart),
                                  const SizedBox(width: 8),
                                  const Text("Favorites")
                                ],
                              )
                          ),

                          ElevatedButton(
                              onPressed: (){},
                              child: Row(
                                children: [
                                  const FaIcon(FontAwesomeIcons.building),
                                  const SizedBox(width: 8),
                                  const Text("Organizations")
                                ],
                              )
                          ),

                          //Todo: add 5 user repositories in list view horizontal

                          Text("Github user since " + user.createdAt!)



                        ],
                      ),
                    ),
                  );
              case ConnectionState.none:
                return buildInforText('Internet connection problems.');
              default:
                return buildInforText('Problems receiving data.');
            }
          },
        ));
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
