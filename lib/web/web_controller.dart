import 'dart:convert';

import 'package:formation_google/model/sheet.dart';
import 'package:formation_google/model/workbook.dart';
import 'package:http/http.dart' as http;

class WebController {
  static final WebController _singleton = WebController._internal();

  factory WebController() {
    return _singleton;
  }

  WebController._internal();

  final String baseUrl = 'http://192.168.0.19:9998/';
  // tu peux ajouter ses spreadsheet
  // 1i-ZL5t76f4SyWircknyzGMl0s5orcED6QcSPHY4GXyg
  // 16aB9HOvpUkb5yNwLkfJdS5ZFUHGBoQJNCcl0MAb6Z_E

  Future<Workbook> getWorkBook(String spreadsheetId) async{
    Workbook myWorkBook;
    Sheet mySheet;
    
    Map<String, Sheet> myMapSheet = new Map<String, Sheet>();
    String url = baseUrl + 'get/' + spreadsheetId;
    var response;
    try{
      response = await http.get(url);
    } catch(e){
      print(e.message);
    }
   
    if(response != null && response != null){
      if(response.statusCode == 200){
        var fileId = json.decode(response.body)["file-id"];
        var version = json.decode(response.body)["version"];
        var sheets = json.decode(response.body)["sheets"];

        var sheetTarif = sheets["codes_tarifaires"];
          
        var sheetForm = sheets["formations"];
        var sheetElem = sheets["elements"];
        var sheetTaches = sheets["taches"];
          
        myMapSheet.addAll({"codes_tarifaires":getColAndRowOfSheet(sheetTarif)});
        myMapSheet.addAll({"formations":getColAndRowOfSheet(sheetForm)});
        myMapSheet.addAll({"elements":getColAndRowOfSheet(sheetElem)});
        myMapSheet.addAll({"taches":getColAndRowOfSheet(sheetTaches)});
    
        
        myWorkBook = new Workbook(
          fileId: fileId,
          version: version,
          sheets: myMapSheet,
        );
      }else{
        print("non ok");
      }
    }
    return myWorkBook;
  }

  Sheet getColAndRowOfSheet(var sheet){
    Sheet mySheet;
    mySheet = new Sheet(
      rows: sheet["rows"],
      columns: sheet["columns"],
    );
    return mySheet;
  }

  Future updateCell(String spreadsheetId, String sheetName, String lineName, String cellName, String newValue) async{

  }

  Future getPdf(String spreadsheetId, String modelId) async{

  }

  Future getFormationPdf(String spreadsheetId, String modelId, String formationCode) async{

  }

}