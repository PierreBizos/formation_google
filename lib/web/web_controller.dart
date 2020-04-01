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

  final String baseUrl = 'http://172.28.14.23:9998/';

  Future<Workbook> getWorkBook(String spreadsheetId) async{
    Workbook myWorkBook;
    Sheet mySheet;
    Map<String, Sheet> myMapSheet = new Map<String, Sheet>();
    spreadsheetId = "1nv43m6oX6VWHg2iENxYq7f-IFfWg8MDCqRuuNAQK4o8";
    String url = baseUrl + 'get/' + spreadsheetId;
    var response = await http.get(url);
   
    
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