import 'package:flutter/material.dart';

import '../businessObj/campaign.dart';
import '../generate/businessObj/campaignGen.dart';




class CampaignPage extends StatefulWidget {
  
  final Campaign campaign;

  CampaignPage({super.key, Campaign? campaign}):this.campaign=campaign ?? CampaignGen.newObj();

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}


class _CampaignPageState extends State<CampaignPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.campaign.name.toString();
    remarkController.text = widget.campaign.remark.toString();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Campaign Page'),
      ),
      body: Container(
        
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          children: [
            Row(
              children: [
                Text("Name : "),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "name"), 
                )
              ],
            ),
            Row(
              children: [
                Text("Date : "),
                Expanded(
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: "Date",
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)
                      )
                    ),
                    readOnly: true,
                  )
                )
              ],
            ),
            Row(
              children: [
                Text("Remark : "),
                TextField(
                  controller: remarkController,
                  decoration: const InputDecoration(hintText: "remark"), 
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  onTap: () {
                    _selectDate();
                  },
                )
                
              ],
            ),
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text("Save")),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text("Delete")),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text("Cancel")),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.campaign.name = nameController.text;
    widget.campaign.remark = remarkController.text;
    widget.campaign.save().then((value){

      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.campaign.delete();
    widget.campaign.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }


  Future<void> _selectDate() async {
    DateTime? _picked =  await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if (_picked != null)
    {
      setState(() {
        dateController.text = _picked.toString().split("")[0];
      });
    }
  }
}