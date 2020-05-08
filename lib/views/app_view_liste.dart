import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:formation_google/model/item_formation.dart';
import 'package:formation_google/model/workbook.dart';
import 'package:formation_google/pdf/create_pdf.dart';
import 'package:formation_google/service/current_user.dart';
import 'package:formation_google/views/app_view_affiche_infos.dart';

class ViewListe extends StatefulWidget {
  ViewListe(this.workbook, this.formationName);
final String formationName;
  final Workbook workbook;

  @override
  ViewListeState createState() => ViewListeState();
}

class ViewListeState extends State<ViewListe> {
  Map<int, ItemFormation> mapListe = new Map<int, ItemFormation>();
  Map<String, List<String>> listObjFromMap =  Map<String, List<String>>();
  final double iconSize = 30.0;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  List<String> stringListObj = List<String>();

  @override
  void initState(){
    super.initState();
    var formation = widget.workbook.sheets["formations"];
    var rows = formation.rows;
    ItemFormation itemFormation;
    for(int i=0; i<=formation.rows.length; i++){
      itemFormation = new ItemFormation();
      var infos = rows[i.toString()];
      if(infos != null){
        itemFormation.codeFormation = infos["code_formation"];
        itemFormation.formateur = infos["formateur"];
        itemFormation.remarques = infos["remarques"];
        itemFormation.stagiaire = infos["stagiaire"];
        itemFormation.libelle = infos["libelle"];
        itemFormation.description = infos["description"];
        itemFormation.duree = infos["duree"];
        itemFormation.dates = infos["dates"];
        itemFormation.codeTarifaire = infos["code_tarifaire"];
        itemFormation.deroulement = infos["deroulement"];
        itemFormation.version = infos["version"];
        itemFormation.societes = infos["societes"];

        mapListe.addAll({i:itemFormation});
        listObjFromMap.addAll({itemFormation.codeFormation : buildObjectifList(itemFormation.codeFormation)});
      }
    }   
  }

  List<String> buildObjectifList(String codeFormation) {
    List<String> stringListObjectif = List<String>();
    var element =  widget.workbook.sheets["elements"];
    var rows = element.rows;
    rows.forEach((k,value) {
      
      if(value['categorie'] == "Objectif"){
        if(value["code_formation"] == codeFormation && value['description'] != null){
          stringListObjectif.add(value['description']);
        }
      }
    });
    return stringListObjectif;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      title: const Text('Mes formations'),
    ),
    floatingActionButton: Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        // Cannot be `Alignment.center`
        alignment: Alignment.bottomRight,
        ringColor: Colors.black54,
        ringDiameter: 400.0,
        ringWidth: 100.0,
        fabSize: 64.0,
        fabElevation: 8.0,
        
        // Also can use specific color based on wether
        // the menu is open or not:
        // fabOpenColor: Colors.white
        // fabCloseColor: Colors.white
        // These properties take precedence over fabColor
        fabColor: Colors.white,
        fabOpenIcon: Icon(Icons.menu, color: Colors.black),
        fabCloseIcon: Icon(Icons.close, color:  Theme.of(context).primaryColor),
        fabMargin: const EdgeInsets.all(16.0),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (isOpen) {
          //_showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
        },
        children: <Widget>[
          RawMaterialButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              //_showSnackBar(context, "You pressed 1");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.email, color: Colors.transparent, size: iconSize,),
          ),
          RawMaterialButton(
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              //_showSnackBar(context, "You pressed 2");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.check_circle_outline, color: Colors.transparent,size: iconSize),
          ),
          
          RawMaterialButton(
            onPressed: () async{
              File file = await CreatePdf().createPdfGlobal(context, widget.formationName,true, widget.workbook);
              //print(file.path);
              
              final snackBar = SnackBar(content: Text('Le fichier se trouve dans '+file.path));
              Scaffold.of(context).showSnackBar(snackBar);
              fabKey.currentState.close();
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.file_download, color: Colors.white, size: iconSize),
          ),
          RawMaterialButton(
            onPressed: () async{
              File file = await CreatePdf().createPdfGlobal(context, widget.formationName, false, widget.workbook);

              final Email email = Email(
                cc: [CurrentUser.email],
                body: 'Vous trouverez en pièce jointe la formation que vous avez demandée.',
                subject: widget.formationName,
                attachmentPaths: [file.path],
                isHTML: false,
              ); 
              await FlutterEmailSender.send(email);
              print(email.attachmentPaths);
              final snackBar = SnackBar(content: Text('Le Mail a été envoyé'));
              Scaffold.of(context).showSnackBar(snackBar);
              fabKey.currentState.close();
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.email, color: Colors.white, size: iconSize),
          )
        ],
      ),
    ),
    body:
      ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: mapListe.length,
  itemBuilder: (BuildContext context, int index) {
    return InkResponse(
      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewAfficheInfos("myHero" + index.toString(), mapListe.values.elementAt(index), listObjFromMap[mapListe.values.elementAt(index).codeFormation], widget.workbook)),
        );
      },
      child:
    Container(
      height: 70,
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          Expanded(child:
          Row(
            children: <Widget>[     
              Container(
                padding: EdgeInsets.all(8.0),
                child:  
                Hero(
                  tag:"myHero" + index.toString(),
                  child:  
                  Icon(Icons.school, size: 40,),
                )
              ),
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(mapListe.values.elementAt(index).codeFormation + mapListe.values.elementAt(index).libelle, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            ),
          ],
        ),
          ),
      ],
      ),
    )
    );
  }
      ),
);
  }
}