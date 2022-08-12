import 'package:flutter/material.dart';

class InforTextWidget extends StatelessWidget {
  final String infor;

  const InforTextWidget({
    Key? key,
    required this.infor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(infor));
  }
}
