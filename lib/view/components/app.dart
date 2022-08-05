import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repo_user/view/initial_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Github users repo',
      debugShowCheckedModeBanner: false,
      home: InitialPage(),
    );

  }
}