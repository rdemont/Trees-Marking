import 'package:flutter/material.dart';


import '../businessObj/trunkSize.dart';
import '../generate/businessObj/trunkSizeGen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TrunkSizePage extends StatefulWidget {
  
  final TrunkSize trunkSize;

  TrunkSizePage({super.key, TrunkSize? trunkSize}):this.trunkSize=trunkSize ?? TrunkSizeGen.newObj();

  @override
  State<TrunkSizePage> createState() => _TrunkSizePageState();
}


class _TrunkSizePageState extends State<TrunkSizePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.trunkSize.name.toString();
    minController.text = widget.trunkSize.minDiameter.toString();
    maxController.text = widget.trunkSize.maxDiameter.toString();
    volumeController.text = widget.trunkSize.volume.toString();
    codeController.text = widget.trunkSize.code.toString();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Text(AppLocalizations.of(context)!.trunkSize),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.code+" : "),
                Flexible(
                  child: TextField(
                      controller: codeController,
                      decoration: InputDecoration(hintText: AppLocalizations.of(context)!.code), 
                    )
                )              
              ],
            ),            
            
            Row(
              children: [
                Text(AppLocalizations.of(context)!.minDiameter+" : "),
                Flexible(
                  child: TextField(
                      controller: minController,
                      decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.maxDiameter), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.maxDiameter+" : "),
                Flexible(
                  child: TextField(
                      controller: maxController,
                      decoration:  InputDecoration(hintText: AppLocalizations.of(context)!.maxDiameter), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.volume+" : "),
                Flexible(
                  child: TextField(
                      controller: volumeController,
                      decoration: InputDecoration(hintText: AppLocalizations.of(context)!.volume), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),            
            Row(
              children: [
                Text(AppLocalizations.of(context)!.name+" : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: AppLocalizations.of(context)!.name), 
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
    widget.trunkSize.name = nameController.text;
    widget.trunkSize.minDiameter = double.tryParse(minController.text) ?? 0.0;
    widget.trunkSize.maxDiameter = double.tryParse(maxController.text) ?? 0.0;
    widget.trunkSize.volume = double.tryParse(volumeController.text) ?? 0.0;
    widget.trunkSize.code = codeController.text;
    widget.trunkSize.save().then((value){
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.trunkSize.delete();
    widget.trunkSize.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}