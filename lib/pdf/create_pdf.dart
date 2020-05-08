import 'dart:io';
import 'package:flutter/material.dart' as mat;
import 'package:formation_google/model/item_formation.dart';
import 'package:formation_google/model/workbook.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePdf{
  static final CreatePdf _singleton = CreatePdf._internal();
  
  factory CreatePdf() {
    return _singleton;
  }

  CreatePdf._internal();

   Future<File> createPdfGlobal(mat.BuildContext buildContext, String nomDoc, bool download, Workbook workbook) async{ 
    final Document pdf = Document(); 
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return buildDocGlobal(buildContext, workbook, "", "", "", "");
        }
      ),
    );
    String output;
    if(download){
      if (Platform.isAndroid) {
        if(await Permission.storage.request().isGranted){
          output = (await getExternalStorageDirectory()).path;  
        }
      } else if (Platform.isIOS) {
        output = (await getApplicationDocumentsDirectory()).path;  
      }
    }else{
        if (Platform.isAndroid) {
          output = (await getExternalStorageDirectory()).path;  
        } else if (Platform.isIOS) {
          output = (await getApplicationDocumentsDirectory()).path;  
        }
    }
    
    final file = File('${output}/'+nomDoc+'.pdf');
    file.writeAsBytesSync(pdf.save());
    return file;
  }

  List<Widget> buildDocGlobal(mat.BuildContext context,Workbook workbook, String codeFormation, String libelleFormation, String dureeFormation, String descFormation, ){
    List<Widget> listDocPdf = List<Widget>();

    List<Widget> listOfFormation = List<Widget>();
    listOfFormation.addAll({
      Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("PROGRAMME DE FORMATION", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
        Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("CADRE", style: TextStyle(fontSize: 15.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
        Text("La ou les société(s) formée(s) : ........................."),

        Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("DESCRIPTION", style: TextStyle(fontSize: 15.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
    });
    var formation = workbook.sheets["formations"];
    var rows = formation.rows;
    int index = 1;
    rows.forEach((k,value) {
      listOfFormation.add(Text("Formation " + index.toString() + " : " + value["duree"] + " jour(s)", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ));
      listOfFormation.add(Text("Code : " + value["code_formation"] + " / " + "Libellé : " + value["libelle"]));     
      listOfFormation.add(Text("Description : " + value["description"]));
      index++;
    });
    
    Widget widget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listOfFormation, /* <Widget>[
        Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("PROGRAMME DE FORMATION", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
        Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("CADRE", style: TextStyle(fontSize: 15.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
        Text("La ou les société(s) formée(s) : ........................."),

        Container(
          margin: EdgeInsets.only(top:8.0),
          child: Text("DESCRIPTION", style: TextStyle(fontSize: 15.0, color: PdfColors.orange)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.0),
          width: 800,
          height: 1.0,
          color: PdfColors.orange500,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listOfFormation
        ),
      ] */);

    listDocPdf.add(widget);

    return listDocPdf;
  }

 
  Future<File> createPdf(mat.BuildContext buildContext, ItemFormation itemFormation, bool download, Workbook workbook) async{ 
    final Document pdf = Document(); 
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return buildDoc(buildContext, itemFormation, workbook);
        }
      )
    ); 
    String output;
    if(download){
      if (Platform.isAndroid) {
        if(await Permission.storage.request().isGranted){
          output = (await getExternalStorageDirectory()).path;  
        }
      } else if (Platform.isIOS) {
        output = (await getApplicationDocumentsDirectory()).path;  
      }
    }else{
        if (Platform.isAndroid) {
          output = (await getExternalStorageDirectory()).path;  
        } else if (Platform.isIOS) {
          output = (await getApplicationDocumentsDirectory()).path;  
        }
    }
    
    final file = File('${output}/'+itemFormation.libelle+'.pdf');
    file.writeAsBytesSync(pdf.save());
    return file;
  }

  String getElementFormation(String code, Workbook workbook, String whatAreWeLookingFor){
    //Public visÃ©

    var element =  workbook.sheets["elements"];
    var rows = element.rows;
    String public = "";
    rows.forEach((k,value) {
      if(value['categorie'] == whatAreWeLookingFor){
        if(value["code_formation"] == code && value['description'] != null){
          public = value['description'];
          return public;
        }
      }
    });

    return public;
  }

  List<Widget> buildDoc(mat.BuildContext context, ItemFormation itemFormation, Workbook workbook){
    
    
    List<Widget> listDocPdf = List<Widget>();
    
    Widget widget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 8.0),
        child: 
          Text("FICHE FORMATION", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
        color: PdfColors.orange500,
      ),
      Text("Offre : " + itemFormation.codeTarifaire),
      Text("Version : " + itemFormation.version),
      Text("Thème : " + itemFormation.codeFormation),
      Text(itemFormation.libelle),

      Container(
        margin: EdgeInsets.only(top:8.0),
        child: Text("CADRE", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
        color: PdfColors.orange500,
      ),
      Text("La ou les société(s) formée(s) : ........................."),
      Text("La ou les dates de formation : ........................."),
      Text("Le référent client (nom/prénom/société) : ........................."),
      Text("Le consultant VIF formateur (nom/prénom)  : ........................."),

      Container(
        margin: EdgeInsets.only(top:8.0),
        child: Text("DESCRIPTION DU THEME", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
        color: PdfColors.orange500,
      ),
      Text("Code tarifaire : " + itemFormation.codeTarifaire),
      Text("Code de la formation : " + itemFormation.codeFormation),
      Text("Description de la formation : " + itemFormation.description),
      Text("Durée de la formation : " + itemFormation.duree + " jour(s)"),

      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("PUBLIC VISE", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Public visÃ©")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("SUPPORTS DE FORMATION (OU D'AUTO-FORMATION) DISPONIBLES", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Support de formation")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("DÉROULEMENT / PLAN DE TRAVAIL", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Déroulement / plan de travail")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("PRÉ-REQUIS POUR LES STAGIAIRES", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text('Etat : "T -> Terminé" ou "C -> En cours" ou "AF -> A faire"'),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Pré-requis stagiaire référent")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("PRÉ-REQUIS POUR LE FORMATEUR", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text(' Etat : "T -> Terminé" ou "EC -> En cours" ou "AF -> A faire"'),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Pré-requis formateur référent")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("OBJECTIFS (EN TERME DE CONNAISSANCE/SAVOIR FAIRE)", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text('Etat : "T -> Terminé" ou "EC -> En cours" ou "AF -> A faire" ou "NC : Non concerné"'),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Objectif")),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text('LISTE DE TESTS UNITAIRES "STANDARD" (EXERCICES POUR VALIDATION DES CONNAISSANCES)', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text('Etat : "T -> Terminé" ou "EC -> En cours" ou "AF -> A faire" ou "NC : Non concerné"'),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Tests et TP")),
           
      Text('''Ci-dessus vous trouverez les tests unitaires "standards" liés à cette formation. Ils doivent être réalisés pour valider la formation (même pour une auto-formation). Ils vont servir de TP (travaux pratiques) lors de la formation (et être continués suite à la formation si le temps manque lors de celle-ci).
      Ce sont également des pré-requis "obligatoires" pour valider la mise en production.
      Selon les thèmes, des tests complémentaires mais davantage "contextualisés" peuvent être créés. C'est souvent le cas pour les thèmes de formations qui sont directement liés à des "flux" contextuels.
      Les tests peuvent être utilisés dès la maquette par le consultant pour valider son paramétrage et pouvoir montrer des exemples de fonctionnement.
      '''),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Actions habituelles")),
      
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),     
      Text("LISTE D'ACTIONS À MENER HABITUELLES (SAISIE ET PARAMÉTRAGE) :", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),

      Text("Ci-dessus vous trouverez les actions habituellements demandées suite à cette formation. Vous pouvez vous en servir, à la fin de la journée de formation, en réalisant par exemple un copier/coller afin d'alimenter le document de suivi des actions."),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
      ),
      Text("HORS FORMATION :", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold) ),
      Text(getElementFormation(itemFormation.codeFormation, workbook, "Hors formation")),
      
      Text('Ci-dessus les éléments "Hors formation" hors périmètre de la formation (nous n\'y mentionnons que les éléments qui semblent "proches") : soit hors proposition commerciale, soit dans une autre formation.'),

      Container(
        margin: EdgeInsets.only(top:8.0),
        child: Text("REMARQUES OU DEMANDES DU RÉFÉRENT CLIENT", style: TextStyle(fontSize: 25.0, color: PdfColors.orange)),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        width: 800,
        height: 1.0,
        color: PdfColors.orange500,
      ),

      Text("Les signatures ci-dessous valent pour validation de ce qui est indiqué sur les tous éléments du document (pré-requis, objectifs, tests, actions ...) et de leur états (Fait, En cours, A faire, NC)."),

    ]);

    listDocPdf.add(widget);

    return listDocPdf;
  }
}