import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treesmarking/generate/businessObj/markedTreeGen.dart';
import 'package:treesmarking/generate/businessObj/markedTreeListGen.dart';
import 'package:treesmarking/pages/treeHammeringPage.dart';

import '../businessObj/campaign.dart';
import '../businessObj/markedTreeList.dart';
import '../generate/businessObj/campaignGen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class CampaignPage extends StatefulWidget {
  
  final Campaign campaign;

  CampaignPage({super.key, Campaign? campaign}):this.campaign=campaign ?? CampaignGen.newObj();

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}


class _CampaignPageState extends State<CampaignPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController yardController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool hasid = false ; 
  @override
  void initState() {
    super.initState();
    nameController.text = widget.campaign.name.toString();
    remarkController.text = widget.campaign.remark.toString();
    ownerController.text = widget.campaign.owner.toString();
    yardController.text = widget.campaign.yard.toString();
    dateController.text = DateFormat("dd.MM.yyyy HH:mm").format(widget.campaign.campaignDate);
    hasid = widget.campaign.id > 0 ; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Martelage"),
        actions: [
          IconButton(
            icon:Icon(Icons.forest),
            tooltip: "Marteler",
            onPressed: () {
              markedTree();
            },

          ),
          IconButton(
            icon:Icon(Icons.save),
            tooltip: "Sauver",
            onPressed: () {
              save();
            },
          ),  
          IconButton(
            icon:Icon(Icons.delete),
            tooltip: "Supprimer",
            onPressed: () {                        
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Alerte'),
                  content: const Text('Voulez-vous vraiment supprimer'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Annuler'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: (){ 
                        delete();
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),                    
        ],
      ),
      
      body: SingleChildScrollView(

        child: Column(
          children: [
            Row(
              children: [
                Text("Propriétaire : "),
                Expanded(
                  child:TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: ownerController,
                    decoration: InputDecoration(hintText: "Propriétaire"), 
                  )
                )
              ],
            ),
            Row(
              children: [
                Text("Chantier : "),
                Expanded(
                  child:TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: yardController,
                    decoration: InputDecoration(hintText: "Chantier"), 
                  )
                )
              ],
            ),

            Row(
              children: [
                Text("Martelage : "),
                Expanded(
                  child:TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Martelage"), 
                  )
                )
              ],
            ),

            Row(
              children: [
                Text(AppLocalizations.of(context)!.date+" : "),
                Expanded(
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      //labelText: "Date",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                      )
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                  )
                )
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.remark+" : "),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    controller: remarkController,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.remark), 
                    
                  )
                )
                
              ],
            ),
          ],
        )
      ),
      
       
    );
  }

  markedTree()
  {
    widget.campaign.name = nameController.text;
    widget.campaign.remark = remarkController.text;
    widget.campaign.owner = ownerController.text;
    widget.campaign.yard = yardController.text;
    widget.campaign.save().then((value){
      setState(() {
        hasid = widget.campaign.id > 0 ; 
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  TreeHammeringPage(campaign: widget.campaign,)));
    });

  }


  delete()
  {

    MarkedTreeList.getFromCampaign(widget.campaign.id).then((value) {
      for (int i = 0;i<value.length;i++)
      {
        value[i].delete();
        value[i].save(); 
      }
    },);
    widget.campaign.delete();
    widget.campaign.save().then((value){
      Navigator.pop(context);
    });

  }

  save(){
    widget.campaign.name = nameController.text;
    widget.campaign.remark = remarkController.text;
    widget.campaign.owner = ownerController.text;
    widget.campaign.yard = yardController.text;
    widget.campaign.save().then((value) {
      Navigator.pop(context);
    });
    
  }


  Future<void> _selectDate() async {
    DateTime? _picked =  await showDatePicker(
      context: context, 
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: widget.campaign.campaignDate,
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if (_picked != null)
    {
      setState(() {
        widget.campaign.campaignDate = _picked.add( Duration(hours:widget.campaign.campaignDate.hour,minutes: widget.campaign.campaignDate.minute ));
         
        dateController.text = DateFormat("dd.MM.yyyy HH:mm").format(widget.campaign.campaignDate);
      });
    }
  }
}