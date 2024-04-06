


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treesmarking/businessObj/campaign.dart';

import '../businessObj/campaignList.dart';
import '../generate/businessObj/campaignGen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class CampaignWidget extends StatefulWidget {

  //List<Campaign> campaignList;
  
  final Function onCamaignChange; 

  CampaignWidget(
  {
    super.key,
    //required this.campaignList,
    //required this.selectedCampaignId,
    required this.onCamaignChange,
    
  });

  @override
  State<CampaignWidget> createState() => _CampaignWidgetState();
}





class _CampaignWidgetState extends State<CampaignWidget> {
  //final TextEditingController groupItemController = TextEditingController();
  //Offset _tapPosition = Offset.zero;
  int? selectedCampaignId;
  List<Campaign> campaignList = [];


  @override
  void initState() {
    loadCampaign();
    super.initState();
  }


  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      referenceBox.globalToLocal(details.globalPosition);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Wrap(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 40, left: 20),
            child: Text(
              AppLocalizations.of(context)!.campaign+" :",
              style: TextStyle(fontSize: 30),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: campaignList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTapDown: (details) => _getTapPosition(details),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(campaignList[index].name,
                      overflow: TextOverflow.ellipsis,),
                    Text(DateFormat("dd.MM.yyyy HH:mm").format(campaignList[index].campaignDate),
                      style: TextStyle(fontSize: 10),),
                  ]),
                  selected:
                      selectedCampaignId == campaignList[index].id,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedCampaignId = campaignList[index].id;
                      //widget.onListChange;
                      widget.onCamaignChange(campaignList[index].id);
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addCampaign();
        },
      ),
    );
  }

  addCampaign() {
    var textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.newCampaign),
        content: TextField(
          controller: textFieldController,
          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.campaignName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Campaign campaign = CampaignGen.newObj();
              campaign.name = textFieldController.text;
              campaign.save().then((value){
                //int tmpid = campaign.id ;
                widget.onCamaignChange(campaign.id);
                loadCampaign();
              });

              
              

              Navigator.pop(context, 'OK');
              
            },
            child: Text(AppLocalizations.of(context)!.oK),
          ),
        ],
      ),
    );
  }

  loadCampaign()
  {
    CampaignList.getAll(CampaignGen.COLUMN_CAMPAIGNDATE+" DESC").then((value) {
      setState(() {
        campaignList = value; 
      });
    });
  }
}

