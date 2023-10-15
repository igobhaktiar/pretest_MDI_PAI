import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretest_mdi_pai/data/user.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.userData});

  final User userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(children: [
          Text(userData.firstName),
        ]),
      ),
    );
  }
}
