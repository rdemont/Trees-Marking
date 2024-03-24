




import 'package:flutter/material.dart';
import 'package:treesmarking/Widget/CampaignWidget.dart';

import '../Widget/MarkedTreeWidget.dart';
import '../Widget/SettingsWidget.dart';
import '../businessObj/campaign.dart';
import '../businessObj/markedTree.dart';

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
  List<MarkedTree> markedTreeList = [];
  List<Campaign> campaignList = [];

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          margin: const EdgeInsets.only(left:30),
          child: SingleChildScrollView(
            child: Column(
              children: [MarkedTreeWidget(items: markedTreeList,)]
            )
          )
        )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      endDrawer:  Drawer(child:  SettingsWidget()), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(child: CampaignWidget(
        campaignList: campaignList,
        onCamaignChange: _loadMarkedTreeFromCampaign,
      ),),
    );
  }

  void _incrementCounter() {
  }

  void _loadMarkedTreeFromCampaign(campaignId) async {
print("Campaign ID to load $campaignId");    
    Campaign.openObj(campaignId).then((campaign) {
      campaign.markedTreeList().then((list) {
        markedTreeList = list ; 
      });
    });
  }
  
}
