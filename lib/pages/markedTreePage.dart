

import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/campaign.dart';
import 'package:treesmarking/businessObj/list/speciesList.dart';
import 'package:treesmarking/businessObj/list/trunkSizeList.dart';


import '../businessObj/markedTree.dart';

import '../businessObj/species.dart';
import '../businessObj/trunkSize.dart';
import '../generate/businessObj/markedTreeGen.dart';


class MarkedTreePage extends StatefulWidget {
  
  final MarkedTree markedTree;
  final Campaign campaign;

  MarkedTreePage({super.key, MarkedTree? marketTree, required this.campaign}):this.markedTree=marketTree ?? MarkedTreeGen.newObj();

  @override
  State<MarkedTreePage> createState() => _MarkedTreePageState();
}


class _MarkedTreePageState extends State<MarkedTreePage> {
  TextEditingController remarkController = TextEditingController();
  List<Species> speciesList = [];
  List<DropdownMenuItem<String>> speciesListDdm = [];

  List<TrunkSize> trunkSizeList = [] ; 
  List<DropdownMenuItem<String>> trunkSizeListDdm = [];

  @override
  void initState() {
    super.initState();
    remarkController.text = widget.markedTree.remark.toString();
    SpeciesList.getAll().then((value) {
print("initState markedTreePage SeciesList getall "); 
      setState(() {
        speciesList = value ;
        if (!speciesList.isEmpty)
        {
          speciesListDdm =  speciesList.map((value) {
        
            return DropdownMenuItem(
              value: value.id.toString(),
              child: Text(value.name)
            );
          }).toList();
          speciesListDdm.add(const DropdownMenuItem(value: "0",child: Text("Empty"),));
        };
      });
    });


    TrunkSizeList.getAll().then((value) {
      setState(() {
        trunkSizeList = value ;
        if (!trunkSizeList.isEmpty)
        {
print("test");
          trunkSizeListDdm =  trunkSizeList.map((value) {
        
            return DropdownMenuItem(
              value: value.id.toString(),
              child: Text(value.toString())
            );
          }).toList();
          trunkSizeListDdm.add(const DropdownMenuItem(value: "0",child: Text("Empty"),));
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Marked tree Page'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text("Species : "),
                DropdownButton(
                  value: widget.markedTree.speciesId.toString(),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.markedTree.speciesId = int.tryParse(value as String ) ?? 0 ;
                    });
                  },
                  items:speciesListDdm,
                ),
                  
                
              ],
            ),
            Row(
              children: [
                Text("Trunk size : "),
                DropdownButton(
                  value: widget.markedTree.trunkSizeId.toString(),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.markedTree.trunkSizeId = int.tryParse(value as String ) ?? 0 ;
                    });
                  },
                  items:trunkSizeListDdm,
                ),
                  
                
              ],
            ),

            Row(
              children: [
                Text("Remark : "),
                Flexible(
                  child: TextField(
                      controller: remarkController,
                      decoration: const InputDecoration(hintText: "Remark"), 
                    )
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
    widget.markedTree.remark = remarkController.text;
    widget.markedTree.campaignId = widget.campaign.id;
    widget.markedTree.save().then((value){
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.markedTree.delete();
    widget.markedTree.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}