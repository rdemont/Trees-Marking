




import 'package:flutter/material.dart';
import 'package:treesmarking/Widget/CampaignWidget.dart';
import 'package:treesmarking/businessObj/list/campaignList.dart';
import 'package:treesmarking/businessObj/list/markedTreeList.dart';

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
  List<MarkedTree> _markedTreeList = [];
  List<Campaign> _campaignList = [];
  Campaign _campaignSelected = Campaign.newObj(); 

  @override
  void initState() {
print("**initState**");
    _loadCampaign();
    //_loadTodoFromGroup(selectedGroupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(_campaignSelected.name),
      ),
      body: Container( 
          //color: Colors.red,
          height: double.infinity,
          child: MarkedTreeWidget(markedTreeList: _markedTreeList,campaign: _campaignSelected,)
        ),
      endDrawer:  Drawer(child:  SettingsWidget()), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(child: CampaignWidget(
        campaignList: _campaignList,
        onCamaignChange: _loadMarkedTreeFromCampaign,
      ),),
    );
  }



  void _loadMarkedTreeFromCampaign(campaignId) async {
print("Campaign ID to load $campaignId");    
    Campaign.openObj(campaignId).then((campaign) {
      setState(() {
print ("Campaign.name "+campaign.name);
        _campaignSelected = campaign;
      });
      MarkedTreeList.getFromCampaign(campaignId).then((list) {
        setState(() {
print("load markedTreeList count : "+list.length.toString());          

          
          _markedTreeList = list ; 
        });
      });
    });
  }
  
  

  _loadCampaign() 
  {
    CampaignList.getAll().then((value) {
      setState(() {
        _campaignList = value; 
        if (_campaignList.length >0 )
        {
          _campaignSelected = _campaignList[0];
        }
      });
    });
  }
  
}
