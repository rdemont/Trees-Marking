import 'package:flutter/material.dart';

import '../businessObj/campaign.dart';
import '../businessObj/campaignList.dart';
import '../businessObj/species.dart';
import '../businessObj/speciesList.dart';
import '../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeList.dart';
import '../services/databaseService.dart';
import 'markedTreeListPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    
  List<TrunkSize> _trunkSizeList = [];
  List<Campaign> _campaignList = [];    
  List<Species> _speciesList = [];    
  Widget body = Text("Please waite ....loading ");

  loadData()
  {
    setState(() {
      body = Text("Please waite ....loading ");  
    });
      
    if ((!_campaignList.isEmpty)
      && (!_speciesList.isEmpty)
      && (!_trunkSizeList.isEmpty))
    {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MarkedTreeListPage())
        );
      });
    }

    Widget speciesBody = Text("");
    if (_speciesList.isEmpty)
    {
      speciesBody = ElevatedButton(
        child: Text("Create species from VD") ,
        onPressed: () {
          setState(() {
            body = Text("Please waite ....loading ");  
          });
          loadSpeciesFromVD().then((value){
            _speciesList = value ; 
            loadData(); 
          });
        },
      );
    }
    Widget trunkSizeBody = Text("");
    if (_trunkSizeList.isEmpty)
    {
      trunkSizeBody = ElevatedButton(
        child: Text("Create trunk size from VD") ,
        onPressed: () {
          setState(() {
            body = Text("Please waite ....loading ");  
          });
          loadTrunkSizeFromVD().then((value) {
            _trunkSizeList = value ; 
            loadData(); 
          });
        },
      );
    }

    Widget campaignBody = Text("");
    if (_campaignList.isEmpty)
    {
      campaignBody = ElevatedButton(
        child: Text("Create campaign") ,
        onPressed: () {
          setState(() {
            body = Text("Please waite ....loading ");  
          });
          createCampaign().then((value){
            _campaignList = value ; 
            loadData(); 
          });
        },
      );
    }


    setState(() {
      body = Center(
        child: Column (
          children: [
            speciesBody,
            trunkSizeBody,
            campaignBody
          ],
        )
      );
    });
    
  }


    @override
  void initState()  {
    super.initState();
    Future.wait([
      TrunkSizeList.getAll().then((value) {
        _trunkSizeList = value ;  
        return ;
      }),
      CampaignList.getAll().then((value) {
        _campaignList = value ;  
        return ;
      }),
      SpeciesList.getAll().then((value) {
        _speciesList = value ;  
        return ;
      }),
    ]).then((value) {
      loadData();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tree-marking"),
      ),
      body: Center(
        child: body,
      )
    );
  }


  Future<List<Species>> loadSpeciesFromVD() {
    return DatabaseService.initializeDb().then((db) {
      return Future.wait([
        db.execute("INSERT INTO species (name,communUse) VALUES ('Sapin',1)"),
        db.execute("INSERT INTO species (name,communUse) VALUES ('Sapin blanc',1)"),
        db.execute("INSERT INTO species (name,communUse) VALUES ('Chêne',1)"),
      ]).then((value) {
        return SpeciesList.getAll();
      });
    });
  }


  Future<List<TrunkSize>> loadTrunkSizeFromVD() {

    return DatabaseService.initializeDb().then((db) {
      return Future.wait([
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (16.0,19.99,0.2,'1')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (20.0,23.99,0.3,'2')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (24.0,27.99,0.5,'3')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (28.0,31.99,0.7,'4')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (32.0,35.99,1.0,'5')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (36.0,39.99,1.3,'6')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (40.0,43.99,1.6,'7')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (44.0,47.99,2.0,'8')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (48.0,51.99,2.4,'9')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (52.0,55.99,2.8,'10')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (56.0,59.99,3.3,'11')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (60.0,63.99,3.8,'12')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (64.0,67.99,4.4,'13')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (68.0,71.99,5.0,'14')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (72.0,75.99,5.7,'15')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (76.0,79.99,6.4,'16')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (80.0,83.99,7.1,'17')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (84.0,87.99,7.9,'18')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (88.0,91.99,8.7,'19')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (92.0,95.99,9.5,'20')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (96.0,99.99,10.3,'21')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (100.0,103.99,11.2,'22')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (104.0,107.99,12.1,'23')"),
        db.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (108.0,111.99,13.1,'24')"),
      ]).then((value){
        return TrunkSizeList.getAll();
      });
    });
  }


/*
    CREATE TABLE IF NOT EXISTS campaign(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      remark TEXT,
      latitude FLOAT,
      longitude FLOAT,
      campaignDate DATETIME DEFAULT CURRENT_TIMESTAMP 
      */

  Future<List<Campaign>> createCampaign() {
    return DatabaseService.initializeDb().then((db) {
      return Future.wait([
        db.execute("INSERT INTO campaign (name,campaignDate) VALUES ('Default campaign',"+DateTime.now().millisecondsSinceEpoch.toString()+")"),
      ]).then((value) {
        return CampaignList.getAll();
      });
    });
  }

}