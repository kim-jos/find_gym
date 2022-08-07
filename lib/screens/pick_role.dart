import 'package:find_gym/models/user.role.dart';
import 'package:find_gym/screens/login.dart';
import 'package:find_gym/utils/localization.dart' show t;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickRoleScreen extends StatefulWidget {
  const PickRoleScreen({Key? key}) : super(key: key);

  @override
  State<PickRoleScreen> createState() => _PickRoleScreen();
}

class _PickRoleScreen extends State<PickRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t("GYM FINDER")),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text(t('GYM')),
              onPressed: () {
                Get.to(() => LoginScreen(), arguments: Role.admin);
              },
            ),
            TextButton(
              child: Text(t('USER')),
              onPressed: () {
                Get.to(() => LoginScreen(), arguments: Role.user);
              },
            ),
          ],
        ),
      ),
    );
  }
}
