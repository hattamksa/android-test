import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/player.dart';
import 'package:flutter_application_1/page/add_player_page.dart';
import 'package:flutter_application_1/page/detail_page.dart';
import 'package:flutter_application_1/providers/players.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPlayerProvider = Provider.of<Players>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("all player"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlayer.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: (allPlayerProvider.jumlahPlayer == 0)
          ? Text("kosongd")
          : ListView.builder(
              itemCount: allPlayerProvider.jumlahPlayer,
              itemBuilder: (context, index) {
                var id = allPlayerProvider.allPlayer[index].id;
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, DetailPlayer.routeName,
                        arguments: id);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        allPlayerProvider.allPlayer[index].imageUrl),
                  ),
                  title: Text(allPlayerProvider.allPlayer[index].name),
                  subtitle: Text(DateFormat.yMMMMd()
                      .format(allPlayerProvider.allPlayer[index].createdAt)),
                  trailing: IconButton(
                    onPressed: () {
                      allPlayerProvider.deletePlayer(id, context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              }),
    );
  }
}
