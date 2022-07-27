import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/detail_page.dart';
import 'package:flutter_application_1/page/home_page.dart';
import 'package:flutter_application_1/providers/players.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/page/add_player_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Players(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: homePage(),
        routes: {
          AddPlayer.routeName: (context) => AddPlayer(),
          DetailPlayer.routeName: (context) => DetailPlayer()
        },
      ),
    );
  }
}
