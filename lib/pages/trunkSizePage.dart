



import 'package:flutter/material.dart';

import '../businessObj/trunkSize.dart';

class TrunkSizePage extends StatefulWidget {
  
  final TrunkSize trunkSize;

  TrunkSizePage({super.key, TrunkSize? trunkSize}):this.trunkSize=trunkSize ?? TrunkSize.newObj();

  @override
  State<TrunkSizePage> createState() => _TrunkSizePageState();
}


class _TrunkSizePageState extends State<TrunkSizePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.trunkSize.name.toString();
    minController.text = widget.trunkSize.minDiameter.toString();
    maxController.text = widget.trunkSize.maxDiameter.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trunk size Page'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
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
            Row(
              children: [
                Text("Min dimeter  : "),
                Flexible(
                  child: TextField(
                      controller: minController,
                      decoration: const InputDecoration(hintText: "min diameter"), 
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
    widget.trunkSize.minDiameter = int.tryParse(minController.text) ?? 0;
    widget.trunkSize.maxDiameter = int.tryParse(maxController.text) ?? 0;
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