import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
}