

import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/trunkSize.dart';
import 'package:treesmarking/pages/speciesPage.dart';

import '../pages/speciesListPage.dart';
import '../pages/trunkSizeListPage.dart';

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
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              selected: _displayedTabIndex == 1,
              onTap: () {
                setDisplayedTab(1);
              },
              title: const Text("Import/Export"),
            ),
            Visibility(
              visible: _displayedTabIndex == 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text("Import from file"),
                    ),
                    ListTile(
                      title: Text("Export file"),
                    ),
                    ListTile(
                      title: Text("Export by e-mail"),
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
              title: const Text("Config data"),
            ),
            Visibility(
              visible: _displayedTabIndex == 2,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Species"),
                      onTap: openSpeciesListPage,
                    )
                    ,
                    ListTile(
                      title: Text("Trunk Size"),
                       onTap: openTrunkSizeListPage,
                      
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
              title: const Text("About"),
            ),
            Visibility(
              visible: _displayedTabIndex == 3,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    const ListTile(
                      title: Text("Tree marking is an open source, simple, offline, privacy friendly To-Do app developed with love by Judemont and Rdemont"),
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
  
}
