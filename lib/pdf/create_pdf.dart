import 'dart:io';
import 'package:flutter/material.dart' as mat;
import 'package:formation_google/model/item_formation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class CreatePdf{
  static final CreatePdf _singleton = CreatePdf._internal();
  
  factory CreatePdf() {
    return _singleton;
  }

  CreatePdf._internal();

 
  Future<File> createPdf(mat.BuildContext buildContext, ItemFormation itemFormation) async{ 
    final Document pdf = Document(); 
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return buildDoc(buildContext, itemFormation);
        }
      )
    ); 

    Directory output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    file.writeAsBytesSync(pdf.save());
    return file;
  }

  List<Widget> buildDoc(mat.BuildContext context, ItemFormation itemFormation){
    List<Widget> listDocPdf = List<Widget>();
    
    Widget widget = Column(children: <Widget>[
      Text("FICHE FORMATION",),
      Text("Offre : " + itemFormation.codeTarifaire),
      Text("Version : " + itemFormation.version),
      Text("Thème : " + itemFormation.codeFormation),
      Text(itemFormation.libelle),

      Text("CADRE",),
      Text("La ou les société(s) formée(s) : "),
      Text("La ou les dates de formation : "),
      Text("Le référent client (nom/prénom/société) : "),
      Text("Le consultant VIF formateur (nom/prénom)  : "),

    ]);

    listDocPdf.add(widget);

    return listDocPdf;
  }
}