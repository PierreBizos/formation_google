
import 'package:flutter/material.dart';

class CardInfos extends StatefulWidget {
  CardInfos({@required this.title, @required this.texte, @required this.toDoWhenValidate});
  final Function(String) toDoWhenValidate;
  final String title;
  final String texte;

  @override
  CardInfosState createState() => CardInfosState();
}

class CardInfosState extends State<CardInfos> {
  TextEditingController controllerText = new TextEditingController();
  Future<void> _neverSatisfied(String texte) async {
    controllerText.text = texte;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Modification information'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: controllerText,
                keyboardType: TextInputType.multiline,
              )
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ANNULER'),
            onPressed: () {          
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('VALIDER'),
            onPressed: () {
              widget.toDoWhenValidate(controllerText.text);              
              Navigator.of(context).pop();
              setState(() {});
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 20,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text(widget.texte,style: TextStyle(fontSize: 14),),
            ],),),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async{
                  await _neverSatisfied(widget.texte);
              },
            ),
            ],)
        ),
    );
  }
}