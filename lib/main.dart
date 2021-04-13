import 'package:nara_app/views/Entraance.dart';
import 'package:nara_app/views/wrapper.dart';
import 'package:nara_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nara_app/models/user.dart';

import 'bloc/custom_theme.dart';
import 'bloc/theme.dart';

void main() {
  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: CustomTheme.of(context),
        home: Wrapper(),
        //home: SignIn(),
      ),
    );
  }
}