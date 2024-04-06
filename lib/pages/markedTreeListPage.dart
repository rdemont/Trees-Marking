import 'package:flutter/material.dart';

import '../businessObj/campaign.dart';
import '../businessObj/campaignList.dart';
import '../businessObj/markedTree.dart';

import '../businessObj/markedTreeList.dart';
import '../generate/businessObj/campaignGen.dart';
import '../widget/campaignWidget.dart';
import '../widget/settingsWidget.dart';
import 'markedTreePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MarkedTreeListPage extends StatefulWidget {
  const MarkedTreeListPage({super.key});


  @override
  State<MarkedTreeListPage> createState() => _MarkedTreeListPageState();
}



class _MarkedTreeListPageState extends State<MarkedTreeListPage> {
  List<MarkedTree> _markedTreeList = [];
  List<Campaign> _campaignList = [];
  
  Campaign _campaignSelected = CampaignGen.newObj(); 

  @override
  void initState() {
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
      bottomNavigationBar: SizedBox(height: 75, child:BottomAppBar(child: getBottomInfo(),)),
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
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _markedTreeList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color:(index%2 == 0 ) ? Colors.grey[50] : Colors.grey[350],
                child: ListTile(
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
                )
              );
            }
          ),
          ]
      
  ),
      
      endDrawer:  Drawer(child:  SettingsWidget()), 
      
      drawer: Drawer(child: CampaignWidget(
        onCamaignChange: _loadMarkedTreeFromCampaign,
      ),),
    );
    
  }



  void _loadMarkedTreeFromCampaign(int campaignId) async {
    CampaignGen.openObj(campaignId).then((campaign) {
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
    CampaignList.getAll(CampaignGen.COLUMN_CAMPAIGNDATE+" DESC").then((value) {
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
    
    int i = 0 ; 
    for (String key in speciesCount.keys)
    {
      dataRow.add(DataRow(color: ((i % 2) == 0) ? MaterialStateProperty.all(Colors.grey[100]):MaterialStateProperty.all(Colors.grey[350]),cells: [
        DataCell(Text(key)),
        DataCell(Text(speciesCount[key].toString())),
        DataCell(Text((speciesSv[key]??0.0).toStringAsFixed(2))),
        ]));
        i++;
    }
    
    dataRow.add(DataRow(cells: [
      DataCell(Text(speciesCount.length.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
      DataCell(Text(_markedTreeList.length.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
      DataCell(Text(sv.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold),))
    ]));

    return GestureDetector(
      onTap: () {   
        showModalBottomSheet(context: context,
          builder: (context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                //height: 200,
                color: Colors.grey,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text(AppLocalizations.of(context)!.species,style: TextStyle(fontStyle: FontStyle.italic),)),
                    DataColumn(label: Text(AppLocalizations.of(context)!.count,style: TextStyle(fontStyle: FontStyle.italic),)),
                    DataColumn(label: Text(AppLocalizations.of(context)!.sv,style: TextStyle(fontStyle: FontStyle.italic),)),
                  ],
                  rows: dataRow,
                    
                )
            );
          },
        );
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text("${AppLocalizations.of(context)!.species}: ${speciesCount.length}"),
          VerticalDivider(),
          Text("${AppLocalizations.of(context)!.count}: ${_markedTreeList.length}"),
          VerticalDivider(),
          Text("${AppLocalizations.of(context)!.sv}: ${sv.toStringAsFixed(2)}"),
          
        ],
      )
    );
  }

}
