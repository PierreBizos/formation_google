import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:formation_google/cmp_card_infos.dart';
import 'package:formation_google/model/item_formation.dart';
import 'package:formation_google/pdf/create_pdf.dart';
import 'package:path_provider/path_provider.dart';

class ViewAfficheInfos extends StatefulWidget {
  ViewAfficheInfos(this.heroTag, this.itemFormation);
  final String heroTag;
  final ItemFormation itemFormation;

  @override
  ViewAfficheInfosState createState() => ViewAfficheInfosState();
}

class ViewAfficheInfosState extends State<ViewAfficheInfos> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final double iconSize = 30.0;
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Icon(Icons.file_download, color: Colors.transparent,size: iconSize),
          ),
          
          RawMaterialButton(
            onPressed: () async{
              File file = await CreatePdf().createPdf(context, widget.itemFormation);
              print(file.path);
              //_showSnackBar(context, "You pressed 3");
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.file_download, color: Colors.white, size: iconSize),
          ),
          RawMaterialButton(
            onPressed: () async{
              File file = await CreatePdf().createPdf(context, widget.itemFormation);

              final Email email = Email(
                body: 'Email body',
                subject: 'Email subject',
                recipients: ['pierre.bizos@hotmail.fr'],
                cc: ['pierre.bizos@hotmail.fr'],
                bcc: ['pierre.bizos@hotmail.fr'],
                attachmentPaths: [file.path],
                isHTML: false,
              );

              await FlutterEmailSender.send(email);
              print(email.attachmentPaths);
              //_showSnackBar(context, "You pressed 4. This one closes the menu on tap");
              fabKey.currentState.close();
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.email, color: Colors.white, size: iconSize),
          )
        ],
      ),
    ),
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      title: const Text('Détails'),
    ),
    body:Container(
      
     
      child:
    SingleChildScrollView(child:
    Column(
      children: <Widget>[
        Hero(
          tag: widget.heroTag,
          child: 
        Icon(Icons.school, size: 70,),
        ),
       
        CardInfos(texte: widget.itemFormation.codeFormation,title: "Code formation",),
        CardInfos(texte: widget.itemFormation.formateur,title: "Formateur",),
        CardInfos(texte: widget.itemFormation.remarques,title: "Remarques",),
        CardInfos(texte: widget.itemFormation.stagiaire,title: "Stagiaire",),
        CardInfos(texte: widget.itemFormation.libelle,title: "Libelle",),
        CardInfos(texte: widget.itemFormation.description,title: "Description",),
        CardInfos(texte: widget.itemFormation.duree,title: "Durée",),
        CardInfos(texte: widget.itemFormation.dates,title: "Dates",),
        CardInfos(texte: widget.itemFormation.deroulement,title: "Déroulement",),
        CardInfos(texte: widget.itemFormation.version,title: "Version",),
        CardInfos(texte: widget.itemFormation.societes,title: "Sociétés",),
        //CardInfos(texte: widget.itemFormation.codeFormation,title: "Code formation",),
       
        /*TextField(
          controller: controllerCodeFormation,
        ),
        TextField(
          controller: controllerFormateur,
        ),
        TextField(
          controller: controllerRemarques,
        ),
        TextField(
          controller: controllerStagiaire,
        ),
        TextField(
          controller: controllerLibelle,
        ),
        TextField(
          controller: controllerDescription,
        ),
        TextField(
          controller: controllerDuree,
        ),
        TextField(
          controller: controllerDates,
        ),
        TextField(
          controller: controllerCodeTarifaire,
        ),
        TextField(
          controller: controllerDeroulement,
        ),
        TextField(
          controller: controllerVersion,
        ),
        TextField(
          controller: controllerSocietes,
        ),*/
        Container(
          margin: EdgeInsets.all(10),
          child:
            RaisedButton(
              onPressed: (){},
              child: Text("Exporter au format PDF"),
            )
        )
      ],
    )))
    
    );
  }

    
  
}