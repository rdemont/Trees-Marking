import 'package:flutter/material.dart';

import 'package:treesmarking/businessObj/list/speciesList.dart';
import 'package:treesmarking/businessObj/list/trunkSizeList.dart';
import 'package:treesmarking/businessObj/species.dart';


import '../businessObj/campaign.dart';
import '../businessObj/list/campaignList.dart';
import '../businessObj/list/markedTreeList.dart';
import '../businessObj/markedTree.dart';
import '../businessObj/trunkSize.dart';
import '../widget/campaignWidget.dart';
import '../widget/settingsWidget.dart';
import 'markedTreePage.dart';


class MarkedTreeListPage extends StatefulWidget {
  const MarkedTreeListPage({super.key});


  @override
  State<MarkedTreeListPage> createState() => _MarkedTreeListPageState();
}



class _MarkedTreeListPageState extends State<MarkedTreeListPage> {
  List<MarkedTree> _markedTreeList = [];
  List<Campaign> _campaignList = [];
  Map<int,Species> _spaciesAll = {}; 
  Map<int,TrunkSize> _trunkSizeAll = {}; 
  Campaign _campaignSelected = Campaign.newObj(); 

  @override
  void initState() {
    _loadFK(); 
print("**initState**");
    _loadCampaign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text(_campaignSelected.name),
         actions: [
          Builder(builder: (context) => IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip, ),)
         ],
      ),
      bottomNavigationBar: BottomAppBar(child: getBottomInfo(),),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MarkedTreePage(campaign: _campaignSelected,)  )
              ).then((value){
                setState(() {
                  _loadMarkedTreeFromCampaign(_campaignSelected.id);
                });
              });
        },
      ),
      body: Stack(
        children: [ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _markedTreeList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(_markedTreeList[index].species.name+" - "+_markedTreeList[index].trunkSize.toString()), 
                  //+"\n"+DateFormat("dd.MM.yyyy HH:mm:ss").format(_markedTreeList[index].insertTime)
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MarkedTreePage(marketTree: _markedTreeList[index],campaign: _campaignSelected,)  )
                    ).then((value){
                      setState(() {
                        _loadMarkedTreeFromCampaign(_campaignSelected.id);
                      });
                    });
                  },
                );
            }
          ),
          ]
      
  ),
      
      endDrawer:  Drawer(child:  SettingsWidget()), 
      
      drawer: Drawer(child: CampaignWidget(
        campaignList: _campaignList,
        onCamaignChange: _loadMarkedTreeFromCampaign,
      ),),
    );
    
  }



  void _loadMarkedTreeFromCampaign(int campaignId) async {
    Campaign.openObj(campaignId).then((campaign) {
      setState(() {
        _campaignSelected = campaign;
      });
      MarkedTreeList.getFromCampaign(campaignId).then((list) {
        setState(() {          
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
          _loadMarkedTreeFromCampaign(_campaignSelected.id);
        }
      });
    });
  }


  _loadFK() 
   {
    
    SpeciesList.getObjectsMap().then((value) {
      setState(() {
        _spaciesAll = value ;   
      });
      
    });
  
    TrunkSizeList.getObjectsMap().then((value){
      _trunkSizeAll = value ; 
    });
  }
  


Widget getBottomInfo() {
  double sv = 0; 
  Map<String,int> speciesCount = {};
  Map<String,double> speciesSv = {};
  

  for (int i = 0;i<_markedTreeList.length;i++)
  {
    sv += _markedTreeList[i].trunkSize.volume; 
    String speciesName = _markedTreeList[i].species.name;
    speciesCount[speciesName] = (speciesCount[speciesName]??0) +1;  
    speciesSv[speciesName] = (speciesSv[speciesName]??0) + _markedTreeList[i].trunkSize.volume;  

  }

  List<DataRow> dataRow = []; 
  
  
  for (String key in speciesCount.keys)
  {
    dataRow.add(DataRow(cells: [
      DataCell(Text(key)),
      DataCell(Text(speciesCount[key].toString())),
      DataCell(Text((speciesSv[key]??0.0).toStringAsFixed(2))),
      ]));
  }
  

  return GestureDetector(
    onTap: () {   
      final infoBar = SnackBar(backgroundColor: Colors.grey,
        content: DataTable(
          columns: [
            DataColumn(label: Expanded(child: Text("Species",style: TextStyle(fontStyle: FontStyle.italic),))),
            DataColumn(label: Expanded(child: Text("Count",style: TextStyle(fontStyle: FontStyle.italic),))),
            DataColumn(label: Expanded(child: Text("Sv",style: TextStyle(fontStyle: FontStyle.italic),))),
          ],
          rows: dataRow,

          
        ),
  

        action: SnackBarAction(label: 'Hide', onPressed: () {;},),
      );
      ScaffoldMessenger.of(context).showSnackBar(infoBar);
    }, 
    child: Row(
    children: [
      Column(
        children: [
          Text("Number"),
          Divider(),
          Text(_markedTreeList.length.toString())
        ],
      ),
      VerticalDivider( 
        width: 20,
        thickness: 2,
        indent: 1,
        endIndent: 1,
        color: Colors.black,
      ),
      Column(
        children: [
          Text("SV"),
          Divider(),
          Text(sv.toStringAsFixed(2))
        ],
      ),
      Expanded(child: Text(""),),
    ],
  
    ),
    
  );
}
}
