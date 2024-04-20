

import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/campaign.dart';
import 'package:treesmarking/generate/businessObj/speciesGen.dart';



import '../businessObj/markedTree.dart';

import '../businessObj/species.dart';
import '../businessObj/speciesList.dart';
import '../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeList.dart';
import '../generate/businessObj/markedTreeGen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../generate/businessObj/trunkSizeGen.dart';



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
        title:  Text(AppLocalizations.of(context)!.markedTree),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.species+" : "),
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
                    if (int.tryParse(value as String ) != null)
                    {
                      SpeciesGen.openObj(int.tryParse(value) ?? 0).then((value) {
                        setState(() {
                          widget.markedTree.species = value;
                        });
                      });
                    }
                    
                  },
                  items:speciesListDdm,
                ),
                  
                
              ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.trunkSize+" : "),
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
                    if (int.tryParse(value as String ) != null)
                    {
                      TrunkSizeGen.openObj(int.tryParse(value) ?? 0).then((value) {
                        setState(() {
                          widget.markedTree.trunkSize = value;
                        });
                      });
                    }
                  },
                  items:trunkSizeListDdm,
                ),
                  
                
              ],
            ),

            Row(
              children: [
                Text(AppLocalizations.of(context)!.remark+" : "),
                Flexible(
                  child: TextField(
                      controller: remarkController,
                      decoration: InputDecoration(hintText: AppLocalizations.of(context)!.remark), 
                    )
                )              
              ],
            ),
           
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text(AppLocalizations.of(context)!.save)),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text(AppLocalizations.of(context)!.delete)),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text(AppLocalizations.of(context)!.cancel)),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.markedTree.remark = remarkController.text;
    widget.markedTree.campaign = widget.campaign;
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