import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:formation_google/cmp_card_infos.dart';
import 'package:formation_google/model/item_formation.dart';
import 'package:formation_google/pdf/create_pdf.dart';
import 'package:formation_google/service/current_user.dart';
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
              File file = await CreatePdf().createPdf(context, widget.itemFormation, true);
              print(file.path);
              
              final snackBar = SnackBar(content: Text('Le fichier se trouve dans '+file.path));
              Scaffold.of(context).showSnackBar(snackBar);
            },
            shape: CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            child: Icon(Icons.file_download, color: Colors.white, size: iconSize),
          ),
          RawMaterialButton(
            onPressed: () async{
              File file = await CreatePdf().createPdf(context, widget.itemFormation, false);

              final Email email = Email(
                cc: [CurrentUser.email],
                body: 'Vous trouverez en pièce jointe la formation que vous avez demandée.',
                subject: widget.itemFormation.libelle,
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
       
        CardInfos(
          texte: widget.itemFormation.codeFormation,
          title: "Code formation", 
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.codeFormation = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.formateur,title: "Formateur",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.formateur = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.remarques,title: "Remarques",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.remarques = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.stagiaire,title: "Stagiaire",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.stagiaire = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.libelle,title: "Libelle",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.libelle = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.description,title: "Description",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.description = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.duree,title: "Durée",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.duree = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.dates,title: "Dates",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.dates = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.deroulement,title: "Déroulement",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.deroulement = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.version,title: "Version",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.version = texte;
            });
          },
        ),
        CardInfos(texte: widget.itemFormation.societes,title: "Sociétés",
          toDoWhenValidate: (texte){
            setState(() {
              widget.itemFormation.societes = texte;
            });
          },
        ),
      ],
    )))
    );
  }

    
  
}