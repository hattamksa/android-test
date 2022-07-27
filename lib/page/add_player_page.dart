import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../providers/players.dart';
import 'package:provider/provider.dart';

class AddPlayer extends StatelessWidget {
  static const routeName = "/add-player";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  // const AddPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Players>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add player"),
        actions: [
          IconButton(
              onPressed: () {
                players
                    .addPlayer(nameController.text, positionController.text,
                        imageController.text)
                    .then((response) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("okse"),
                    duration: Duration(seconds: 2),
                  ));
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "nama"),
                textInputAction: TextInputAction.next,
                controller: nameController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "posisi"),
                textInputAction: TextInputAction.next,
                controller: positionController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Image Url"),
                controller: imageController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
