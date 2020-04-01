import 'package:flutter/material.dart';
import 'package:formation_google/cmp_card_infos.dart';
import 'package:formation_google/model/item_formation.dart';

class ViewAfficheInfos extends StatefulWidget {
  ViewAfficheInfos(this.heroTag, this.itemFormation);
  final String heroTag;
  final ItemFormation itemFormation;

  @override
  ViewAfficheInfosState createState() => ViewAfficheInfosState();
}

class ViewAfficheInfosState extends State<ViewAfficheInfos> {
  /*TextEditingController controllerCodeFormation = new TextEditingController();
  TextEditingController controllerFormateur = new TextEditingController();
  TextEditingController controllerRemarques = new TextEditingController();
  TextEditingController controllerStagiaire = new TextEditingController();
  TextEditingController controllerLibelle = new TextEditingController();
  TextEditingController controllerDescription = new TextEditingController();
  TextEditingController controllerDuree = new TextEditingController();
  TextEditingController controllerDates = new TextEditingController();
  TextEditingController controllerCodeTarifaire = new TextEditingController();
  TextEditingController controllerDeroulement = new TextEditingController();
  TextEditingController controllerVersion = new TextEditingController();
  TextEditingController controllerSocietes = new TextEditingController();*/
  

  @override
  void initState(){
    super.initState();
    /*controllerCodeFormation.text = widget.itemFormation.codeFormation;
    controllerFormateur.text = widget.itemFormation.formateur;
    controllerRemarques.text = widget.itemFormation.remarques;
    controllerStagiaire.text = widget.itemFormation.stagiaire;
    controllerLibelle.text = widget.itemFormation.libelle;
    controllerDescription.text = widget.itemFormation.description;
    controllerDuree.text = widget.itemFormation.duree;
    controllerDates.text = widget.itemFormation.dates;
    controllerCodeTarifaire.text = widget.itemFormation.codeTarifaire;
    controllerDeroulement.text = widget.itemFormation.deroulement;
    controllerVersion.text = widget.itemFormation.version;
    controllerSocietes.text = widget.itemFormation.societes;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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