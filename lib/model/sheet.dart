import 'package:flutter/material.dart';
import 'package:formation_google/model/columns.dart' as col;

class Sheet{
  
    Map<String, dynamic> columns;
  
    Map<String, dynamic> rows;

    Sheet({@required this.columns, @required this.rows});
}