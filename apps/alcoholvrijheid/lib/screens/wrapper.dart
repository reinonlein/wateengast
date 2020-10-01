import 'package:alcoholvrijheid/screens/authenticate/authenticate.dart';
import 'package:alcoholvrijheid/screens/home/home.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either Home of Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
