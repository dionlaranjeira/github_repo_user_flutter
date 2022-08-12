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

    const seedColor = Color(0xFF000000);
    const secundaryColor = Color(0xFF1F51FF);


    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: seedColor,
                primary: seedColor,
                brightness: Brightness.dark,
                secondary: secundaryColor
            ),

        ),
        debugShowCheckedModeBanner: false,

        home: const InitialPage());

  }
}