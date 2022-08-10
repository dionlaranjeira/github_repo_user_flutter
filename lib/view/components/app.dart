import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repo_user/view/users/initial_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return const MaterialApp(
      title: 'Github users repo',
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );

  }
}