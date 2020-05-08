import 'package:flutter/material.dart';
import 'package:formation_google/model/item_list_user.dart';
import 'package:formation_google/model/workbook.dart';
import 'package:formation_google/service/current_user.dart';
import 'package:formation_google/service/save_data.dart';
import 'package:formation_google/views/app_view_liste.dart';
import 'package:formation_google/views/loading_indicator.dart';
import 'package:formation_google/web/web_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewGridFormation extends StatefulWidget {
  @override
  ViewGridFormationState createState() => ViewGridFormationState();
}

class ViewGridFormationState extends State<ViewGridFormation> {
  List<Widget> gridWidget = List<Widget>();
  @override void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      title: const Text('Formations'),
    ),
    body:GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: buildListWidget(),
      ),
    );
  }

  List<Widget> buildListWidget() {
    List<Widget> listeWidgetGrid = new List<Widget>();
    ItemListUser itemListUser = SaveData().getDataOfUser();
    if(itemListUser != null && itemListUser.key != null && itemListUser.value != null){
      for(int index = 0; index<itemListUser.key.length; index++){
        listeWidgetGrid.add (
          InkWell(
            onLongPress: (){
              return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Suppression d'une formation"),
                  content: Text("Etes vous sur de vouloir supprimer cette formation ?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('NON'),
                      onPressed: () {      
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('OUI'),
                      onPressed: () async{
                        await SaveData().deletePrefData(itemListUser.key.elementAt(index));
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                    
                  ],
                );
              });
            },
            onTap: () async{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoadingIndicator()),
              );
              Workbook workbook =  await WebController().getWorkBook(itemListUser.key.elementAt(index));
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewListe(workbook, itemListUser.value.elementAt(index))),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal[300],
              ),
              padding: const EdgeInsets.all(8),
              child: Center(child:Text(itemListUser.value.elementAt(index), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
              
            ),
          ),
        );
      }
    }
    listeWidgetGrid.add (
      InkWell(
        onTap: () async{
          await _displayDialog(context);
        },
        child:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal[100],
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.add, size: 30.0,),
        )
      ),
    );
    return listeWidgetGrid;
  }

  _displayDialog(BuildContext context) async {
    TextEditingController _textFieldControllerKey = TextEditingController();
    TextEditingController _textFieldControllerValue = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Ajout d'un google spreadsheet"),
            content:Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[ 
                TextField(
                  controller: _textFieldControllerValue,
                  decoration: InputDecoration(hintText: "Insérez un nom à votre document"),
                ),
                TextField(
                  controller: _textFieldControllerKey,
                  decoration: InputDecoration(hintText: "Insérez l'id du document"),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ANNULER'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ), 
              new FlatButton(
                child: new Text('OK'),
                onPressed: () async{
                  await SaveData().writePrefData(_textFieldControllerKey.text, _textFieldControllerValue.text);
                  Navigator.of(context).pop();
                  setState(() {});
                },
              )
            ],
          );
        });
  }
}