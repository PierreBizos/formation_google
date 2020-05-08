import 'package:flutter/material.dart';
import 'package:formation_google/service/save_data.dart';

class ListObjectif extends StatefulWidget {
  ListObjectif(this.code, this.stringListObj);
  final String code;
  final List<String> stringListObj;

  

  @override
  ListObjectifState createState() => ListObjectifState();
}

class ListObjectifState extends State<ListObjectif> {
  List<String> objList;
  
  @override
  void initState(){
    super.initState();
    objList = SaveData().getObjectifChecked(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: widget.stringListObj.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.stringListObj.elementAt(index)),
            leading: InkWell(
              child: Icon(objList.contains(widget.stringListObj.elementAt(index)) ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.blueAccent,),
              onTap: (){
                if(objList.contains(widget.stringListObj.elementAt(index))){
                  SaveData().removeObjectifChecked(widget.code, widget.stringListObj.elementAt(index));
                }else{
                  SaveData().addObjectifChecked(widget.code, widget.stringListObj.elementAt(index));
                }
                setState(() {
                  objList = SaveData().getObjectifChecked(widget.code);
                });
              },
            ),
          );
        },
      ),
    );
  }
  
}