import 'package:flutter/material.dart';
import 'package:formation_google/model/sheet.dart';

class Workbook {
    String fileId;
    String version;
    Map<String, Sheet> sheets;
    
    Workbook({@required this.fileId, @required this.sheets, @required this.version});
}