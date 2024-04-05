import 'package:flutter/material.dart';


import '../businessObj/trunkSize.dart';
import '../generate/businessObj/trunkSizeGen.dart';


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
        title: const Text('Trunk size Page'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text("Code : "),
                Flexible(
                  child: TextField(
                      controller: codeController,
                      decoration: const InputDecoration(hintText: "Trunk size code"), 
                    )
                )              
              ],
            ),            
            
            Row(
              children: [
                Text("Min dimeter  : "),
                Flexible(
                  child: TextField(
                      controller: minController,
                      decoration: const InputDecoration(hintText: "min diameter"), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),
            Row(
              children: [
                Text("Max dimeter  : "),
                Flexible(
                  child: TextField(
                      controller: maxController,
                      decoration: const InputDecoration(hintText: "max diameter"), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),
            Row(
              children: [
                Text("Volume  : "),
                Flexible(
                  child: TextField(
                      controller: volumeController,
                      decoration: const InputDecoration(hintText: "Volume"), 
                      keyboardType: TextInputType.number,
                    )
                )      
                ],
            ),            
            Row(
              children: [
                Text("Name : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Trunk size name"), 
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