import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../businessObj/campaign.dart';
import '../businessObj/campaignList.dart';
import '../generate/businessObj/campaignGen.dart';
import 'campaignPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'treeHammeringPage.dart';



class CampaignListPage extends StatefulWidget {
  const CampaignListPage({super.key});


  @override
  State<CampaignListPage> createState() => _CampaignListPageState();
}



class _CampaignListPageState extends State<CampaignListPage> {
  List<Campaign> _campaignList = [];
  

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
        title: Text(AppLocalizations.of(context)!.campaign),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addCampaign();
        },
      ),
      body:  Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _campaignList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => showCampaign(_campaignList[index]),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 5.0, top: 2.0, bottom: 2.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_campaignList[index].name
                          ,overflow: TextOverflow.ellipsis,),
                        Text(DateFormat("dd.MM.yyyy HH:mm").format(_campaignList[index].campaignDate),
                          style: TextStyle(fontSize: 10),),
                      ]
                    )
                  )
                    
                ) 
              );
            }
          ),
      ),
    );
  }
  

  showCampaign(Campaign campaign)
  {   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TreeHammeringPage(campaign :campaign))
    ).then((value){
      setState(() {
        _loadCampaign();
      });
    });
  }

  addCampaign() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TreeHammeringPage()  )
    ).then((value){
      setState(() {
        _loadCampaign();
      });
    });
  }
  
  
  void _loadCampaign() {
    CampaignList.getAll(CampaignGen.COLUMN_CAMPAIGNDATE+" DESC").then((value) {
      setState(() {
        _campaignList = value; 
      });
    });

  }
}