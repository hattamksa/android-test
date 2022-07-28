import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/players.dart';

class DetailPlayer extends StatelessWidget {
  static const routeName = "/detail-player";
  const DetailPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Players>(context, listen: false);
    final playerId = ModalRoute.of(context)!.settings.arguments as String;
    final selectPlayer = players.selectById(playerId);
    final TextEditingController imageController =
        TextEditingController(text: selectPlayer.imageUrl);
    final TextEditingController nameController =
        TextEditingController(text: selectPlayer.name);
    final TextEditingController positionController =
        TextEditingController(text: selectPlayer.position);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Player"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(imageController.text))),
                ),
              ),
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(labelText: "Nama"),
                controller: nameController,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Posisis"),
                textInputAction: TextInputAction.next,
                controller: positionController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Image Url"),
                controller: imageController,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: OutlineButton(
                  onPressed: () {
                    players.editPlayer(playerId, nameController.text,
                        positionController.text, imageController.text, context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
