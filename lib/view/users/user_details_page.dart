import 'package:flutter/material.dart';
import 'package:github_repo_user/view/users/components/infor_text_widget.dart';
import 'package:github_repo_user/view/users/components/loading_widget.dart';
import 'package:github_repo_user/view_model/user_data.dart';
import 'package:github_repo_user/view/users/components/user_details_widget.dart';

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
                return LoadingWidget();
              case ConnectionState.active:
                return LoadingWidget();
              case ConnectionState.done:
                return Scaffold(
                    backgroundColor: const Color(0xffdddddd),
                    body: SingleChildScrollView(
                      child: UseDetailsWidget(userDetail: userViewModel.userDetail!),
                    ),
                  );
              case ConnectionState.none:
                return const InforTextWidget(infor: 'Internet connection problems.');
              default:
                return const InforTextWidget(infor: 'Problems receiving data.');
            }
          },
        ));
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

}
