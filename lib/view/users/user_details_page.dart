import 'package:flutter/material.dart';
import 'package:github_repo_user/view_model/user_data.dart';
import 'package:github_repo_user/view/users/components/user_details.dart';

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
          future: userViewModel.getUserInformation(widget.userLoginId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return buildColumnLoading();
              case ConnectionState.active:
                return buildColumnLoading();
              case ConnectionState.done:
                // UserDetail user = userViewModel.userDetail!;
                return Scaffold(
                    backgroundColor: const Color(0xffdddddd),
                    body: SingleChildScrollView(
                      child: UseDetailsWidget(userViewModel: userViewModel),
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
