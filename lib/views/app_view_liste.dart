import 'package:flutter/material.dart';
import 'package:formation_google/model/item_formation.dart';
import 'package:formation_google/model/workbook.dart';
import 'package:formation_google/views/app_view_affiche_infos.dart';

class ViewListe extends StatefulWidget {
  ViewListe(this.workbook);

  final Workbook workbook;

  @override
  ViewListeState createState() => ViewListeState();
}

class ViewListeState extends State<ViewListe> {
  Map<int, ItemFormation> mapListe = new Map<int, ItemFormation>();

  @override
  void initState(){
    super.initState();
    var formation = widget.workbook.sheets["formations"];
    var rows = formation.rows;
    ItemFormation itemFormation;
    for(int i=0; i<=formation.rows.length; i++){
      itemFormation = new ItemFormation();
      var infos = rows[i.toString()];
      if(infos != null){
        itemFormation.codeFormation = infos["code_formation"];
        itemFormation.formateur = infos["formateur"];
        itemFormation.remarques = infos["remarques"];
        itemFormation.stagiaire = infos["stagiaire"];
        itemFormation.libelle = infos["libelle"];
        itemFormation.description = infos["description"];
        itemFormation.duree = infos["duree"];
        itemFormation.dates = infos["dates"];
        itemFormation.codeTarifaire = infos["code_tarifaire"];
        itemFormation.deroulement = infos["deroulement"];
        itemFormation.version = infos["version"];
        itemFormation.societes = infos["societes"];

        mapListe.addAll({i:itemFormation});
      }
    }   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(93, 142, 155, 1.0),
      title: const Text('Mes formations'),
    ),
    body:
      ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: mapListe.length,
  itemBuilder: (BuildContext context, int index) {
    return InkResponse(
      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewAfficheInfos("myHero" + index.toString(), mapListe.values.elementAt(index))),
        );
      },
      child:
    Container(
      height: 70,
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          Expanded(child:
          Row(
            children: <Widget>[     
              Container(
                padding: EdgeInsets.all(8.0),
                child:  
                Hero(
                  tag:"myHero" + index.toString(),
                  child:  
                  Icon(Icons.school, size: 40,),
                )
              ),
            Expanded(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(mapListe.values.elementAt(index).codeFormation + mapListe.values.elementAt(index).libelle, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            ),
          ],
        ),
          ),
      ],
      ),
    )
    );
  }
      ),
);
  }
}