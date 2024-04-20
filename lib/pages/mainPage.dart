import 'package:flutter/material.dart';
import 'package:treesmarking/pages/campaignListPage.dart';


import '../businessObj/campaign.dart';
import '../businessObj/campaignList.dart';
import '../businessObj/species.dart';
import '../businessObj/speciesList.dart';
import '../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeList.dart';
import '../services/databaseService.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    
  List<TrunkSize> _trunkSizeList = [];
  //List<Campaign> _campaignList = [];    
  List<Species> _speciesList = [];    
  Widget body = Text("Please waite ....loading ");  
  bool _hasPositionPermission = false ; 

  loadData()
  {
    setState(() {
      body = Text(AppLocalizations.of(context)!.pleaseWaite);
    });
      
    if ((!_speciesList.isEmpty)
      && (!_trunkSizeList.isEmpty)
      && (_hasPositionPermission))
    {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CampaignListPage())
        );
      });
    }

    Widget speciesBody = Text("");
    if (_speciesList.isEmpty)
    {
      speciesBody = ElevatedButton(
        child: Text(AppLocalizations.of(context)!.createSpeciesFromVD) ,
        onPressed: () {
          setState(() {
            body = Text(AppLocalizations.of(context)!.pleaseWaite);  
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
        child: Text(AppLocalizations.of(context)!.createTrunkSizeFromVD) ,
        onPressed: () {
          setState(() {
            body = Text(AppLocalizations.of(context)!.pleaseWaite);  
          });
          loadTrunkSizeFromVD().then((value) {
            _trunkSizeList = value ; 
            loadData(); 
          });
        },
      );
    }

    if (!_hasPositionPermission)
    {
      setState(() {
        body = Text(AppLocalizations.of(context)!.pleaseWaite);  
      });
      _determinePosition().then((value) {
print("POSITION **** "+value.latitude.toString());              
        _hasPositionPermission = value.latitude != 0.0; 
        loadData();
      });
    }
 /*   
Widget positionBody = Text("");
    if(!_hasPositionPermission)
    {
      positionBody = ElevatedButton(
        child: Text("Get localization permission"),
        onPressed:() {
          setState(() {
            body = Text(AppLocalizations.of(context)!.pleaseWaite);  
          });
            _determinePosition().then((value) {
print("POSITION **** "+value.latitude.toString());              
            _hasPositionPermission = value.latitude != 0.0; 
            loadData();
          });

        },
      );
    }
*/

    setState(() {
      body = Center(
        child: Column (
          children: [
            speciesBody,
            trunkSizeBody,
            //positionBody
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
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Center(
        child: body,
      )
    );
  }


  Future<List<Species>> loadSpeciesFromVD() {
    return DatabaseService.initializeDb().then((db) {
      return Future.wait([
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Alisier','AL',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Alisier blanc','AB',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Alisier torminal','AT',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Arolle','AR',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Aulne','AU',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Aulne blanc','AB',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Aulne noir','AN',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Aulne vert','AV',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Autres feuillus','AF',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Autres résineux','AR',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Bouleau','BO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Bouleau pubescent','BP',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Bouleau verruqueux','BV',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Cerisier','CE',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Charme','CA',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Charme-houblon','CO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chataîgnier','CT',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne','CH',1,1)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne chevelu','CC',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne pédonculé','CP',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne pubescent','CU',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne rouge','CR',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Chêne sessile','CS',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Douglas','DO',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Épicéa','EP',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Érable','ER',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Érable à feuilles d’obier','EO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Érable champêtre','EC',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Érable plane','EP',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Érable sycomore','ES',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Frêne','FR',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Hêtre','HE',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Houx','HO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('If','IF',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Marronnier d’Inde','MA',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Mélèze','ME',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Merisier à grappes','MG',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Noyer','NO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Noyer commun','NC',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Noyer noir','NN',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Orme','OR',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Orme champêtre','OC',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Orme de montagne','OM',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Orme lisse','OL',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Peuplier','PE',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Peuplier blanc','PB',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Peuplier noir','PR',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Peuplier tremble','PT',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin','PI',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin couché','PC',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin de montagne','PM',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin noir','PN',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin sylvestre','PS',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pin Weymouth','PW',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Poirier sauvage','PO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Pommier sauvage','PA',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Robinier','RO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Sapin','SA',2,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Saule','SL',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Saule marsault','SM',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Sorbier des oiseleurs','SO',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Tilleul','TI',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Tilleul à grandes feuilles','TG',1,0)"),
        db.execute("INSERT INTO species (name,code,type,communUse) VALUES ('Tilleul à petites feuilles','TP',1,0)"),
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

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}