

import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treesmarking/pages/mainPage.dart';


import '../pages/campaignListPage.dart';
import '../pages/speciesListPage.dart';
import '../pages/trunkSizeListPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/databaseService.dart';



class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}


class _SettingsWidgetState extends State<SettingsWidget> {
  int _displayedTabIndex = 0;

  void setDisplayedTab(int index) {
    setState(() {
      if (_displayedTabIndex == index) {
        _displayedTabIndex = 0;
      } else {
        _displayedTabIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              selected: _displayedTabIndex == 1,
              onTap: () {
                setDisplayedTab(1);
              },
              title: Text(AppLocalizations.of(context)!.importExport),
            ),
            Visibility(
              visible: _displayedTabIndex == 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.importFromFile),
                      onTap: () {
                        const XTypeGroup typeGroup = XTypeGroup(
                          label: 'Marked Tree backup file',
                          extensions: <String>['json'],
                        );

                        openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]).then((value) {
                          final XFile? file = value; 
                          if (file != null )
                          {
                            file.readAsString().then((value){
                              DatabaseService.restoreBackup(value);
                            }) ;
                            
                          }
                        }) ;                       
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.exportToFile),
                      onTap: () {
                        getApplicationDocumentsDirectory().then((value) {
                          Directory appDocumentsDirectory = value ; // 1
                          String appDocumentsPath = appDocumentsDirectory.path;
                          String filePath = '$appDocumentsPath/markedTree_Export_${DateFormat("yyyyMMddhhmmss").format(DateTime.now())}.json';

                          File file = File(filePath);

                          DatabaseService.generateBackup().then((value){
                            file.writeAsString(value);
                            Share.shareXFiles([XFile(filePath)]);
                          });
                        });
                      },
                    ),

                  ],
                ),
              ),
            ),
            ListTile(
              selected: _displayedTabIndex == 2,
              onTap: () {
                setDisplayedTab(2);
              },
              title: Text(AppLocalizations.of(context)!.data),
            ),
            Visibility(
              visible: _displayedTabIndex == 2,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Essences"),
                      onTap: openSpeciesListPage,
                    )
                    ,
                    ListTile(
                      title: Text("Tarif"),
                       onTap: openTrunkSizeListPage,
                      
                    ),
                    /*
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.campaign),
                       onTap: openCampaignListPage,
                      
                    ),*/
                    ListTile(
                      title: Text("Supprimer les données"),
                       onTap:() => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('AlertDialog Title'),
                          content: const Text('AlertDialog description'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                 deleteCampagne() ;
                                 Navigator.pop(context, 'Ok');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ), 
                      
                      
                    ),                    
                  ],
                ),
              ),
            ),
            ListTile(
              selected: _displayedTabIndex == 3,
              onTap: () {
                setDisplayedTab(3);
              },
              title: Text(AppLocalizations.of(context)!.about),
            ),
            Visibility(
              visible: _displayedTabIndex == 3,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.aboutText),
                    ),
                    ListTile(
                      title: const Text(
                        "Source code (GitHub)",
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openSpeciesListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SpeciesListPage()  )
    );
  }


  openTrunkSizeListPage(){    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TrunkSizeListPage()  )
    );

  }


  openCampaignListPage(){    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  CampaignListPage()  )
    );

  }

  deleteCampagne(){
    DatabaseService.initializeDb().then((db) {
      db.execute("DELETE FROM  markedTree");
      db.execute("DELETE FROM  species");
      db.execute("DELETE FROM  trunkSize");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  MainPage()  )
     );
    });
  }

}
