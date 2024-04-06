

import 'package:flutter/material.dart';

import '../pages/campaignListPage.dart';
import '../pages/speciesListPage.dart';
import '../pages/trunkSizeListPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.exportToFile),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.exportByEMail),
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
                      title: Text(AppLocalizations.of(context)!.species),
                      onTap: openSpeciesListPage,
                    )
                    ,
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.trunkSize),
                       onTap: openTrunkSizeListPage,
                      
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.campaign),
                       onTap: openCampaignListPage,
                      
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
}
