import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treesmarking/businessObj/species.dart';

import '../generate/businessObj/speciesGen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SpeciesPage extends StatefulWidget {
  
  final Species species;

  SpeciesPage({super.key, Species? species}):this.species=species ?? SpeciesGen.newObj();

  @override
  State<SpeciesPage> createState() => _SpeciesPageState();
}


class _SpeciesPageState extends State<SpeciesPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.species.name.toString();
    codeController.text = widget.species.code.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.species),
      ),
      
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.name+" : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.speciesName), 
                    )
                )              
              ],
            ),
            Row(
              children: [
                Text("Abréviation : "),
                Flexible(
                  child: TextField(
                      controller: codeController,
                      decoration:  InputDecoration(hintText: "Abréviation"), 
                    )
                )              
              ],
            ),       
            Row(
              children: [
                Text("Type d'essence : "),
                Flexible(
                  child: ElevatedButton(onPressed: () {
                    setState(() {
                      widget.species.type = widget.species.type==Species.TYPE_LEAFY?Species.TYPE_SOFTWOOD:Species.TYPE_LEAFY;   
                    });
                    
                  }, 
                  child: Text(widget.species.type==Species.TYPE_LEAFY?"Feuillu":"Résineux"))
                )              
              ],
            ),     
            Row(
              children: [
                Text(AppLocalizations.of(context)!.communUse+" : "),
                Checkbox(
                  value: widget.species.communUse, 
                  onChanged: (value) {
                    setState(() {
                      widget.species.communUse = value ?? true; 
                    });
                  })
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
    widget.species.name = nameController.text;
    widget.species.code = codeController.text;

    widget.species.save().then((value){

      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.species.delete();
    widget.species.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}